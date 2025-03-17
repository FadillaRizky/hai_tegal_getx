import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hai_tegal_getx/components/colors.dart';
import 'package:hai_tegal_getx/controller/home_controller.dart';
import 'package:line_icons/line_icons.dart';
import 'package:carousel_custom_slider/carousel_custom_slider.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                controller.refreshData();
              },
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBannerSection(context),
                      SizedBox(height: 0.05 * MediaQuery.of(context).size.height),
                      Obx(
                        () =>
                            controller.isSearching.value
                                ? _buildSearchResultsSection(context)
                                : const SizedBox(),
                      ),
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
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerSection(BuildContext context) {
    // Get banner images from controller or use defaults if not available
    List<String> bannerImages = [];

    if (controller.banners.isNotEmpty) {
      for (var banner in controller.banners) {
        if (banner.bannerFile != null) {
          bannerImages.add(banner.bannerFile!);
        }
      }
    }

    // If no banners from API, use defaults
    if (bannerImages.isEmpty) {
      bannerImages = [
        'assets/img/background_3.png',
        'assets/img/background_3.png',
        'assets/img/background_3.png',
      ];
    }

    return SizedBox(
      height: 0.4 * MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          // Banner carousel
          CarouselCustomSlider(
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
          // Search bar overlay
          Padding(
            padding: EdgeInsets.only(
              top: 0.06 * MediaQuery.of(context).size.height,
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
                onChanged: (value) {
                  controller.searchDestinations(value);
                },
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      // Trigger search with current text
                      FocusScope.of(context).unfocus();
                    },
                    child: const Icon(Icons.search, color: WASecondary),
                  ),
                  border: InputBorder.none,
                  hintText: 'Mau jalan-jalan kemana hari ini ?',
                  hintStyle: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: WASecondary,
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
    return Obx(() {
      if (controller.searchResults.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 0.05 * MediaQuery.of(context).size.width,
          ),
          child: Center(
            child: Text(
              'No results found for "${controller.searchQuery.value}"',
              style: GoogleFonts.roboto(fontSize: 16, color: WADarkColor),
            ),
          ),
        );
      }

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.05 * MediaQuery.of(context).size.width),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 10),
              child: Text(
                'Search Results',
                style: GoogleFonts.montserrat(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: WADarkColor,
                ),
              ),
            ),
            SizedBox(
              height: 0.25 * MediaQuery.of(context).size.height,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.searchResults.length,
                itemBuilder: (context, index) {
                  return _buildBannerPostItem(context, controller.searchResults[index]);
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildCategoriesSection(BuildContext context) {
    return Obx(() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 0.05 * MediaQuery.of(context).size.width),
        height: 0.15 * MediaQuery.of(context).size.height,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(
                  '/category',
                  arguments: {'category': controller.categories[index]['name']},
                );
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
                      child: Icon(
                        controller.categories[index]['icon'],
                        color: WAInfo2Color,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      controller.categories[index]['name'],
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
    });
  }

  Widget _buildWisataSection(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Wisata Tegal',
              style: GoogleFonts.montserrat(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: WADarkColor,
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 0.2 * MediaQuery.of(context).size.height,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.wisataItems.length,
                itemBuilder: (context, index) {
                  return _buildBannerPostItem(context, controller.wisataItems[index]);
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildJelajahSection(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jelajahi Tegal',
              style: GoogleFonts.montserrat(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: WADarkColor,
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 0.3 * MediaQuery.of(context).size.height,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.jelajahItems.length,
                itemBuilder: (context, index) {
                  return _buildVerticalPostItem(context, controller.jelajahItems[index]);
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildKulinerSection(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kuliner Tegal',
              style: GoogleFonts.montserrat(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: WADarkColor,
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 0.25 * MediaQuery.of(context).size.height,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.kulinerItems.length,
                itemBuilder: (context, index) {
                  return _buildBannerPostItem(context, controller.kulinerItems[index]);
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildEventSection(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Event Tegal',
              style: GoogleFonts.montserrat(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: WADarkColor,
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 0.32 * MediaQuery.of(context).size.height,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.eventItems.length,
                itemBuilder: (context, index) {
                  return _buildEventPostItem(context, controller.eventItems[index]);
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTagsSection(BuildContext context) {
    return Obx(() {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 0.05 * MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 20),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.tagsList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed('/tags', arguments: {'tag': controller.tagsList[index]});
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
                    controller.tagsList[index],
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
    });
  }

  Widget _buildPenginapanSection(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Penginapan di Tegal',
              style: GoogleFonts.montserrat(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: WADarkColor,
              ),
            ),
            const SizedBox(height: 5),
            Column(
              children: List.generate(
                controller.penginapanItems.length,
                (index) => _buildPenginapanItem(context, controller.penginapanItems[index]),
              ),
            ),
          ],
        ),
      );
    });
  }

  // Helper methods to build repeated UI components
  Widget _buildBannerPostItem(BuildContext context, Map<String, dynamic> post) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/detail-post', arguments: {'title': post['title'], 'image': post['image']});
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
        Get.toNamed('/detail-post', arguments: {'title': post['title'], 'image': post['image']});
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
        Get.toNamed(
          '/detail-post',
          arguments: {'title': post['title'], 'description': post['short'], 'image': post['image']},
        );
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
        Get.toNamed(
          '/detail-post',
          arguments: {
            'title': post['title'],
            'address': post['address'],
            'rating': post['rating'],
            'reviews': post['reviews'],
            'price': post['price'],
            'type': post['type'],
            'image': post['image'],
          },
        );
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
