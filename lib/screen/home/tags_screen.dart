import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hai_tegal_getx/components/colors.dart';
import 'package:hai_tegal_getx/controller/index_controller.dart';
import 'package:hai_tegal_getx/controller/tag_controller.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shimmer/shimmer.dart';

class TagsScreen extends StatelessWidget {
  TagsScreen({Key? key}) : super(key: key);

  final controller = Get.put(TagsController());
  final indexController = Get.put(IndexController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 0.08 * MediaQuery.of(context).size.height,
        child: BottomBarBubble(
          selectedIndex: 0,
          color: WAPrimaryColor1,
          items: [
            BottomBarItem(
              iconData: LineIcons.home,
              label: 'Home',
              labelTextStyle: GoogleFonts.montserrat(fontSize: 14),
            ),
            BottomBarItem(
              iconData: LineIcons.bell,
              label: 'Notification',
              labelTextStyle: GoogleFonts.montserrat(fontSize: 14),
            ),
            BottomBarItem(
              iconData: LineIcons.bookmark,
              label: 'Saved',
              labelTextStyle: GoogleFonts.montserrat(fontSize: 14),
            ),
            BottomBarItem(
              iconData: LineIcons.user,
              label: 'Account',
              labelTextStyle: GoogleFonts.montserrat(fontSize: 14),
            ),
          ],
          onSelect: (index) {
            indexController.navigateBackAndChangeIndex(index);
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.loadPostsByTag(controller.selectedTag['tags_id']);
        },
        child: Obx(
          () => controller.isLoading.value ? _buildShimmerLoading(context) : _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Shimmer for header image
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 350.0,
              color: Colors.white,
            ),
          ),

          // Shimmer for title
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 30.0,
                color: Colors.white,
              ),
            ),
          ),

          // Shimmer for search box
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 120.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Shimmer for tags list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 40.0,
                color: Colors.white,
              ),
            ),
          ),

          // Shimmer for post cards
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 200.0,
                    margin: const EdgeInsets.only(right: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 200.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                // Header background image
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(bottom: 30),
                  decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                  height: 350.0,
                  child: Image.asset('assets/img/background_2.png', fit: BoxFit.fill),
                ),
                // Gradient overlay
                SizedBox(
                  height: 350.0,
                  child: Column(
                    children: [
                      Container(height: 170.0),
                      Container(
                        height: 180.0,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          gradient: LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            colors: [Colors.transparent, WALightColor],
                            stops: [0.0, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Back button
                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    height: 220,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.arrow_back, color: WADarkColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content section
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tag header
                SizedBox(height: 0.3 * MediaQuery.of(context).size.height),
                Obx(
                  () => Text(
                    'Temukan tagar ${controller.selectedTag['tags_name']}',
                    style: GoogleFonts.poppins(
                      fontSize: 19,
                      color: WALightColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 0.01 * MediaQuery.of(context).size.height),

                // Search container
                Container(
                  width: 0.9 * MediaQuery.of(context).size.width,
                  height: 0.2 * MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: WALightColor,
                    border: Border.all(color: WASecondary),
                    boxShadow: [
                      BoxShadow(
                        color: WADarkColor.withOpacity(0.8),
                        blurRadius: 2,
                        blurStyle: BlurStyle.inner,
                        offset: const Offset(2, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Search field
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Material(
                          elevation: 15.0,
                          shadowColor: WASecondary,
                          color: Colors.transparent,
                          child: TextField(
                            autofocus: false,
                            controller: controller.searchController,
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: WADarkColor,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search, color: WASecondary),
                              border: InputBorder.none,
                              hintText: 'Cari tagar...',
                              hintStyle: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: WASecondary,
                              ),
                              filled: true,
                              fillColor: WALightColor,
                              contentPadding: const EdgeInsets.symmetric(vertical: 11),
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

                      // Search button
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: GestureDetector(
                          onTap: () {
                            controller.searchPostsByKeyword(controller.searchController.text);
                          },
                          child: Container(
                            width: 0.8 * MediaQuery.of(context).size.width,
                            height: 0.07 * MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: WAPrimaryColor1,
                              border: Border.all(color: WASecondary),
                              boxShadow: [
                                BoxShadow(
                                  color: WADarkColor.withOpacity(0.2),
                                  blurRadius: 2,
                                  blurStyle: BlurStyle.inner,
                                  offset: const Offset(2, 6),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Temukan Tagar!',
                                style: GoogleFonts.roboto(fontSize: 16, color: WALightColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 0.03 * MediaQuery.of(context).size.height),

                // Tag header and clear search button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Text(
                        '${controller.selectedTag['tags_name']}',
                        style: GoogleFonts.montserrat(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: WADarkColor,
                        ),
                      ),
                    ),

                    Obx(
                      () =>
                          controller.isSearching.value
                              ? GestureDetector(
                                onTap: () {
                                  controller.clearSearch();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Text(
                                    'Hapus Pencarian',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: WADangerColor,
                                    ),
                                  ),
                                ),
                              )
                              : const SizedBox(),
                    ),
                  ],
                ),

                SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
                // All tags horizontal list
                Obx(
                  () =>
                      controller.allTags.isNotEmpty
                          ? Container(
                            width: MediaQuery.of(context).size.width,
                            height: 0.08 * MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(right: 20),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.allTags.length,
                              itemBuilder: (context, index) {
                                final tag = controller.allTags[index];
                                return GestureDetector(
                                  onTap: () {
                                    controller.selectTag(tag);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 5),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: WATagColor, width: 1),
                                      color:
                                          controller.selectedTag['tags_id'] == tag['tags_id']
                                              ? WATagColor.withOpacity(0.2)
                                              : WALightColor,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text(
                                      '${tag['tags_name']}',
                                      style: GoogleFonts.sourceSans3(
                                        fontSize: 14,
                                        color: WATagColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                          : const SizedBox(),
                ),

                SizedBox(height: 0.03 * MediaQuery.of(context).size.height),

                // Posts grid
                Obx(
                  () =>
                      controller.taggedPosts.isNotEmpty
                          ? SizedBox(
                            height: 0.32 * MediaQuery.of(context).size.height,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.taggedPosts.length,
                              itemBuilder: (context, index) {
                                final post = controller.taggedPosts[index];
                                return GestureDetector(
                                  onTap: () {
                                    // Navigate to post detail
                                    Get.toNamed('/detail-post', arguments: post);
                                  },
                                  child: Stack(
                                    children: [
                                      // Post image
                                      Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 5),
                                        height: 0.25 * MediaQuery.of(context).size.height,
                                        width: 0.4 * MediaQuery.of(context).size.width,
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
                                          image: DecorationImage(
                                            image: AssetImage('assets/img/default_post.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),

                                      // Post info overlay
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        margin: EdgeInsets.only(
                                          left: 5,
                                          right: 5,
                                          top: 0.168 * MediaQuery.of(context).size.height,
                                        ),
                                        height: 0.08 * MediaQuery.of(context).size.height,
                                        width: 0.4 * MediaQuery.of(context).size.width,
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
                                              '${post['post_title']}',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: WADarkColor,
                                              ),
                                              maxLines: 2,
                                            ),
                                            Text(
                                              '${post['post_short']}',
                                              style: GoogleFonts.roboto(
                                                fontSize: 10,
                                                fontWeight: FontWeight.normal,
                                                color: WADarkColor,
                                              ),
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                          : Center(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Text(
                                'Tidak ada post untuk tagar ini',
                                style: GoogleFonts.roboto(fontSize: 14, color: WADarkColor),
                              ),
                            ),
                          ),
                ),

                SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
