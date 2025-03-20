import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TagsController extends GetxController {
  // Selected tag information
  var selectedTag = {}.obs;
  
  // Mock data for all tags
  var allTags = <Map<String, dynamic>>[].obs;
  
  // Mock data for posts with the selected tag
  var taggedPosts = <Map<String, dynamic>>[].obs;
  
  // Loading states
  var isLoading = false.obs;
  var isSearching = false.obs;
  
  // Search controller
  final TextEditingController searchController = TextEditingController();
  
  @override
  void onInit() {
    super.onInit();
    loadAllTags();
  }
  
  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
  
  // Method to set the selected tag and load related posts
  void selectTag(Map<String, dynamic> tag) {
    selectedTag.value = tag;
    loadPostsByTag(tag['tags_id']);
  }
  
  // Load all available tags - mock data
  void loadAllTags() {
    isLoading.value = true;
    
    // Simulating API call with mock data
    Future.delayed(const Duration(milliseconds: 800), () {
      allTags.value = [
        {'tags_id': '1', 'tags_name': 'Beach'},
        {'tags_id': '2', 'tags_name': 'Mountain'},
        {'tags_id': '3', 'tags_name': 'Culinary'},
        {'tags_id': '4', 'tags_name': 'Culture'},
        {'tags_id': '5', 'tags_name': 'Historical'},
        {'tags_id': '6', 'tags_name': 'Nature'},
        {'tags_id': '7', 'tags_name': 'Adventure'},
        {'tags_id': '8', 'tags_name': 'Family'},
      ];
      
      isLoading.value = false;
    });
  }
  
  // Load posts by tag ID - mock data
  void loadPostsByTag(String tagId) {
    isLoading.value = true;
    
    // Simulate API call with delay
    Future.delayed(const Duration(seconds: 1), () {
      // Generate mock posts based on tag ID
      taggedPosts.value = _generateMockPosts(tagId);
      isLoading.value = false;
    });
  }
  
  // Search posts by keyword within selected tag
  void searchPostsByKeyword(String keyword) {
    // Always show the "Hapus Pencarian" button when a search is performed
    isSearching.value = true;
    
    if (keyword.isEmpty) {
      // If search is cleared, load all posts for the tag
      loadPostsByTag(selectedTag['tags_id']);
      return;
    }
    
    // Simulate API call with delay
    Future.delayed(const Duration(milliseconds: 800), () {
      // Filter mock posts based on keyword
      final allPosts = _generateMockPosts(selectedTag['tags_id']);
      
      taggedPosts.value = allPosts.where((post) => 
        post['post_title'].toString().toLowerCase().contains(keyword.toLowerCase()) ||
        post['post_short'].toString().toLowerCase().contains(keyword.toLowerCase())
      ).toList();
    });
  }
  
  // Clear search results and reset search form
  void clearSearch() {
    searchController.clear();
    isSearching.value = false;
    loadPostsByTag(selectedTag['tags_id']);
  }
  
  // Helper method to generate mock posts based on tag ID
  List<Map<String, dynamic>> _generateMockPosts(String tagId) {
    // Base posts that will be shown for all tags
    final List<Map<String, dynamic>> basePosts = [
      {
        'post_id': '101',
        'post_title': 'Amazing Local Experience',
        'post_short': 'Discover hidden gems in the local area',
        'img': [
          {'images_file': 'assets/img/post1.jpg'}
        ],
        'venue': {
          'venue_x_coordinat': '-6.9855',
          'venue_y_coordinat': '110.4088'
        }
      },
      {
        'post_id': '102',
        'post_title': 'Weekend Getaway',
        'post_short': 'Perfect short vacation spot for everyone',
        'img': [
          {'images_file': 'assets/img/post2.jpg'}
        ],
        'venue': {
          'venue_x_coordinat': '-6.9820',
          'venue_y_coordinat': '110.4110'
        }
      },
    ];
    
    // Tag-specific posts
    final Map<String, List<Map<String, dynamic>>> tagSpecificPosts = {
      '1': [ // Beach
        {
          'post_id': '201',
          'post_title': 'Sunset Beach Resort',
          'post_short': 'Enjoy breathtaking sunsets at this pristine beach',
          'img': [
            {'images_file': 'assets/img/beach1.jpg'}
          ],
          'venue': {
            'venue_x_coordinat': '-6.8855',
            'venue_y_coordinat': '110.3088'
          }
        },
        {
          'post_id': '202',
          'post_title': 'Coral Bay Diving Spot',
          'post_short': 'Explore vibrant marine life in crystal clear waters',
          'img': [
            {'images_file': 'assets/img/beach2.jpg'}
          ],
          'venue': {
            'venue_x_coordinat': '-6.8920',
            'venue_y_coordinat': '110.3210'
          }
        },
      ],
      '2': [ // Mountain
        {
          'post_id': '301',
          'post_title': 'Misty Mountain Trek',
          'post_short': 'Challenging trails with rewarding views',
          'img': [
            {'images_file': 'assets/img/mountain1.jpg'}
          ],
          'venue': {
            'venue_x_coordinat': '-7.0855',
            'venue_y_coordinat': '110.5088'
          }
        },
        {
          'post_id': '302',
          'post_title': 'Alpine Meadow Camping',
          'post_short': 'Camp under the stars surrounded by mountain peaks',
          'img': [
            {'images_file': 'assets/img/mountain2.jpg'}
          ],
          'venue': {
            'venue_x_coordinat': '-7.0920',
            'venue_y_coordinat': '110.5210'
          }
        },
      ],
      '3': [ // Culinary
        {
          'post_id': '401',
          'post_title': 'Traditional Food Market',
          'post_short': 'Sample local delicacies at this bustling market',
          'img': [
            {'images_file': 'assets/img/food1.jpg'}
          ],
          'venue': {
            'venue_x_coordinat': '-6.9255',
            'venue_y_coordinat': '110.4288'
          }
        },
        {
          'post_id': '402',
          'post_title': 'Heritage Coffee House',
          'post_short': 'Experience traditional coffee brewing methods',
          'img': [
            {'images_file': 'assets/img/food2.jpg'}
          ],
          'venue': {
            'venue_x_coordinat': '-6.9320',
            'venue_y_coordinat': '110.4410'
          }
        },
      ],
    };
    
    // Combine base posts with tag-specific posts
    final result = [...basePosts];
    
    if (tagSpecificPosts.containsKey(tagId)) {
      result.addAll(tagSpecificPosts[tagId]!);
    }
    
    return result;
  }
}