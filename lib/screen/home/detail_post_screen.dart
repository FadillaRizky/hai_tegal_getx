import 'dart:async';
import 'dart:convert';
import 'dart:math' as Math;
import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hai_tegal_getx/controller/index_controller.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hai_tegal_getx/components/colors.dart';
import 'package:hai_tegal_getx/controller/detail_post_controller.dart';
import 'package:line_icons/line_icons.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shimmer/shimmer.dart';

class DetailPostScreen extends StatelessWidget {
  DetailPostScreen({Key? key}) : super(key: key);

  final controller = Get.put(DetailPostController());
  final ScreenshotController screenshotController = ScreenshotController();
  final TextEditingController komentar = TextEditingController();
  final IndexController indexController = Get.find<IndexController>();

  // Method to launch Google Maps with coordinates
  void _launchGoogleMaps(double lat, double lng) async {
    final Uri googleMapsUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );

    try {
      if (!await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication)) {
        Get.snackbar(
          "Error",
          "Couldn't launch Google Maps",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "An error occurred: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

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
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.value ? _buildShimmerLoading(context) : _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner image shimmer
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              color: Colors.white,
            ),
          ),

          // Title and location shimmer
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title shimmer
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width * 0.8,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),

                // Location shimmer
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 15,
                    width: MediaQuery.of(context).size.width * 0.6,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 15,
                    width: MediaQuery.of(context).size.width * 0.7,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 20),
                const Divider(thickness: 3, color: Colors.grey),
                const SizedBox(height: 20),

                // Content sections shimmer
                for (int i = 0; i < 4; i++) ...[
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 20,
                      width: MediaQuery.of(context).size.width * 0.4,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),

                  for (int j = 0; j < 3; j++) ...[
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 15,
                        width: MediaQuery.of(context).size.width * 0.9,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],

                  const SizedBox(height: 20),
                ],

                // Map shimmer
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: double.infinity,
                    color: Colors.white,
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
    // Get coordinates for the map
    double lat = double.parse(
      controller.post['venue'] != null ? controller.post['venue']['venue_x_coordinat'] : '-6.98528',
    );

    double lng = double.parse(
      controller.post['venue'] != null
          ? controller.post['venue']['venue_y_coordinat']
          : '110.409358',
    );

    return RefreshIndicator(
      onRefresh: () async {
        controller.loadPostDetails();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Screenshot(
              controller: screenshotController,
              child: Container(
                color: WALightColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildBannerImage(context),
                    _buildTitleAndLocation(context),
                    const SizedBox(height: 16),
                    const Divider(thickness: 2, color: WASecondary),
                    Obx(
                      () =>
                          controller.screenshotProcess.value == 0
                              ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16),
                                  _buildEventsSection(context),
                                  _buildCostSection(context),
                                  _buildHoursSection(context),
                                  _buildDetailsSection(context),
                                  _buildReviewSummary(context),
                                  const SizedBox(height: 24),
                                  _buildGallerySection(context),
                                  const SizedBox(height: 16),
                                  const Divider(thickness: 2, color: WASecondary),
                                ],
                              )
                              : const SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Replace Google Maps with Flutter Map (OpenMap)
            _buildMapSection(context, lat, lng),

            const SizedBox(height: 16),
            _buildNearbySection(context),
            _buildReviewsSection(context),
            const SizedBox(height: 24), // Add bottom padding
          ],
        ),
      ),
    );
  }

  // New map section with Flutter Map instead of Google Maps

  Widget _buildMapSection(BuildContext context, double lat, double lng) {
    return Container(
      width: double.infinity,
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Use GestureDetector to handle double tap
          GestureDetector(
            onDoubleTap: () {
              _showNavigationConfirmDialog(context, lat, lng);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(lat, lng),
                  initialZoom: 15.0,
                  // Enable all interactive features without double tap to zoom
                  // so our GestureDetector can handle it
                ),
                children: [
                  TileLayer(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 40.0,
                        height: 40.0,
                        point: LatLng(lat, lng),
                        child: const Icon(Icons.location_on, color: WAPrimaryColor1, size: 40),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Hint overlay at the bottom
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Double tap untuk membuka di Google Maps",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: WAPrimaryColor1,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),

          // Zoom controls
          // Positioned(
          //   right: 8,
          //   bottom: 40,
          //   child: Column(
          //     children: [
          //       _buildMapControlButton(Icons.add, () {
          //         // We can't directly control the map zoom because we'd need a controller
          //         // This is just a UI element to indicate zoom is available
          //       }),
          //       const SizedBox(height: 8),
          //       _buildMapControlButton(Icons.remove, () {
          //         // Same as above
          //       }),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  // Add this method to show confirmation dialog in Indonesian
  void _showNavigationConfirmDialog(BuildContext context, double lat, double lng) {
    Get.dialog(
      AlertDialog(
        title: const Text('Buka Google Maps'),
        content: const Text('Apakah Anda ingin membuka lokasi ini di Google Maps?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Tidak')),
          TextButton(
            onPressed: () {
              Get.back();
              _launchGoogleMaps(lat, lng);
            },
            child: const Text('Ya'),
            style: TextButton.styleFrom(
              backgroundColor: WAPrimaryColor1,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapControlButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: WAPrimaryColor1),
        onPressed: onPressed,
        iconSize: 20,
        padding: const EdgeInsets.all(4),
        constraints: const BoxConstraints(),
      ),
    );
  }

  Widget _buildBannerImage(BuildContext context) {
    return Stack(
      children: [
        controller.post['img'] != null && controller.post['img'].length > 0
            ? Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: _getImageProvider(controller.post['img'][0]['images_file']),
                  fit: BoxFit.cover,
                ),
              ),
            )
            : Container(
              height: 220,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img/default_post.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
        Obx(
          () =>
              controller.screenshotProcess.value == 0
                  ? Container(
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: WALightColor,
                              child: IconButton(
                                onPressed: () {
                                  controller.cekBookMark();
                                },
                                icon: Obx(
                                  () => Icon(
                                    LineIcons.bookmark,
                                    color:
                                        controller.isSaved.value == 1
                                            ? WAAccentColor
                                            : WADisableColor,
                                  ),
                                ),
                              ),
                            ),
                            // const SizedBox(height: 8),
                            // CircleAvatar(
                            //   backgroundColor: WALightColor,
                            //   child: IconButton(
                            //     onPressed: () {
                            //       controller.screenshotProcess.value = 1;
                            //       // Simulate screenshot and sharing
                            //       Future.delayed(const Duration(milliseconds: 500), () {
                            //         controller.screenshotProcess.value = 0;
                            //         Get.snackbar(
                            //           "Info",
                            //           "Berhasil dibagikan ke sosial media",
                            //           backgroundColor: WAPrimaryColor1,
                            //           colorText: WALightColor,
                            //         );
                            //       });
                            //     },
                            //     icon: const Icon(Icons.share, color: WAPrimaryColor1),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  )
                  : const SizedBox(),
        ),
      ],
    );
  }

  Widget _buildTitleAndLocation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${controller.post['post_title']}',
            style: GoogleFonts.montserrat(
              fontSize: 24,
              color: WADarkColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          controller.post['venue'] != null && controller.post['venue'].isNotEmpty
              ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on, color: WAPrimaryColor1, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${controller.post['venue']['venue_addr'] ?? ''}',
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: WADarkColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${controller.post['village']['village_nm'] ?? ''}, ${controller.post['district']['district_nm'] ?? ''}, ${controller.post['city']['city_nm'] ?? ''}',
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: WADarkColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              )
              : const SizedBox(),
          const SizedBox(height: 8),
          controller.post['venue'] != null && controller.post['venue'].isNotEmpty
              ? Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.route, color: WAPrimaryColor1, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      '${(controller.calculateDistance(double.parse(controller.latitudeUserCB.value), double.parse(controller.longitudeUserCB.value), double.parse(controller.post['venue']['venue_x_coordinat'].toString()), double.parse(controller.post['venue']['venue_y_coordinat'].toString())).toStringAsFixed(0))} km',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: WADarkColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget _buildEventsSection(BuildContext context) {
    if (controller.post['event'] == null || controller.post['event'].isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Events',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: WADarkColor,
            ),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.post['event'].length,
            itemBuilder:
                (context, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundColor: WAPrimaryColor1.withOpacity(0.1),
                    child: Text(
                      '${1 + index}',
                      style: GoogleFonts.roboto(
                        color: WAPrimaryColor1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    '${controller.post['event'][index]['event_location']}',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: WADarkColor,
                    ),
                  ),
                  subtitle: Text(
                    '${controller.date2(controller.post['event'][index]['event_start_date'])} - ${controller.date2(controller.post['event'][index]['event_end_date'])}',
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: WADarkColor,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.calendar_month, color: WAPrimaryColor1),
                    onPressed: () {
                      Get.dialog(
                        Dialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Event Detail',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image(
                                    image: _getImageProvider(
                                      controller.post['event'][index]['event_poster_img'],
                                    ),
                                    fit: BoxFit.cover,
                                    height: 180,
                                    width: double.infinity,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  '${controller.post['event'][index]['event_location'] ?? ''}',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: WADarkColor,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child: const Text('Tutup'),
                                  style: TextButton.styleFrom(
                                    backgroundColor: WAPrimaryColor1,
                                    foregroundColor: WALightColor,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildCostSection(BuildContext context) {
    if (controller.post['cost'] == null || controller.post['cost'].isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Biaya',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: WADarkColor,
                ),
              ),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    controller.costAll.value = controller.costAll.value == 0 ? 1 : 0;
                  },
                  child: Text(
                    controller.costAll.value == 0 ? 'Lihat' : 'Tutup',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: WAPrimaryColor1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Obx(
            () =>
                controller.costAll.value == 1
                    ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.post['cost'].length,
                      itemBuilder:
                          (context, index) => Card(
                            elevation: 1,
                            margin: const EdgeInsets.only(bottom: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      controller.post['cost'][index]['cost_name'],
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: WADarkColor,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'IDR ${controller.rupiah(double.parse(controller.post['cost'][index]['cost_price'].toString()))}',
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: WAPrimaryColor1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    )
                    : const SizedBox(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildHoursSection(BuildContext context) {
    if (controller.post['venue_hours'] == null || controller.post['venue_hours'].isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Jam Operasional',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: WADarkColor,
                ),
              ),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    controller.venueHoursAll.value = controller.venueHoursAll.value == 0 ? 1 : 0;
                  },
                  child: Text(
                    controller.venueHoursAll.value == 0 ? 'Lihat' : 'Tutup',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: WAPrimaryColor1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Obx(
            () =>
                controller.venueHoursAll.value == 1
                    ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.post['venue_hours'].length,
                      itemBuilder:
                          (context, index) => Card(
                            elevation: 1,
                            margin: const EdgeInsets.only(bottom: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: WAPrimaryColor1.withOpacity(0.1),
                                    radius: 16,
                                    child: Text(
                                      '${1 + index}',
                                      style: GoogleFonts.roboto(
                                        color: WAPrimaryColor1,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.dayCheck(
                                            controller.post['venue_hours'][index]['operational_day']
                                                .toString(),
                                          ),
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: WADarkColor,
                                          ),
                                        ),
                                        Text(
                                          '${controller.post['venue_hours'][index]['operational_open']} - ${controller.post['venue_hours'][index]['operational_closed']}',
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: WADarkColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    )
                    : const SizedBox(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDetailsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Details',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: WADarkColor,
            ),
          ),
          const SizedBox(height: 8),
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${controller.post['post_short']}',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: WADarkColor,
                  ),
                  maxLines: controller.readAll.value == 0 ? 3 : null,
                  overflow:
                      controller.readAll.value == 0 ? TextOverflow.ellipsis : TextOverflow.visible,
                ),
                GestureDetector(
                  onTap: () {
                    controller.readAll.value = controller.readAll.value == 0 ? 1 : 0;
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      controller.readAll.value == 0 ? 'Read more' : 'Show less',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: WAPrimaryColor1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildReviewSummary(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    controller.averageReviewCB['average'].toString() == 'null'
                        ? '0'
                        : controller.averageReviewCB['average']!.toStringAsFixed(1),
                    style: GoogleFonts.montserrat(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: WAPrimaryColor1,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Review Summary',
                          style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Based on user reviews',
                          style: GoogleFonts.roboto(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              for (int i = 5; i >= 1; i--)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 25,
                        child: Text(
                          '$i',
                          style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value:
                                (int.parse(
                                  controller.reviewSummaryPostAllLMB[i.toString()].toString() ==
                                          'null'
                                      ? '0'
                                      : controller.reviewSummaryPostAllLMB[i.toString()].toString(),
                                )) /
                                100,
                            backgroundColor: Colors.grey[200],
                            minHeight: 8,
                            color: WAPrimaryColor1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 40,
                        child: Text(
                          '${controller.reviewSummaryPostAllLMB[i.toString()] ?? 0}%',
                          style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGallerySection(BuildContext context) {
    if (controller.post['img'] == null || controller.post['img'].isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Gallery',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: WADarkColor,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Show gallery in full screen
                  Get.to(() => GalleryFullScreen(images: controller.post['img']));
                },
                child: Text(
                  'View All',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: WAPrimaryColor1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.post['img'].length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.dialog(
                      Dialog(
                        backgroundColor: Colors.transparent,
                        insetPadding: const EdgeInsets.all(12),
                        child: GestureDetector(
                          onTap: () => Get.back(),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              InteractiveViewer(
                                minScale: 0.5,
                                maxScale: 3.0,
                                child: Image(
                                  image: _getImageProvider(
                                    controller.post['img'][index]['images_file'],
                                  ),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: const CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.close, color: WAPrimaryColor1, size: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: _getImageProvider(controller.post['img'][index]['images_file']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNearbySection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Lokasi Terdekat',
              style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () =>
                controller.post['category'] != null && controller.post['category'].isNotEmpty
                    ? SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.post['category'].length,
                        itemBuilder: (context, index) {
                          final isSelected =
                              controller.nearestCategory.value['category_name'] ==
                              controller.post['category'][index]['category_name'];

                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ElevatedButton(
                              onPressed: () {
                                controller.nearestCategory.value =
                                    controller.post['category'][index];
                                if (controller.post['venue'] != null &&
                                    controller.post['venue'].isNotEmpty) {
                                  controller.loadNearestPostIndex(
                                    controller.post['venue']['venue_x_coordinat'],
                                    controller.post['venue']['venue_y_coordinat'],
                                    controller.nearestCategory.value['category_id'],
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isSelected ? WAPrimaryColor1 : Colors.grey[200],
                                foregroundColor: isSelected ? Colors.white : WADarkColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                controller.post['category'][index]['category_name'] ?? '',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                    : const SizedBox(),
          ),
          const SizedBox(height: 16),
          Obx(
            () =>
                controller.nearestPostAllLMB.isNotEmpty
                    ? Column(
                      children: [
                        ...List.generate(
                          controller.nearestAll.value == 0
                              ? controller.nearestPostAllLMB.length > 4
                                  ? 4
                                  : controller.nearestPostAllLMB.length
                              : controller.nearestPostAllLMB.length,
                          (index) => _buildNearestPostItem(context, index),
                        ),
                        if (controller.nearestPostAllLMB.length > 4)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: TextButton(
                              onPressed: () {
                                controller.nearestAll.value =
                                    controller.nearestAll.value == 0 ? 1 : 0;
                              },
                              child: Text(
                                controller.nearestAll.value == 0 ? 'View All' : 'Show Less',
                                style: GoogleFonts.roboto(
                                  color: WAPrimaryColor1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    )
                    : Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          'Data tidak tersedia',
                          style: GoogleFonts.montserrat(fontSize: 14),
                        ),
                      ),
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildNearestPostItem(BuildContext context, int index) {
    final item = controller.nearestPostAllLMB[index];

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          // Navigate to detail
          Get.snackbar(
            "Info",
            "Navigating to detail for: ${item['post']['post_title']}",
            backgroundColor: WAPrimaryColor1,
            colorText: WALightColor,
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child:
                    item['post']['img'] != null && item['post']['img'].isNotEmpty
                        ? Image(
                          image: _getImageProvider(item['post']['img'][0]['images_file']),
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        )
                        : Image.asset(
                          'assets/img/default_post.jpg',
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${item['post']['post_title']}',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: WADarkColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${item['post']['venue']['venue_addr']}',
                      style: GoogleFonts.roboto(fontSize: 12, color: Colors.grey[700]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: WAPrimaryColor1, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              '${(item['distance'] / 1000).toStringAsFixed(1)} km',
                              style: GoogleFonts.roboto(fontSize: 12, color: WADarkColor),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              '${item['post']['average_rating'] ?? 0}',
                              style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.bold),
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
      ),
    );
  }

  Widget _buildReviewsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(thickness: 2),
          const SizedBox(height: 16),
          Obx(
            () =>
                controller.userDetailMB.isNotEmpty
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            controller.userDetailMB['user_img'] == ''
                                ? const CircleAvatar(
                                  radius: 24,
                                  backgroundImage: AssetImage('assets/img/profile_img.png'),
                                )
                                : CircleAvatar(
                                  radius: 24,
                                  backgroundImage: MemoryImage(
                                    base64Decode(controller.userDetailMB['user_img']),
                                  ),
                                ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${controller.userDetailMB['user_name']}',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    controller.date2(DateTime.now().toString()),
                                    style: GoogleFonts.roboto(fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Berikan Rating',
                          style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: List.generate(
                            5,
                            (index) => GestureDetector(
                              onTap: () {
                                controller.ratingCB.value = (index + 1);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.star,
                                  color:
                                      (1 + index) <= controller.ratingCB.value
                                          ? Colors.amber
                                          : Colors.grey[300],
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Deskripsi Ulasan',
                          style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Berikan review Anda...',
                            hintStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                          ),
                          controller: komentar,
                          maxLength: 500,
                          maxLines: 3,
                          style: GoogleFonts.roboto(fontSize: 14),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (komentar.text.isNotEmpty && controller.ratingCB.value > 0) {
                                // Simulate review submission
                                controller.showCommentAlert("Review berhasil dikirim");
                                komentar.clear();
                                // controller.ratingCB.value = This is partially cut off and would continue on...
                              } else {
                                Get.snackbar(
                                  "Error",
                                  "Silakan isi rating dan komentar",
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: WAPrimaryColor1,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                            ),
                            child: Text(
                              controller.idEditedComment.value == 0 ? 'Kirim' : 'Update',
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    )
                    : const SizedBox(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reviews (${controller.reviewPostAllLMB.length})',
                style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Obx(
                () =>
                    controller.reviewPostAllLMB.isNotEmpty
                        ? TextButton(
                          onPressed: () {
                            controller.reviewAll.value = controller.reviewAll.value == 0 ? 1 : 0;
                          },
                          child: Text(
                            controller.reviewAll.value == 0 ? 'View All' : 'Show Less',
                            style: GoogleFonts.roboto(fontSize: 14, color: WAPrimaryColor1),
                          ),
                        )
                        : const SizedBox(),
              ),
            ],
          ),
          const Divider(),
          Obx(
            () =>
                controller.reviewPostAllLMB.isNotEmpty
                    ? ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          controller.reviewAll.value == 0
                              ? Math.min(2, controller.reviewPostAllLMB.length)
                              : controller.reviewPostAllLMB.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) => _buildReviewItem(context, index),
                    )
                    : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: Text(
                          'No reviews yet. Be the first to review!',
                          style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(BuildContext context, int index) {
    final review = controller.reviewPostAllLMB[index];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/img/profile_img.png'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${review['user_name']}',
                          style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          controller.date2(review['comment_dttm']),
                          style: GoogleFonts.roboto(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: List.generate(
                        5,
                        (idx) => Icon(
                          Icons.star,
                          color:
                              (idx + 1) <= int.parse(review['comment_rating'])
                                  ? Colors.amber
                                  : Colors.grey[300],
                          size: 16,
                        ),
                      ),
                    ),
                    if (review['comment_txt'] != null && review['comment_txt'].isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          '${review['comment_txt']}',
                          style: GoogleFonts.roboto(fontSize: 14),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper function to determine image provider based on image path
  ImageProvider _getImageProvider(String imagePath) {
    if (imagePath.startsWith('http')) {
      // If it's a URL, use NetworkImage
      return NetworkImage(imagePath);
    } else if (imagePath.startsWith('assets/')) {
      // If it's an asset path, use AssetImage
      return AssetImage(imagePath);
    } else {
      // For relative paths, assume it's a path on the server and prepend the base URL
      // or just use AssetImage if it's likely a local asset
      return AssetImage(imagePath);
    }
  }
}

// FullScreen Gallery View
class GalleryFullScreen extends StatelessWidget {
  final List<dynamic> images;

  const GalleryFullScreen({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Gallery',
          style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => PhotoViewScreen(images: images, initialIndex: index));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(image: AssetImage(images[index]['images_file']), fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}

// Photo View Screen
class PhotoViewScreen extends StatefulWidget {
  final List<dynamic> images;
  final int initialIndex;

  const PhotoViewScreen({Key? key, required this.images, required this.initialIndex})
    : super(key: key);

  @override
  _PhotoViewScreenState createState() => _PhotoViewScreenState();
}

class _PhotoViewScreenState extends State<PhotoViewScreen> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          '${_currentIndex + 1}/${widget.images.length}',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          return InteractiveViewer(
            minScale: 0.5,
            maxScale: 3.0,
            child: Center(
              child: Image(
                image: AssetImage(widget.images[index]['images_file']),
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}
