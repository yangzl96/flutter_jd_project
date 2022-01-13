// ignore_for_file: unnecessary_new, unnecessary_this, file_names, prefer_collection_literals, curly_braces_in_flow_control_structures

class CateModel {
  List<CateItemModel>? result;

  CateModel({this.result});

  CateModel.fromJson(Map<String, dynamic> json) {
    this.result = json["result"] == null
        ? null
        : (json["result"] as List)
            .map((e) => CateItemModel.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null)
      data["result"] = this.result?.map((e) => e.toJson()).toList();
    return data;
  }
}

class CateItemModel {
  String? id;
  String? title;
  Object? status;
  String? pic;
  String? pid;
  String? sort;

  CateItemModel(
      {this.id, this.title, this.status, this.pic, this.pid, this.sort});

  CateItemModel.fromJson(Map<String, dynamic> json) {
    this.id = json["_id"];
    this.title = json["title"];
    this.status = json["status"];
    this.pic = json["pic"];
    this.pid = json["pid"];
    this.sort = json["sort"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["_id"] = this.id;
    data["title"] = this.title;
    data["status"] = this.status;
    data["pic"] = this.pic;
    data["pid"] = this.pid;
    data["sort"] = this.sort;
    return data;
  }
}
