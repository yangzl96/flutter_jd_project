// ignore_for_file: file_names, prefer_collection_literals, curly_braces_in_flow_control_structures

class ProductModel {
  List<ProductItemModel>? result;

  ProductModel({this.result});

  ProductModel.fromJson(Map<String, dynamic> json) {
    result = json["result"] == null
        ? null
        : (json["result"] as List).map((e) => ProductItemModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (result != null)
      data["result"] = result?.map((e) => e.toJson()).toList();
    return data;
  }
}

class ProductItemModel {
  String? id;
  String? title;
  String? cid;
  Object? price;
  Object? oldPrice;
  String? pic;
  String? sPic;

  ProductItemModel(
      {this.id,
      this.title,
      this.cid,
      this.price,
      this.oldPrice,
      this.pic,
      this.sPic});

  ProductItemModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    title = json["title"];
    cid = json["cid"];
    price = json["price"];
    oldPrice = json["old_price"];
    pic = json["pic"];
    sPic = json["s_pic"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["_id"] = id;
    data["title"] = title;
    data["cid"] = cid;
    data["price"] = price;
    data["old_price"] = oldPrice;
    data["pic"] = pic;
    data["s_pic"] = sPic;
    return data;
  }
}
