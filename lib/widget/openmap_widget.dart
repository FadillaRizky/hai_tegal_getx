import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hai_tegal_getx/components/colors.dart';

class OpenMapWidget extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String title;
  final String snippet;

  OpenMapWidget({
    required this.latitude,
    required this.longitude,
    this.title = "Location",
    this.snippet = "",
  });

  void _launchGoogleMaps() async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Get.snackbar(
        "Error",
        "Tidak dapat membuka Google Maps",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchGoogleMaps,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: WASecondary),
        ),
        child: Stack(
          children: [
            FlutterMap(
              options: MapOptions(initialCenter: LatLng(latitude, longitude), initialZoom: 15.0),
              children: [
                // TileLayerOptions(
                //   urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                //   subdomains: ['a', 'b', 'c'],
                // ),
                // MarkerLayerOptions(
                //   markers: [
                //     Marker(
                //       width: 40.0,
                //       height: 40.0,
                //       point: LatLng(latitude, longitude),
                //       builder: (ctx) => Icon(Icons.location_on, color: WAPrimaryColor1, size: 40),
                //     ),
                //   ],
                // ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.touch_app, color: WAPrimaryColor1, size: 30),
                    SizedBox(height: 8),
                    Text(
                      "Tap to open in Google Maps",
                      style: TextStyle(
                        color: WADarkColor,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
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
}
