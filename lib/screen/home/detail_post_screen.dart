import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_map/flutter_map.dart';
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

  // Method to launch Google Maps with coordinates
  void _launchGoogleMaps(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
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
      body: Obx(
        () => controller.isLoading.value ? _buildShimmerLoading(context) : _buildContent(context),
      ),
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner image shimmer
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 0.3 * MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
            ),
          ),

          // Title and location shimmer
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title shimmer
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 30,
                    width: 0.8 * MediaQuery.of(context).size.width,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),

                // Location shimmer
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 15,
                    width: 0.6 * MediaQuery.of(context).size.width,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 15,
                    width: 0.7 * MediaQuery.of(context).size.width,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 20),
                Divider(thickness: 3, color: Colors.grey[200]),
                SizedBox(height: 20),

                // Content sections shimmer
                for (int i = 0; i < 4; i++) ...[
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 20,
                      width: 0.4 * MediaQuery.of(context).size.width,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),

                  for (int j = 0; j < 3; j++) ...[
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 15,
                        width: 0.9 * MediaQuery.of(context).size.width,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                  ],

                  SizedBox(height: 20),
                ],

                // Map shimmer
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 0.3 * MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
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
      controller.post['venue'] != null
          ? controller.post['venue']['venue_x_coordinat']
          : '-6.98528',
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
                    SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
                    const Divider(thickness: 3, color: WASecondary),
                    Obx(
                      () =>
                          controller.screenshotProcess.value == 0
                              ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
                                  _buildEventsSection(context),
                                  _buildCostSection(context),
                                  _buildHoursSection(context),
                                  _buildDetailsSection(context),
                                  _buildReviewSummary(context),
                                  SizedBox(height: 0.05 * MediaQuery.of(context).size.height),
                                  _buildGallerySection(context),
                                  SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
                                  const Divider(thickness: 3, color: WASecondary),
                                ],
                              )
                              : const SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
            
            // Replace Google Maps with Flutter Map (OpenMap)
            _buildMapSection(context, lat, lng),
            
            SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
            _buildNearbySection(context),
            _buildReviewsSection(context),
          ],
        ),
      ),
    );
  }

  // New map section with Flutter Map instead of Google Maps
  Widget _buildMapSection(BuildContext context, double lat, double lng) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 0.3 * MediaQuery.of(context).size.height,
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () => _launchGoogleMaps(lat, lng),
        child: Stack(
          children: [
            // Flutter Map (OpenMap) implementation
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(lat, lng),
                  initialZoom: 15.0,
                  // interactiveFlags: InteractiveFlag.none, // Disable map panning to emphasize it should be clicked
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
                        child: Icon(
                          Icons.location_on,
                          color: WAPrimaryColor1,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Add a semi-transparent overlay with instructions
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.touch_app,
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Tap to open in Google Maps",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: WAPrimaryColor1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerImage(BuildContext context) {
    return Stack(
      children: [
        controller.post['img'] != null && controller.post['img'].length > 0
            ? Container(
              height: 0.3 * MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(controller.post['img'][0]['images_file']),
                  fit: BoxFit.fill,
                ),
              ),
            )
            : Container(
              height: 0.3 * MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img/default_post.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
        Obx(
          () =>
              controller.screenshotProcess.value == 0
                  ? Container(
                    margin: EdgeInsets.only(top: 0.03 * MediaQuery.of(context).size.height),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 0.3 * MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.arrow_back, color: WALightColor),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                            SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
                            CircleAvatar(
                              backgroundColor: WALightColor,
                              child: IconButton(
                                onPressed: () {
                                  controller.screenshotProcess.value = 1;
                                  // Simulate screenshot and sharing
                                  Future.delayed(Duration(milliseconds: 500), () {
                                    controller.screenshotProcess.value = 0;
                                    Get.snackbar(
                                      "Info",
                                      "Berhasil dibagikan ke sosial media",
                                      backgroundColor: WAPrimaryColor1,
                                      colorText: WALightColor,
                                    );
                                  });
                                },
                                icon: Icon(Icons.share, color: WAPrimaryColor1),
                              ),
                            ),
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
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${controller.post['post_title']}',
            style: GoogleFonts.montserrat(
              fontSize: 30,
              color: WADarkColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          controller.post['venue'] != null && controller.post['venue'].isNotEmpty
              ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on, color: WAPrimaryColor1, size: 25),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: 0.8 * MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${controller.post['venue']['venue_addr'] ?? ''}',
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: WADarkColor,
                          ),
                          maxLines: 2,
                        ),
                        Text(
                          '${controller.post['village']['village_nm'] ?? ''}, ${controller.post['district']['district_nm'] ?? ''}, ${controller.post['city']['city_nm'] ?? ''}',
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: WADarkColor,
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              )
              : const SizedBox(),
          SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
          controller.post['venue'] != null && controller.post['venue'].isNotEmpty
              ? Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.route, color: WAPrimaryColor1, size: 25),
                    const SizedBox(width: 5),
                    Text(
                      '${controller.calculateDistance(double.parse(controller.latitudeUserCB.value), double.parse(controller.longitudeUserCB.value), double.parse(controller.post['venue']['venue_x_coordinat'].toString()), double.parse(controller.post['venue']['venue_y_coordinat'].toString())).toStringAsFixed(0)} km',
                      style: GoogleFonts.roboto(
                        fontSize: 12,
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'Events',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: WADarkColor,
            ),
          ),
        ),
        Column(
          children: List.generate(
            controller.post['event'].length,
            (index) => ListTile(
              leading: Text(
                '${1 + index}',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: WADarkColor,
                ),
              ),
              title: Text(
                '${controller.post['event'][index]['event_location']}',
                style: GoogleFonts.roboto(
                  fontSize: 12,
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
                            SizedBox(height: 16),
                            Container(
                              height: 0.2 * MediaQuery.of(context).size.height,
                              width: 0.8 * MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage(
                                    controller.post['event'][index]['event_poster_img'],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              '${controller.post['event'][index]['event_location'] ?? ''}',
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: WADarkColor,
                              ),
                            ),
                            SizedBox(height: 16),
                            TextButton(
                              onPressed: () => Get.back(),
                              child: Text('Tutup'),
                              style: TextButton.styleFrom(
                                backgroundColor: WAPrimaryColor1,
                                foregroundColor: WALightColor,
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        ),
        SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
      ],
    );
  }

  Widget _buildCostSection(BuildContext context) {
    if (controller.post['cost'] == null || controller.post['cost'].isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Biaya',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: WADarkColor,
                ),
              ),
              const Spacer(),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    controller.costAll.value = controller.costAll.value == 0 ? 1 : 0;
                  },
                  child: Text(
                    controller.costAll.value == 0 ? 'Lihat' : 'Tutup',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: WAPrimaryColor1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Obx(
          () =>
              controller.costAll.value == 1
                  ? Column(
                    children: List.generate(
                      controller.post['cost'].length,
                      (index) => ListTile(
                        title: Text(
                          controller.post['cost'][index]['cost_name'],
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: WADarkColor,
                          ),
                        ),
                        subtitle: Text(
                          'IDR ${controller.rupiah(double.parse(controller.post['cost'][index]['cost_price'].toString()))}',
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: WADarkColor,
                          ),
                        ),
                      ),
                    ),
                  )
                  : const SizedBox(),
        ),
        SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
      ],
    );
  }

  Widget _buildHoursSection(BuildContext context) {
    if (controller.post['venue_hours'] == null || controller.post['venue_hours'].isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Jam Operasional',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: WADarkColor,
                ),
              ),
              const Spacer(),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    controller.venueHoursAll.value = controller.venueHoursAll.value == 0 ? 1 : 0;
                  },
                  child: Text(
                    controller.venueHoursAll.value == 0 ? 'Lihat' : 'Tutup',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: WAPrimaryColor1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Obx(
          () =>
              controller.venueHoursAll.value == 1
                  ? Column(
                    children: List.generate(
                      controller.post['venue_hours'].length,
                      (index) => ListTile(
                        leading: Text(
                          '${1 + index}',
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: WADarkColor,
                          ),
                        ),
                        title: Text(
                          controller.dayCheck(
                            controller.post['venue_hours'][index]['operational_day'].toString(),
                          ),
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: WADarkColor,
                          ),
                        ),
                        subtitle: Text(
                          '${controller.post['venue_hours'][index]['operational_open']} - ${controller.post['venue_hours'][index]['operational_closed']}',
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: WADarkColor,
                          ),
                        ),
                      ),
                    ),
                  )
                  : const SizedBox(),
        ),
        SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
      ],
    );
  }

  Widget _buildDetailsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Details',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: WADarkColor,
            ),
          ),
          SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${controller.post['post_short']}',
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: WADarkColor,
                  ),
                  maxLines: controller.readAll.value == 0 ? 3 : 10,
                ),
                GestureDetector(
                  onTap: () {
                    controller.readAll.value = controller.readAll.value == 0 ? 1 : 0;
                  },
                  child: Text(
                    controller.readAll.value == 0 ? '..Read more' : '..Ringkasan',
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: WAPrimaryColor1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
        ],
      ),
    );
  }

  Widget _buildReviewSummary(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.all(20),
        width: 0.85 * MediaQuery.of(context).size.width,
        height: 0.25 * MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: WADarkColor.withOpacity(0.6),
              blurRadius: 4,
              blurStyle: BlurStyle.outer,
              offset: const Offset(4, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  controller.averageReviewCB['average'].toString() == 'null'
                      ? '0'
                      : controller.averageReviewCB['average']!.toStringAsFixed(2),
                  style: GoogleFonts.montserrat(fontSize: 30, fontWeight: FontWeight.w700),
                ),
                const SizedBox(width: 10),
                Text(
                  'Review Summary',
                  style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(height: 0.02 * MediaQuery.of(context).size.height),
            Column(
              children: List.generate(
                5,
                (index) => Row(
                  children: [
                    Text(
                      '${5 - index}',
                      style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width:
                          (int.parse(
                            controller.reviewSummaryPostAllLMB[(5 - index).toString()].toString() ==
                                    'null'
                                ? '0'
                                : controller.reviewSummaryPostAllLMB[(5 - index).toString()]
                                    .toString(),
                          )) /
                          20 *
                          MediaQuery.of(context).size.width,
                      height: 0.01 * MediaQuery.of(context).size.height,
                      color: WAPrimaryColor1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGallerySection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Gallery',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: WADarkColor,
                  ),
                ),
                Text(
                  'View All',
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: WAPrimaryColor1,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 0.02 * MediaQuery.of(context).size.height),
          controller.post['img'] != null
              ? SizedBox(
                height: 0.15 * MediaQuery.of(context).size.height,
                width: 0.95 * MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.post['img'].length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.dialog(
                          Dialog(
                            backgroundColor: Colors.transparent,
                            child: Stack(
                              children: [
                                Image.asset(
                                  controller.post['img'][index]['images_file'],
                                  fit: BoxFit.contain,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 0.01 * MediaQuery.of(context).size.height,
                                    left: 0.7 * MediaQuery.of(context).size.width,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: WALightColor,
                                      child: Icon(Icons.close, color: WAPrimaryColor1, size: 15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: 0.3 * MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: AssetImage(controller.post['img'][index]['images_file']),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget _buildNearbySection(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            'Lokasi Terdekat',
            style: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
        Obx(
          () => Center(
            child: Container(
              width: 0.9 * MediaQuery.of(context).size.width,
              height: 0.08 * MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: WASecondary,
                borderRadius: BorderRadius.circular(30),
              ),
              child:
                  controller.post['category'] != null && controller.post['category'].length > 0
                      ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.post['category'].length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextButton(
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
                              child: Text(
                                controller.post['category'][index]['category_name'] ?? '',
                                style: GoogleFonts.poppins(
                                  color:
                                      controller.nearestCategory.value['category_name'] ==
                                              controller.post['category'][index]['category_name']
                                          ? WADarkColor
                                          : WAPrimaryColor1,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                      : SizedBox(),
            ),
          ),
        ),
        SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
        Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child:
                controller.nearestPostAllLMB.isNotEmpty
                    ? Column(
                      children: List.generate(
                        controller.nearestAll.value == 0
                            ? controller.nearestPostAllLMB.length > 4
                                ? 4
                                : controller.nearestPostAllLMB.length > 1 &&
                                    controller.nearestPostAllLMB.length < 4
                                ? controller.nearestPostAllLMB.length
                                : 1
                            : controller.nearestPostAllLMB.length,
                        (index) => _buildNearestPostItem(context, index),
                      ),
                    )
                    : Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Data tidak tersedia',
                          style: GoogleFonts.montserrat(fontSize: 12),
                        ),
                      ),
                    ),
          ),
        ),
        SizedBox(height: 0.05 * MediaQuery.of(context).size.height),
      ],
    );
  }

  Widget _buildNearestPostItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        // Would navigate to detail in real implementation
        Get.snackbar(
          "Info",
          "Navigating to detail for: ${controller.nearestPostAllLMB[index]['post']['post_title']}",
          backgroundColor: WAPrimaryColor1,
          colorText: WALightColor,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: WASecondary),
        ),
        width: MediaQuery.of(context).size.width,
        height: 0.2 * MediaQuery.of(context).size.height,
        child: Row(
          children: [
            controller.nearestPostAllLMB[index]['post']['img'] != null &&
                    controller.nearestPostAllLMB[index]['post']['img'].length > 0
                ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 0.2 * MediaQuery.of(context).size.height,
                  width: 0.3 * MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                        controller.nearestPostAllLMB[index]['post']['img'][0]['images_file'],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 0.2 * MediaQuery.of(context).size.height,
                  width: 0.3 * MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/img/default_post.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            SizedBox(width: 0.03 * MediaQuery.of(context).size.width),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 0.5 * MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${controller.nearestPostAllLMB[index]['post']['post_title']}',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: WADarkColor,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                      ),
                      Text(
                        '${controller.nearestPostAllLMB[index]['post']['venue']['venue_addr']}',
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: WADarkColor,
                          fontWeight: FontWeight.normal,
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: WAPrimaryColor1, size: 15),
                        const SizedBox(width: 5),
                        Text(
                          '${(controller.nearestPostAllLMB[index]['distance'] / 1000).toStringAsFixed(2)} km',
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            color: WADarkColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 0.1 * MediaQuery.of(context).size.width),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: List.generate(
                        5,
                        (index2) => Icon(
                          Icons.star,
                          color:
                              (index2 + 1) <=
                                      int.parse(
                                        controller
                                            .nearestPostAllLMB[index]['post']['average_rating']
                                            .round()
                                            .toString(),
                                      )
                                  ? WAPrimaryColor1
                                  : WADisableColor,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          const Divider(thickness: 3, color: WASecondary),
          Obx(
            () =>
                controller.userDetailMB.isNotEmpty
                    ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            controller.userDetailMB['user_img'] == ''
                                ? const CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage('assets/img/profile_img.png'),
                                )
                                : CircleAvatar(
                                  radius: 30,
                                  backgroundImage: MemoryImage(
                                    base64Decode(controller.userDetailMB['user_img']),
                                  ),
                                ),
                            SizedBox(width: 0.03 * MediaQuery.of(context).size.width),
                            SizedBox(
                              width: 0.45 * MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${controller.userDetailMB['user_name']}',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    controller.date2(DateTime.now().toString()),
                                    style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 0.05 * MediaQuery.of(context).size.height),
                        SizedBox(
                          width: 0.8 * MediaQuery.of(context).size.width,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Berikan Rating',
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                width: 0.3 * MediaQuery.of(context).size.width,
                                height: 0.01 * MediaQuery.of(context).size.height,
                              ),
                              Row(
                                children: List.generate(
                                  5,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      controller.ratingCB.value = (index + 1);
                                    },
                                    child: Icon(
                                      Icons.star,
                                      color:
                                          (1 + index) <= controller.ratingCB.value
                                              ? WAPrimaryColor1
                                              : WADisableColor,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
                        SizedBox(
                          width: 0.8 * MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Deskripsi Ulasan',
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: 'Berikan review Anda...',
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: WADisableColor,
                                  ),
                                ),
                                controller: komentar,
                                maxLength: 500,
                                maxLines: 3,
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              if (komentar.text.isNotEmpty && controller.ratingCB.value > 0) {
                                // Simulate review submission
                                controller.showCommentAlert("Review berhasil dikirim");
                                komentar.clear();
                                controller.ratingCB.value = 0;
                                controller.idEditedComment.value = 0;
                              } else {
                                Get.snackbar(
                                  "Error",
                                  "Silakan isi rating dan komentar",
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                              }
                            },
                            child: Container(
                              width: 0.4 * MediaQuery.of(context).size.width,
                              height: 0.05 * MediaQuery.of(context).size.height,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: WAPrimaryColor1,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                controller.idEditedComment.value == 0 ? 'Kirim' : 'Update',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: WALightColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 0.05 * MediaQuery.of(context).size.height),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Reviews (${controller.reviewPostAllLMB.length})',
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Obx(
                              () =>
                                  controller.reviewPostAllLMB.isNotEmpty
                                      ? GestureDetector(
                                        onTap: () {
                                          controller.reviewAll.value =
                                              controller.reviewAll.value == 0 ? 1 : 0;
                                        },
                                        child: Text(
                                          controller.reviewAll.value == 0
                                              ? 'View All'
                                              : 'Hide Other',
                                          style: GoogleFonts.roboto(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: WAPrimaryColor1,
                                          ),
                                        ),
                                      )
                                      : SizedBox(),
                            ),
                          ],
                        ),
                        const Divider(thickness: 3, color: WASecondary),
                      ],
                    )
                    : const SizedBox(),
          ),
          SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
          Obx(
            () => Column(
              children: List.generate(
                controller.reviewPostAllLMB.isNotEmpty
                    ? controller.reviewAll.value == 0
                        ? 1
                        : controller.reviewPostAllLMB.length
                    : 0,
                (index) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('assets/img/profile_img.png'),
                        ),
                        SizedBox(width: 0.03 * MediaQuery.of(context).size.width),
                        SizedBox(
                          width: 0.4 * MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${controller.reviewPostAllLMB[index]['user_name']}',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                controller.date2(
                                  controller.reviewPostAllLMB[index]['comment_dttm'],
                                ),
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 0.25 * MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Rating',
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: List.generate(
                                  5,
                                  (index2) => Icon(
                                    Icons.star,
                                    color:
                                        (index2 + 1) <=
                                                int.parse(
                                                  controller
                                                      .reviewPostAllLMB[index]['comment_rating'],
                                                )
                                            ? WAPrimaryColor1
                                            : WADisableColor,
                                    size: 18,
                                  ),
                                ),
                              ),
                              SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.005 * MediaQuery.of(context).size.height),
                    controller.reviewPostAllLMB[index]['comment_txt'] != ''
                        ? Text(
                          '${controller.reviewPostAllLMB[index]['comment_txt']}',
                          style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400),
                          maxLines: controller.reviewPostAllLMB[index]['comment_txt'] == '' ? 1 : 3,
                        )
                        : SizedBox(),
                    const Divider(thickness: 3, color: WASecondary),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}