// ignore_for_file: file_names

class ProductContentModel {
  late ProductContentitem result;

  ProductContentModel({
    required this.result,
  });

  ProductContentModel.fromJson(Map<String, dynamic> json) {
    result = ProductContentitem.fromJson(json['result']);
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['result'] = result.toJson();
    return _data;
  }
}

class ProductContentitem {
  //可为空的字段就设置成可为空空
  String? sId;
  String? title;
  String? cid;
  Object? price;
  Object? oldPrice;
  Object? isBest;
  Object? isHot;
  Object? isNew;
  late List<Attr> attr; //不可为空
  Object? status;
  late String pic; //不可为空
  String? content;
  String? cname;
  int? salecount;
  String? subTitle;

  ProductContentitem({
    this.sId,
    this.title,
    this.cid,
    this.price,
    this.oldPrice,
    this.isBest,
    this.isHot,
    this.isNew,
    required this.attr,
    this.status,
    required this.pic,
    this.content,
    this.cname,
    this.salecount,
    this.subTitle,
  });

  ProductContentitem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    cid = json['cid'];
    price = json['price'];
    oldPrice = json['old_price'];
    isBest = json['is_best'];
    isHot = json['is_hot'];
    isNew = json['is_new'];
    attr =
        List<dynamic>.from(json['attr']).map((e) => Attr.fromJson(e)).toList();
    status = json['status'];
    pic = json['pic'];
    content = json['content'];
    cname = json['cname'];
    salecount = json['salecount'];
    subTitle = json['sub_title'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = sId;
    _data['title'] = title;
    _data['cid'] = cid;
    _data['price'] = price;
    _data['old_price'] = oldPrice;
    _data['is_best'] = isBest;
    _data['is_hot'] = isHot;
    _data['is_new'] = isNew;
    _data['attr'] = attr.map((e) => e.toJson()).toList();
    _data['status'] = status;
    _data['pic'] = pic;
    _data['content'] = content;
    _data['cname'] = cname;
    _data['salecount'] = salecount;
    _data['sub_title'] = subTitle;
    return _data;
  }
}

class Attr {
  late String cate;
  late List<String> list;
  List<Map> attrList = []; //自定义的attrList
  Attr({
    required this.cate,
    required this.list,
  });

  Attr.fromJson(Map<String, dynamic> json) {
    cate = json['cate'];
    list = List<String>.from(json['list']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cate'] = cate;
    _data['list'] = list;
    return _data;
  }
}
