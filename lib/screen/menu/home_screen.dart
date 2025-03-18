import 'package:carousel_custom_slider/carousel_custom_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hai_tegal_getx/components/colors.dart';
import 'package:hai_tegal_getx/controller/detail_post_controller.dart';
import 'package:hai_tegal_getx/screen/home/detail_post_screen.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate API loading delay
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  // Refresh data and show shimmer again
  Future<void> _refreshData() async {
    setState(() {
      isLoading = true;
    });

    // Simulate API loading delay
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshData,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBannerSection(context),
                    SizedBox(height: 0.05 * MediaQuery.of(context).size.height),
                    _buildSearchResultsSection(context),
                    _buildCategoriesSection(context),
                    SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
                    _buildWisataSection(context),
                    SizedBox(height: 0.05 * MediaQuery.of(context).size.height),
                    _buildJelajahSection(context),
                    SizedBox(height: 0.05 * MediaQuery.of(context).size.height),
                    _buildKulinerSection(context),
                    SizedBox(height: 0.05 * MediaQuery.of(context).size.height),
                    _buildEventSection(context),
                    SizedBox(height: 0.05 * MediaQuery.of(context).size.height),
                    _buildTagsSection(context),
                    SizedBox(height: 0.05 * MediaQuery.of(context).size.height),
                    _buildPenginapanSection(context),
                    SizedBox(height: 0.1 * MediaQuery.of(context).size.height),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerSection(BuildContext context) {
    // Sample banner images
    final List<String> bannerImages = [
      'assets/img/default_post.jpg',
      'assets/img/default_post.jpg',
      'assets/img/default_post.jpg',
    ];

    return SizedBox(
      height: 0.4 * MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          // Show shimmer or banner carousel
          isLoading
              ? ShimmerEffects.bannerShimmer(context)
              : CarouselCustomSlider(
                initialPage: 0,
                isDisplayIndicator: false,
                allowImplicitScrolling: true,
                backgroundColor: WAPrimaryColor1,
                doubleTapZoom: true,
                clipBehaviorZoom: true,
                autoPlay: true,
                height: 0.4 * MediaQuery.of(context).size.height,
                sliderList: bannerImages,
                fitPic: BoxFit.cover,
              ),
          Padding(
            padding: EdgeInsets.only(
              top: 0.03 * MediaQuery.of(context).size.height,
              left: 0.08 * MediaQuery.of(context).size.width,
              right: 0.08 * MediaQuery.of(context).size.width,
            ),
            child: Material(
              elevation: 20.0,
              shadowColor: WADarkColor,
              color: Colors.transparent,
              child: TextField(
                autofocus: false,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: WADarkColor,
                ),
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      // Static implementation - no search
                    },
                    child: const Icon(Icons.search, color: WASecondary),
                  ),
                  border: InputBorder.none,
                  hintText: 'Mau jalan-jalan kemana hari ini ?',
                  hintStyle: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: WADarkColor.withOpacity(0.3),
                  ),
                  filled: true,
                  fillColor: WALightColor,
                  contentPadding: const EdgeInsets.symmetric(vertical: 11, horizontal: 20),
                  focusedBorder: OutlineInputBorder(
                    gapPadding: 0.3,
                    borderSide: const BorderSide(color: WASecondary),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: WALightColor),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResultsSection(BuildContext context) {
    // Static search results - empty by default
    return const SizedBox();
  }

  Widget _buildCategoriesSection(BuildContext context) {
    // Sample category data
    final List<Map<String, dynamic>> categories = [
      {'name': 'Berita', 'icon': Icons.newspaper},
      {'name': 'Event', 'icon': Icons.event_note},
      {'name': 'Featured Trip', 'icon': Icons.tour},
      {'name': 'Kuliner', 'icon': Icons.restaurant_menu},
      {'name': 'Penginapan', 'icon': Icons.hotel},
      {'name': 'Resto', 'icon': Icons.dinner_dining},
      {'name': 'Wisata Tegal', 'icon': Icons.landscape},
    ];

    return isLoading
        ? ShimmerEffects.categoryShimmerSection(context)
        : Container(
          padding: EdgeInsets.symmetric(horizontal: 0.05 * MediaQuery.of(context).size.width),
          height: 0.15 * MediaQuery.of(context).size.height,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Static implementation - just navigate
                  // Navigator.pushNamed(context, '/category');
                },
                child: SizedBox(
                  width: 0.2 * MediaQuery.of(context).size.width,
                  height: 0.2 * MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 0.16 * MediaQuery.of(context).size.width,
                        height: 0.15 * MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: WAInfo2Color.withOpacity(0.3),
                        ),
                        child: Icon(categories[index]['icon'], color: WAInfo2Color, size: 30),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        categories[index]['name'],
                        style: GoogleFonts.sourceSans3(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: WAInfo2Color,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
  }

  Widget _buildWisataSection(BuildContext context) {
    // Sample wisata data
    final List<Map<String, dynamic>> wisataItems = [
      {'title': 'Pantai Alam Indah', 'image': 'assets/img/default_post.jpg'},
      {'title': 'Gunung Slamet', 'image': 'assets/img/default_post.jpg'},
      {'title': 'Pemandian Air Panas', 'image': 'assets/img/default_post.jpg'},
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isLoading
              ? ShimmerEffects.sectionTitleShimmer(context)
              : Text(
                'Wisata yang lagi hitz',
                style: GoogleFonts.montserrat(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: WADarkColor,
                ),
              ),
          const SizedBox(height: 5),
          SizedBox(
            height: 0.2 * MediaQuery.of(context).size.height,
            child:
                isLoading
                    ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder:
                          (context, index) => ShimmerEffects.horizontalPostItemShimmer(context),
                    )
                    : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: wisataItems.length,
                      itemBuilder: (context, index) {
                        return _buildBannerPostItem(context, wisataItems[index]);
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildJelajahSection(BuildContext context) {
    // Sample jelajah data
    final List<Map<String, dynamic>> jelajahItems = [
      {'title': 'Alun-alun Tegal', 'image': 'assets/img/default_post.jpg'},
      {'title': 'Taman Poci', 'image': 'assets/img/default_post.jpg'},
      {'title': 'Pelabuhan Tegal', 'image': 'assets/img/default_post.jpg'},
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isLoading
              ? ShimmerEffects.sectionTitleShimmer(context)
              : Text(
                'Jelajahi Alam',
                style: GoogleFonts.montserrat(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: WADarkColor,
                ),
              ),
          const SizedBox(height: 5),
          SizedBox(
            height: 0.3 * MediaQuery.of(context).size.height,
            child:
                isLoading
                    ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder:
                          (context, index) => ShimmerEffects.verticalPostItemShimmer(context),
                    )
                    : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: jelajahItems.length,
                      itemBuilder: (context, index) {
                        return _buildVerticalPostItem(context, jelajahItems[index]);
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildKulinerSection(BuildContext context) {
    // Sample kuliner data
    final List<Map<String, dynamic>> kulinerItems = [
      {'title': 'Tahu Aci', 'image': 'assets/img/default_post.jpg'},
      {'title': 'Sate Blengong', 'image': 'assets/img/default_post.jpg'},
      {'title': 'Kupat Glabed', 'image': 'assets/img/default_post.jpg'},
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isLoading
              ? ShimmerEffects.sectionTitleShimmer(context)
              : Text(
                'Kuliner Kekinian',
                style: GoogleFonts.montserrat(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: WADarkColor,
                ),
              ),
          const SizedBox(height: 5),
          SizedBox(
            height: 0.25 * MediaQuery.of(context).size.height,
            child:
                isLoading
                    ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder:
                          (context, index) => ShimmerEffects.horizontalPostItemShimmer(context),
                    )
                    : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: kulinerItems.length,
                      itemBuilder: (context, index) {
                        return _buildBannerPostItem(context, kulinerItems[index]);
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventSection(BuildContext context) {
    // Sample event data
    final List<Map<String, dynamic>> eventItems = [
      {
        'title': 'Festival Tegal Bahari',
        'short': 'Acara tahunan untuk memperingati budaya bahari',
        'image': 'assets/img/default_post.jpg',
      },
      {
        'title': 'Karnaval Budaya',
        'short': 'Pameran kesenian dan budaya Tegal',
        'image': 'assets/img/default_post.jpg',
      },
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isLoading
              ? ShimmerEffects.sectionTitleShimmer(context)
              : Text(
                'Event Terbaru',
                style: GoogleFonts.montserrat(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: WADarkColor,
                ),
              ),
          const SizedBox(height: 5),
          SizedBox(
            height: 0.32 * MediaQuery.of(context).size.height,
            child:
                isLoading
                    ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
                      itemBuilder: (context, index) => ShimmerEffects.eventCardShimmer(context),
                    )
                    : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: eventItems.length,
                      itemBuilder: (context, index) {
                        return _buildEventPostItem(context, eventItems[index]);
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagsSection(BuildContext context) {
    // Sample tags
    final List<String> tags = [
      'Agrowisata',
      'Air Panas',
      'Air Terjun',
      'Autentik',
      'Ayam Goreng',
      'Batik',
      'Berkuda',
      'Bioskop',
    ];

    return isLoading
        ? ShimmerEffects.tagsShimmer(context)
        : Container(
          width: MediaQuery.of(context).size.width,
          height: 0.05 * MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 20),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tags.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context, '/tags');
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 0.03 * MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    border: Border.all(color: WATagColor, width: 1),
                    color: WALightColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      tags[index],
                      style: GoogleFonts.sourceSans3(
                        fontSize: 14,
                        color: WATagColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
  }

  Widget _buildPenginapanSection(BuildContext context) {
    // Sample penginapan data
    final List<Map<String, dynamic>> penginapanItems = [
      {
        'title': 'Hotel Bahari Inn',
        'address': 'Jl. Pemuda No. 10, Tegal',
        'rating': '4.5',
        'reviews': '120',
        'price': '350000',
        'type': 'per malam',
        'image': 'assets/img/default_post.jpg',
      },
      {
        'title': 'Prime Plaza Hotel',
        'address': 'Jl. Ahmad Yani No. 23, Tegal',
        'rating': '4.7',
        'reviews': '87',
        'price': '450000',
        'type': 'per malam',
        'image': 'assets/img/default_post.jpg',
      },
      {
        'title': 'Homestay Tegal',
        'address': 'Jl. Diponegoro No. 5, Tegal',
        'rating': '4.2',
        'reviews': '45',
        'price': '250000',
        'type': 'per malam',
        'image': 'assets/img/default_post.jpg',
      },
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isLoading
              ? ShimmerEffects.sectionTitleShimmer(context)
              : Text(
                'Penginapan Murah',
                style: GoogleFonts.montserrat(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: WADarkColor,
                ),
              ),
          const SizedBox(height: 5),
          isLoading
              ? Column(
                children: List.generate(
                  3,
                  (index) => ShimmerEffects.penginapanItemShimmer(context),
                ),
              )
              : Column(
                children: List.generate(
                  penginapanItems.length,
                  (index) => _buildPenginapanItem(context, penginapanItems[index]),
                ),
              ),
        ],
      ),
    );
  }

  // Helper methods to build repeated UI components with static data
  Widget _buildBannerPostItem(BuildContext context, Map<String, dynamic> post) {
    return GestureDetector(
      onTap: () {
        // Create a post data map with necessary fields for DetailPostScreen
        final postData = {
          "post_id": "static_${post['title'].toString().toLowerCase().replaceAll(' ', '_')}",
          "post_title": post['title'],
          "post_short":
              "This is a static description for ${post['title']}. Navigate back to see more content.",
          "img": [
            {"images_file": post['image']},
          ],
          // Add venue data for map display
          "venue": {
            "venue_id": "v1",
            "venue_addr": "Location of ${post['title']}, Tegal",
            "venue_x_coordinat": "-6.8543", // Default coordinates for Tegal
            "venue_y_coordinat": "109.1425",
          },
          "village": {"village_nm": "Tegal"},
          "district": {"district_nm": "Tegal"},
          "city": {"city_nm": "Tegal"},
          // Add minimal required data
          "total_review": 10,
          "total_index": 5,
          "average_rating": 4,
        };

        // Create a controller instance and set the post data
        final detailController = Get.put(DetailPostController());
        detailController.isLoading.value = true;

        // Add short delay to show loading effect
        Future.delayed(Duration(milliseconds: 300), () {
          detailController.post.value = postData;
          detailController.isLoading.value = false;
        });

        // Navigate to detail screen
        Get.to(() => DetailPostScreen());
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: 0.2 * MediaQuery.of(context).size.height,
        width: 0.8 * MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(image: AssetImage(post['image']), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Text(
            post['title'],
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: WALightColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVerticalPostItem(BuildContext context, Map<String, dynamic> post) {
    return GestureDetector(
      onTap: () {
        // Create a post data map with necessary fields
        final postData = {
          "post_id": "static_${post['title'].toString().toLowerCase().replaceAll(' ', '_')}",
          "post_title": post['title'],
          "post_short":
              "This is a detailed description about ${post['title']}. This location is one of the popular destinations in Tegal.",
          "img": [
            {"images_file": post['image']},
          ],
          "venue": {
            "venue_id": "v1",
            "venue_addr": "Jalan ${post['title']}, Tegal",
            "venue_x_coordinat": "-6.8543",
            "venue_y_coordinat": "109.1425",
          },
          "village": {"village_nm": "Tegal"},
          "district": {"district_nm": "Tegal"},
          "city": {"city_nm": "Tegal"},
          "category": [
            {"category_id": "c1", "category_name": "Wisata Alam"},
            {"category_id": "c2", "category_name": "Rekreasi"},
          ],
          "total_review": 15,
          "total_index": 7,
          "average_rating": 4.5,
        };

        // Setup controller and navigate
        final detailController = Get.put(DetailPostController());
        detailController.isLoading.value = true;

        Future.delayed(Duration(milliseconds: 300), () {
          detailController.post.value = postData;
          detailController.isLoading.value = false;
        });

        Get.to(() => DetailPostScreen());
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: 0.3 * MediaQuery.of(context).size.height,
        width: 0.4 * MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(image: AssetImage(post['image']), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20, top: 0.2 * MediaQuery.of(context).size.height),
          child: Text(
            post['title'],
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: WALightColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventPostItem(BuildContext context, Map<String, dynamic> post) {
    return GestureDetector(
      onTap: () {
        final postData = {
          "post_id": "static_${post['title'].toString().toLowerCase().replaceAll(' ', '_')}",
          "post_title": post['title'],
          "post_short": post['short'],
          "img": [
            {"images_file": post['image']},
          ],
          "venue": {
            "venue_id": "v1",
            "venue_addr": "Lokasi Event ${post['title']}, Tegal",
            "venue_x_coordinat": "-6.8543",
            "venue_y_coordinat": "109.1425",
          },
          "village": {"village_nm": "Tegal"},
          "district": {"district_nm": "Tegal"},
          "city": {"city_nm": "Tegal"},
          // Add event data
          "event": [
            {
              "event_location": post['title'],
              "event_start_date": "2025-04-15",
              "event_end_date": "2025-04-17",
              "event_poster_img": post['image'],
            },
          ],
          "total_review": 8,
          "total_index": 4,
          "average_rating": 4.2,
        };

        final detailController = Get.put(DetailPostController());
        detailController.isLoading.value = true;

        Future.delayed(Duration(milliseconds: 300), () {
          detailController.post.value = postData;
          detailController.isLoading.value = false;
        });

        Get.to(() => DetailPostScreen());
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            height: 0.3 * MediaQuery.of(context).size.height,
            width: 0.7 * MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: WASecondary),
              boxShadow: [
                BoxShadow(
                  color: WADarkColor.withOpacity(0.6),
                  blurRadius: 2,
                  blurStyle: BlurStyle.inner,
                  offset: const Offset(4, 8),
                ),
              ],
              image: DecorationImage(image: AssetImage(post['image']), fit: BoxFit.cover),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            margin: EdgeInsets.only(
              left: 5,
              right: 5,
              top: 0.22 * MediaQuery.of(context).size.height,
            ),
            height: 0.08 * MediaQuery.of(context).size.height,
            width: 0.7 * MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: WALightColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post['title'],
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: WADarkColor,
                  ),
                ),
                Text(
                  post['short'],
                  maxLines: 1,
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: WADarkColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPenginapanItem(BuildContext context, Map<String, dynamic> post) {
    return GestureDetector(
      onTap: () {
        final postData = {
          "post_id": "static_${post['title'].toString().toLowerCase().replaceAll(' ', '_')}",
          "post_title": post['title'],
          "post_short":
              "Penginapan nyaman di ${post['address']}. Fasilitas lengkap dengan harga terjangkau.",
          "img": [
            {"images_file": post['image']},
          ],
          "venue": {
            "venue_id": "v1",
            "venue_addr": post['address'],
            "venue_x_coordinat": "-6.8543",
            "venue_y_coordinat": "109.1425",
          },
          "village": {"village_nm": "Tegal"},
          "district": {"district_nm": "Tegal"},
          "city": {"city_nm": "Tegal"},
          // Add cost data for hotels
          "cost": [
            {"cost_name": post['type'], "cost_price": post['price']},
          ],
          // Add operational hours
          "venue_hours": [
            {"operational_day": "1", "operational_open": "07:00", "operational_closed": "22:00"},
            {"operational_day": "2", "operational_open": "07:00", "operational_closed": "22:00"},
            {"operational_day": "3", "operational_open": "07:00", "operational_closed": "22:00"},
            {"operational_day": "4", "operational_open": "07:00", "operational_closed": "22:00"},
            {"operational_day": "5", "operational_open": "07:00", "operational_closed": "22:00"},
            {"operational_day": "6", "operational_open": "07:00", "operational_closed": "22:00"},
            {"operational_day": "7", "operational_open": "07:00", "operational_closed": "22:00"},
          ],
          "total_review": int.parse(post['reviews']),
          "total_index": int.parse(post['reviews']) ~/ 2,
          "average_rating": double.parse(post['rating']),
        };

        final detailController = Get.put(DetailPostController());
        detailController.isLoading.value = true;

        Future.delayed(Duration(milliseconds: 300), () {
          detailController.post.value = postData;
          detailController.isLoading.value = false;
        });

        Get.to(() => DetailPostScreen());
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, right: 10),
        padding: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: WASecondary),
        ),
        width: MediaQuery.of(context).size.width,
        height: 0.2 * MediaQuery.of(context).size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 0.2 * MediaQuery.of(context).size.height,
              width: 0.3 * MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
                image: DecorationImage(image: AssetImage(post['image']), fit: BoxFit.fill),
              ),
            ),
            SizedBox(width: 0.03 * MediaQuery.of(context).size.width),
            SizedBox(
              width: 0.55 * MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post['title'],
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: WADarkColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        post['address'],
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: WADarkColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: WAPrimaryColor1, size: 15),
                              const SizedBox(width: 5),
                              Text(
                                '2.5 km',
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  color: WADarkColor,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(Icons.star, color: WAWarningColor, size: 15),
                              const SizedBox(width: 5),
                              Text(
                                post['rating'],
                                style: GoogleFonts.poppins(fontSize: 12, color: WADarkColor),
                              ),
                            ],
                          ),
                          SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
                          Text(
                            '${post['reviews']} reviews',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: WADisableColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 0.1 * MediaQuery.of(context).size.width),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'IDR${(int.parse(post['price']) / 1000).toStringAsFixed(0)}K',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: WADarkColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            post['type'],
                            style: GoogleFonts.roboto(
                              fontSize: 10,
                              color: WADarkColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Shimmer effects for different UI components
class ShimmerEffects {
  static Widget shimmerContainer({
    required double width,
    required double height,
    double borderRadius = 0,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }

  static Widget bannerShimmer(BuildContext context) {
    return shimmerContainer(
      width: MediaQuery.of(context).size.width,
      height: 0.4 * MediaQuery.of(context).size.height,
      borderRadius: 0,
    );
  }

  static Widget sectionTitleShimmer(BuildContext context) {
    return shimmerContainer(
      width: 0.6 * MediaQuery.of(context).size.width,
      height: 24,
      borderRadius: 4,
    );
  }

  static Widget categoryShimmerSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.05 * MediaQuery.of(context).size.width),
      height: 0.15 * MediaQuery.of(context).size.height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 0.2 * MediaQuery.of(context).size.width,
            height: 0.2 * MediaQuery.of(context).size.height,
            child: Column(
              children: [
                shimmerContainer(
                  width: 0.16 * MediaQuery.of(context).size.width,
                  height: 0.15 * MediaQuery.of(context).size.width,
                  borderRadius: 10,
                ),
                const SizedBox(height: 3),
                shimmerContainer(
                  width: 0.15 * MediaQuery.of(context).size.width,
                  height: 15,
                  borderRadius: 4,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static Widget horizontalPostItemShimmer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: shimmerContainer(
        width: 0.8 * MediaQuery.of(context).size.width,
        height: 0.2 * MediaQuery.of(context).size.height,
        borderRadius: 30,
      ),
    );
  }

  static Widget verticalPostItemShimmer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: shimmerContainer(
        width: 0.4 * MediaQuery.of(context).size.width,
        height: 0.3 * MediaQuery.of(context).size.height,
        borderRadius: 30,
      ),
    );
  }

  static Widget eventCardShimmer(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: shimmerContainer(
            width: 0.7 * MediaQuery.of(context).size.width,
            height: 0.3 * MediaQuery.of(context).size.height,
            borderRadius: 30,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: 5,
            right: 5,
            top: 0.22 * MediaQuery.of(context).size.height,
          ),
          child: shimmerContainer(
            width: 0.7 * MediaQuery.of(context).size.width,
            height: 0.08 * MediaQuery.of(context).size.height,
            borderRadius: 15,
          ),
        ),
      ],
    );
  }

  static Widget tagsShimmer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 0.05 * MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: shimmerContainer(
              width: 100,
              height: 0.03 * MediaQuery.of(context).size.height,
              borderRadius: 30,
            ),
          );
        },
      ),
    );
  }

  static Widget penginapanItemShimmer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, right: 10),
      height: 0.2 * MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          shimmerContainer(
            width: 0.3 * MediaQuery.of(context).size.width,
            height: 0.2 * MediaQuery.of(context).size.height,
            borderRadius: 30,
          ),
          SizedBox(width: 0.03 * MediaQuery.of(context).size.width),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              shimmerContainer(
                width: 0.4 * MediaQuery.of(context).size.width,
                height: 20,
                borderRadius: 4,
              ),
              shimmerContainer(
                width: 0.3 * MediaQuery.of(context).size.width,
                height: 15,
                borderRadius: 4,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      shimmerContainer(
                        width: 0.2 * MediaQuery.of(context).size.width,
                        height: 15,
                        borderRadius: 4,
                      ),
                      const SizedBox(height: 5),
                      shimmerContainer(
                        width: 0.15 * MediaQuery.of(context).size.width,
                        height: 15,
                        borderRadius: 4,
                      ),
                    ],
                  ),
                  SizedBox(width: 0.1 * MediaQuery.of(context).size.width),
                  shimmerContainer(
                    width: 0.15 * MediaQuery.of(context).size.width,
                    height: 20,
                    borderRadius: 4,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget homeScreenShimmer(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bannerShimmer(context),
          SizedBox(height: 0.05 * MediaQuery.of(context).size.height),
          categoryShimmerSection(context),
          SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sectionTitleShimmer(context),
                const SizedBox(height: 5),
                SizedBox(
                  height: 0.2 * MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) => horizontalPostItemShimmer(context),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 0.05 * MediaQuery.of(context).size.height),
          // More sections can be added as needed
        ],
      ),
    );
  }
}
