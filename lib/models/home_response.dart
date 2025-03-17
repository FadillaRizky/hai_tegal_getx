
class HomeResponse {
  List<Data>? data;
  String? msg;
  bool? res;

  HomeResponse({this.data, this.msg, this.res});

  HomeResponse.fromJson(Map<String, dynamic> json) {
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

  static List<HomeResponse> fromList(List<Map<String, dynamic>> list) {
    return list.map(HomeResponse.fromJson).toList();
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
  String? mobileHomeId;
  String? titleHome;
  String? categoryId;
  String? limitData;
  String? kataKunci;
  String? orderBy;

  Data({this.mobileHomeId, this.titleHome, this.categoryId, this.limitData, this.kataKunci, this.orderBy});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["mobile_home_id"] is String) {
      mobileHomeId = json["mobile_home_id"];
    }
    if(json["title_home"] is String) {
      titleHome = json["title_home"];
    }
    if(json["category_id"] is String) {
      categoryId = json["category_id"];
    }
    if(json["limit_data"] is String) {
      limitData = json["limit_data"];
    }
    if(json["kata_kunci"] is String) {
      kataKunci = json["kata_kunci"];
    }
    if(json["order_by"] is String) {
      orderBy = json["order_by"];
    }
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["mobile_home_id"] = mobileHomeId;
    _data["title_home"] = titleHome;
    _data["category_id"] = categoryId;
    _data["limit_data"] = limitData;
    _data["kata_kunci"] = kataKunci;
    _data["order_by"] = orderBy;
    return _data;
  }
}