
class BannerResponse {
  List<Data>? data;
  String? msg;
  bool? res;

  BannerResponse({this.data, this.msg, this.res});

  BannerResponse.fromJson(Map<String, dynamic> json) {
    if(json["data"] is List) {
      data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    }
    if(json["msg"] is String) {
      msg = json["msg"];
    }
    if(json["res"] is bool) {
      res = json["res"];
    }
  }

  static List<BannerResponse> fromList(List<Map<String, dynamic>> list) {
    return list.map(BannerResponse.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    _data["msg"] = msg;
    _data["res"] = res;
    return _data;
  }
}

class Data {
  String? bannerId;
  String? bannerCategoryId;
  String? bannerTitle;
  dynamic bannerAlt;
  String? bannerFile;
  dynamic bannerUrl;
  dynamic bannerStart;
  dynamic bannerEnd;
  String? bannerSort;
  dynamic bannerHits;
  String? bannerStatus;
  String? bannerDttm;
  String? userId;

  Data({this.bannerId, this.bannerCategoryId, this.bannerTitle, this.bannerAlt, this.bannerFile, this.bannerUrl, this.bannerStart, this.bannerEnd, this.bannerSort, this.bannerHits, this.bannerStatus, this.bannerDttm, this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["banner_id"] is String) {
      bannerId = json["banner_id"];
    }
    if(json["banner_category_id"] is String) {
      bannerCategoryId = json["banner_category_id"];
    }
    if(json["banner_title"] is String) {
      bannerTitle = json["banner_title"];
    }
    bannerAlt = json["banner_alt"];
    if(json["banner_file"] is String) {
      bannerFile = json["banner_file"];
    }
    bannerUrl = json["banner_url"];
    bannerStart = json["banner_start"];
    bannerEnd = json["banner_end"];
    if(json["banner_sort"] is String) {
      bannerSort = json["banner_sort"];
    }
    bannerHits = json["banner_hits"];
    if(json["banner_status"] is String) {
      bannerStatus = json["banner_status"];
    }
    if(json["banner_dttm"] is String) {
      bannerDttm = json["banner_dttm"];
    }
    if(json["user_id"] is String) {
      userId = json["user_id"];
    }
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["banner_id"] = bannerId;
    _data["banner_category_id"] = bannerCategoryId;
    _data["banner_title"] = bannerTitle;
    _data["banner_alt"] = bannerAlt;
    _data["banner_file"] = bannerFile;
    _data["banner_url"] = bannerUrl;
    _data["banner_start"] = bannerStart;
    _data["banner_end"] = bannerEnd;
    _data["banner_sort"] = bannerSort;
    _data["banner_hits"] = bannerHits;
    _data["banner_status"] = bannerStatus;
    _data["banner_dttm"] = bannerDttm;
    _data["user_id"] = userId;
    return _data;
  }
}