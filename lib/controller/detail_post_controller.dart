import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hai_tegal_getx/components/colors.dart';

class DetailPostController extends GetxController {
  var isLoading = true.obs;
  var post = {}.obs;
  var isSaved = 0.obs;
  var readAll = 0.obs;
  var venueHoursAll = 0.obs;
  var costAll = 0.obs;
  var reviewAll = 0.obs;
  var nearestAll = 0.obs;
  var ratingCB = 0.obs;
  var idEditedComment = 0.obs;
  var screenshotProcess = 0.obs;
  var nearestCategory = {}.obs;
  var reviewPostAllLMB = [].obs;
  var reviewSummaryPostAllLMB = {
    "1": 2,
    "2": 5,
    "3": 15,
    "4": 18,
    "5": 8,
  }.obs;
  var averageReviewCB = {"average": 4.2}.obs;
  var nearestPostAllLMB = [].obs;
  var userDetailMB = {}.obs;
  var markers = {}.obs;
  
  // Mock location data
  var latitudeUserCB = "-6.8900".obs;
  var longitudeUserCB = "109.1200".obs;

  // Method to launch Google Maps
  Future<void> openMap(double lat, double lng) async {
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

  void loadPostDetails() {
    isLoading.value = true;
    
    // Simulate API delay
    Future.delayed(Duration(milliseconds: 800), () {
      // Set static data
      post.value = getMockPostData();
      reviewPostAllLMB.value = getMockReviews();
      nearestPostAllLMB.value = getMockNearestPosts();
      userDetailMB.value = getMockUserData();
      
      isLoading.value = false;
    });
  }
  
  void cekBookMark() {
    // For static implementation, just toggle between 0 and 1
    isSaved.value = isSaved.value == 0 ? 1 : 0;
  }
  
  void loadReviewPostIndex(String postId) {
    // Static implementation - reviews already loaded in loadPostDetails
  }
  
  void loadNearestPostIndex(String lat, String lng, String categoryId) {
    // Static implementation - nearby posts already loaded in loadPostDetails
  }
  
  String dayCheck(String day) {
    switch(day) {
      case "1": return "Senin";
      case "2": return "Selasa";
      case "3": return "Rabu";
      case "4": return "Kamis";
      case "5": return "Jumat";
      case "6": return "Sabtu";
      case "7": return "Minggu";
      default: return "";
    }
  }
  
  String date2(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      return "${date.day}-${date.month}-${date.year}";
    } catch (e) {
      return dateString;
    }
  }
  
  String rupiah(double value) {
    return value.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  }
  
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    // In real implementation, this would calculate actual distance
    // For static version, returning a static value
    return 2.5;
  }
  
  Map<String, dynamic> getMockPostData() {
    return {
      "post_id": "1",
      "post_title": "Pantai Alam Indah",
      "post_short": "Pantai Alam Indah adalah sebuah pantai yang terletak di Kota Tegal, Jawa Tengah. Pantai ini menjadi salah satu destinasi wisata yang populer bagi masyarakat sekitar dan wisatawan dari luar daerah. Dengan hamparan pasir putih yang luas dan air laut yang jernih, pantai ini menawarkan pemandangan yang indah dan menenangkan.\n\nPengunjung dapat menikmati berbagai aktivitas seperti berenang, bermain pasir, atau sekadar bersantai sambil menikmati pemandangan matahari terbenam. Terdapat juga berbagai fasilitas seperti gazebo, area bermain anak, dan warung-warung yang menyajikan makanan laut segar dan masakan tradisional Tegal.",
      "img": [
        {"images_file": "assets/img/default_post.jpg"},
        {"images_file": "assets/img/default_post.jpg"},
        {"images_file": "assets/img/default_post.jpg"},
      ],
      "venue": {
        "venue_id": "v1",
        "venue_addr": "Jl. Pantai Alam Indah, Kelurahan Mintaragen, Kota Tegal",
        "venue_x_coordinat": "-6.8543",
        "venue_y_coordinat": "109.1425",
      },
      "village": {
        "village_nm": "Mintaragen",
      },
      "district": {
        "district_nm": "Tegal Timur",
      },
      "city": {
        "city_nm": "Kota Tegal",
      },
      "category": [
        {"category_id": "c1", "category_name": "Wisata Pantai"},
        {"category_id": "c2", "category_name": "Rekreasi Keluarga"},
        {"category_id": "c3", "category_name": "Kuliner"},
      ],
      "event": [
        {
          "event_location": "Festival Pantai Tegal",
          "event_start_date": "2025-04-15",
          "event_end_date": "2025-04-17",
          "event_poster_img": "assets/img/default_post.jpg",
        }
      ],
      "cost": [
        {"cost_name": "Tiket Masuk Dewasa", "cost_price": "15000"},
        {"cost_name": "Tiket Masuk Anak-anak", "cost_price": "7500"},
        {"cost_name": "Parkir Motor", "cost_price": "5000"},
        {"cost_name": "Parkir Mobil", "cost_price": "10000"},
      ],
      "venue_hours": [
        {"operational_day": "1", "operational_open": "07:00", "operational_closed": "18:00"},
        {"operational_day": "2", "operational_open": "07:00", "operational_closed": "18:00"},
        {"operational_day": "3", "operational_open": "07:00", "operational_closed": "18:00"},
        {"operational_day": "4", "operational_open": "07:00", "operational_closed": "18:00"},
        {"operational_day": "5", "operational_open": "07:00", "operational_closed": "18:00"},
        {"operational_day": "6", "operational_open": "06:00", "operational_closed": "19:00"},
        {"operational_day": "7", "operational_open": "06:00", "operational_closed": "19:00"},
      ],
      "average_rating": 4,
      "total_review": 48,
      "total_index": 12,
    };
  }
  
  List<Map<String, dynamic>> getMockReviews() {
    return [
      {
        "comment_id": "1",
        "user_id": "u1",
        "user_name": "John Doe",
        "user_img": "",
        "comment_txt": "Pantainya sangat indah dan bersih! Cocok untuk liburan keluarga.",
        "comment_rating": "5",
        "comment_dttm": "2025-03-10 14:20:00",
      },
      {
        "comment_id": "2",
        "user_id": "u2",
        "user_name": "Jane Smith",
        "user_img": "",
        "comment_txt": "Pemandangan sunset-nya luar biasa. Sayang toiletnya kurang bersih.",
        "comment_rating": "4",
        "comment_dttm": "2025-03-05 16:45:00",
      },
      {
        "comment_id": "3",
        "user_id": "u3",
        "user_name": "Ahmad Fauzi",
        "user_img": "",
        "comment_txt": "Tempatnya nyaman, tapi agak ramai di akhir pekan.",
        "comment_rating": "4",
        "comment_dttm": "2025-02-28 09:30:00",
      },
    ];
  }
  
  List<Map<String, dynamic>> getMockNearestPosts() {
    return [
      {
        "distance": 2500,
        "post": {
          "post_id": "2",
          "post_title": "Warung Seafood Bahari",
          "img": [{"images_file": "assets/img/default_post.jpg"}],
          "venue": {
            "venue_addr": "Jl. Pantai Alam Indah No. 10, Kota Tegal",
            "venue_x_coordinat": "-6.8550",
            "venue_y_coordinat": "109.1430",
          },
          "average_rating": 4,
        },
      },
      {
        "distance": 3700,
        "post": {
          "post_id": "3",
          "post_title": "Penginapan Tepi Pantai",
          "img": [{"images_file": "assets/img/default_post.jpg"}],
          "venue": {
            "venue_addr": "Jl. Pantai Alam Indah No. 25, Kota Tegal",
            "venue_x_coordinat": "-6.8560",
            "venue_y_coordinat": "109.1440",
          },
          "average_rating": 5,
        },
      },
      {
        "distance": 5100,
        "post": {
          "post_id": "4",
          "post_title": "Taman Wisata Kota",
          "img": [{"images_file": "assets/img/default_post.jpg"}],
          "venue": {
            "venue_addr": "Jl. Ahmad Yani No. 5, Kota Tegal",
            "venue_x_coordinat": "-6.8600",
            "venue_y_coordinat": "109.1500",
          },
          "average_rating": 3,
        },
      },
    ];
  }
  
  Map<String, dynamic> getMockUserData() {
    return {
      "user_id": "u1",
      "user_name": "Visitor",
      "user_img": "", // Empty for default image
    };
  }
  
  @override
  void onInit() {
    super.onInit();
    loadPostDetails();
  }

  // Helper function for UI demo
  void showCommentAlert(String message) {
    Get.snackbar(
      "Info",
      message,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}