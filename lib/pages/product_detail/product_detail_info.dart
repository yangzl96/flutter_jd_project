// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:jd_project/widgets/loading/index.dart';

class ProductDetailInfo extends StatefulWidget {
  final List _productContentList;

  ProductDetailInfo(this._productContentList, {Key? key}) : super(key: key);

  @override
  _ProductDetailInfoState createState() => _ProductDetailInfoState();
}

class _ProductDetailInfoState extends State<ProductDetailInfo>
    with AutomaticKeepAliveClientMixin {
  var _flag = true;
  var _id;
  @override
  void initState() {
    super.initState();
    _id = widget._productContentList[0].sId;
    print('https://jdmall.itying.com/pcontent?id=$_id');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _flag ? LoadingWidget() : Text(""),
          Expanded(
              child: InAppWebView(
            //老版本：initialUrl    新版本：initialUrlRequest
            initialUrlRequest: URLRequest(
                url: Uri.parse("https://jdmall.itying.com/pcontent?id=$_id")),
            onProgressChanged:
                (InAppWebViewController controller, int progress) {
              if (progress / 100 > 0.9999) {
                setState(() {
                  _flag = false;
                });
              }
            },
          ))
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
