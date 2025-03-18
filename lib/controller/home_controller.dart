// import 'package:get/get.dart';
// import 'package:flutter/material.dart';

// // Import model classes with prefixes to avoid naming conflicts
// import '../models/banner_response.dart' as banner;
// import '../models/boarding_response.dart' as boarding;
// import '../models/home_response.dart' as home;
// import '../services/api.dart';

// class HomeController extends GetxController {
//   final ApiClient apiClient = Get.find<ApiClient>();

//   // Loading state
//   final RxBool isLoading = true.obs;

//   // Data states
//   final Rx<banner.BannerResponse> bannerResponse = banner.BannerResponse().obs;
//   final Rx<boarding.BoardingResponse> boardingResponse = boarding.BoardingResponse().obs;
//   final Rx<home.HomeResponse> homeResponse = home.HomeResponse().obs;

//   // Additional data states for different sections
//   final RxList<Map<String, dynamic>> wisataItems = <Map<String, dynamic>>[].obs;
//   final RxList<Map<String, dynamic>> jelajahItems = <Map<String, dynamic>>[].obs;
//   final RxList<Map<String, dynamic>> kulinerItems = <Map<String, dynamic>>[].obs;
//   final RxList<Map<String, dynamic>> eventItems = <Map<String, dynamic>>[].obs;
//   final RxList<Map<String, dynamic>> penginapanItems = <Map<String, dynamic>>[].obs;
//   final RxList<String> tagsList = <String>[].obs;
//   final RxList<Map<String, dynamic>> categories = <Map<String, dynamic>>[].obs;

//   // Search state
//   final RxString searchQuery = ''.obs;
//   final RxBool isSearching = false.obs;
//   final RxList<Map<String, dynamic>> searchResults = <Map<String, dynamic>>[].obs;

//   // Error states
//   final RxBool hasBannerError = false.obs;
//   final RxBool hasBoardingError = false.obs;
//   final RxBool hasHomeError = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     // Initialize categories
//     categories.value = [
//       {'name': 'Wisata', 'icon': Icons.beach_access},
//       {'name': 'Kuliner', 'icon': Icons.restaurant},
//       {'name': 'Hotel', 'icon': Icons.hotel},
//       {'name': 'Event', 'icon': Icons.event},
//       {'name': 'Olahraga', 'icon': Icons.sports_soccer},
//     ];

//     // Initialize tags
//     tagsList.value = ['Pantai', 'Kuliner', 'Hotel', 'Gunung', 'Sejarah', 'Keluarga'];

//     fetchAllData();
//   }

//   Future<void> fetchAllData() async {
//     isLoading.value = true;

//     try {
//       await Future.wait([fetchBanners(), fetchBoardings(), fetchHomeData()]);

//       // Initialize sample data for all sections after API calls
//       _initializeSampleData();
//     } catch (e) {
//       debugPrint('Error fetching data: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   void _initializeSampleData() {
//     // Sample wisata data
//     wisataItems.value = [
//       {'title': 'Pantai Alam Indah', 'image': 'assets/img/background_3.png'},
//       {'title': 'Gunung Slamet', 'image': 'assets/img/background_3.png'},
//       {'title': 'Pemandian Air Panas', 'image': 'assets/img/background_3.png'},
//     ];

//     // Sample jelajah data
//     jelajahItems.value = [
//       {'title': 'Alun-alun Tegal', 'image': 'assets/img/background_3.png'},
//       {'title': 'Taman Poci', 'image': 'assets/img/background_3.png'},
//       {'title': 'Pelabuhan Tegal', 'image': 'assets/img/background_3.png'},
//     ];

//     // Sample kuliner data
//     kulinerItems.value = [
//       {'title': 'Tahu Aci', 'image': 'assets/img/background_3.png'},
//       {'title': 'Sate Blengong', 'image': 'assets/img/background_3.png'},
//       {'title': 'Kupat Glabed', 'image': 'assets/img/background_3.png'},
//     ];

//     // Sample event data
//     eventItems.value = [
//       {
//         'title': 'Festival Tegal Bahari',
//         'short': 'Acara tahunan untuk memperingati budaya bahari',
//         'image': 'assets/img/background_3.png',
//       },
//       {
//         'title': 'Karnaval Budaya',
//         'short': 'Pameran kesenian dan budaya Tegal',
//         'image': 'assets/img/background_3.png',
//       },
//     ];

//     // Sample penginapan data
//     penginapanItems.value = [
//       {
//         'title': 'Hotel Bahari Inn',
//         'address': 'Jl. Pemuda No. 10, Tegal',
//         'rating': '4.5',
//         'reviews': '120',
//         'price': '350000',
//         'type': 'per malam',
//         'image': 'assets/img/background_3.png',
//       },
//       {
//         'title': 'Prime Plaza Hotel',
//         'address': 'Jl. Ahmad Yani No. 23, Tegal',
//         'rating': '4.7',
//         'reviews': '87',
//         'price': '450000',
//         'type': 'per malam',
//         'image': 'assets/img/background_3.png',
//       },
//       {
//         'title': 'Homestay Tegal',
//         'address': 'Jl. Diponegoro No. 5, Tegal',
//         'rating': '4.2',
//         'reviews': '45',
//         'price': '250000',
//         'type': 'per malam',
//         'image': 'assets/img/background_3.png',
//       },
//     ];
//   }

//   Future<void> fetchBanners() async {
//     try {
//       hasBannerError.value = false;
//       final response = await apiClient.getData('/api/banner/all');

//       // Process response even if res is false
//       bannerResponse.value = banner.BannerResponse.fromJson(response);

//       // Log for debugging
//       debugPrint('Banner response processed: ${bannerResponse.value.msg}');
//       debugPrint('Banner data count: ${bannerResponse.value.data?.length ?? 0}');

//       // If we get an "Api tidak valid" message but it's a valid response format
//       if (bannerResponse.value.res == false && bannerResponse.value.msg == "Api tidak valid") {
//         debugPrint('Banner API reported invalid, but continuing with UI display');
//       }
//     } catch (e) {
//       hasBannerError.value = true;
//       debugPrint('Error fetching banners: $e');
//     }
//   }

//   Future<void> fetchBoardings() async {
//     try {
//       hasBoardingError.value = false;
//       final response = await apiClient.getData('/api/boarding');

//       // Process response even if res is false
//       boardingResponse.value = boarding.BoardingResponse.fromJson(response);

//       // Log for debugging
//       debugPrint('Boarding response processed: ${boardingResponse.value.msg}');
//       debugPrint('Boarding data count: ${boardingResponse.value.data?.length ?? 0}');

//       // If we get an "Api tidak valid" message but it's a valid response format
//       if (boardingResponse.value.res == false && boardingResponse.value.msg == "Api tidak valid") {
//         debugPrint('Boarding API reported invalid, but continuing with UI display');
//       }
//     } catch (e) {
//       hasBoardingError.value = true;
//       debugPrint('Error fetching boardings: $e');
//     }
//   }

//   Future<void> fetchHomeData() async {
//     try {
//       hasHomeError.value = false;
//       final response = await apiClient.getData('/api/home');

//       // Process response even if res is false
//       homeResponse.value = home.HomeResponse.fromJson(response);

//       // Log for debugging
//       debugPrint('Home response processed: ${homeResponse.value.msg}');
//       debugPrint('Home data count: ${homeResponse.value.data?.length ?? 0}');

//       // If we get an "Api tidak valid" message but it's a valid response format
//       if (homeResponse.value.res == false && homeResponse.value.msg == "Api tidak valid") {
//         debugPrint('Home API reported invalid, but continuing with UI display');
//       }
//     } catch (e) {
//       hasHomeError.value = true;
//       debugPrint('Error fetching home data: $e');
//     }
//   }

//   void refreshData() async {
//     isLoading.value = true;
//     await fetchAllData();
//   }

//   void searchDestinations(String query) {
//     searchQuery.value = query;

//     if (query.isEmpty) {
//       isSearching.value = false;
//       searchResults.clear();
//       return;
//     }

//     isSearching.value = true;

//     // Combine all items for search
//     final allItems = [
//       ...wisataItems,
//       ...jelajahItems,
//       ...kulinerItems,
//       ...eventItems.map((e) => {'title': e['title'], 'image': e['image']}),
//       ...penginapanItems.map((e) => {'title': e['title'], 'image': e['image']}),
//     ];

//     // Filter based on query
//     searchResults.value =
//         allItems
//             .where((item) => item['title'].toString().toLowerCase().contains(query.toLowerCase()))
//             .toList();
//   }

//   // Getters
//   List<banner.Data> get banners => bannerResponse.value.data ?? [];
//   List<boarding.Data> get boardings => boardingResponse.value.data ?? [];
//   List<home.Data> get homeCategories => homeResponse.value.data ?? [];

//   bool get hasAnyError => hasBannerError.value || hasBoardingError.value || hasHomeError.value;
// }
