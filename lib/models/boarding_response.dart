
class BoardingResponse {
  List<Data>? data;
  String? msg;
  bool? res;

  BoardingResponse({this.data, this.msg, this.res});

  BoardingResponse.fromJson(Map<String, dynamic> json) {
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

  static List<BoardingResponse> fromList(List<Map<String, dynamic>> list) {
    return list.map(BoardingResponse.fromJson).toList();
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
  String? id;
  String? img;
  String? title;
  String? description;

  Data({this.id, this.img, this.title, this.description});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["id"] is String) {
      id = json["id"];
    }
    if(json["img"] is String) {
      img = json["img"];
    }
    if(json["title"] is String) {
      title = json["title"];
    }
    if(json["description"] is String) {
      description = json["description"];
    }
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["img"] = img;
    _data["title"] = title;
    _data["description"] = description;
    return _data;
  }
}