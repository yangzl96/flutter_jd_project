// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jd_project/config/index.dart';
import 'package:jd_project/model/FocusModel.dart';
import 'package:jd_project/model/ProductModel.dart';
import 'package:jd_project/utils/autoSize.dart';
import 'package:jd_project/widgets/swiper/index.dart';
import 'package:jd_project/widgets/title/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  
  List _focusData = []; //轮播图
  List _hotList = []; //猜你数据
  List _hotRecommendList = []; // 热门推荐



  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getFocusData();
    _getHotProductData();
    _getHotRecommend();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // 轮播图
        SwiperWidget(_focusData),
        SizedBox(
          height: AutoSize.h(20),
        ),
        const TitleWidget('猜你喜欢'),
        SizedBox(
          height: AutoSize.h(20),
        ),
        _hotProductList(),
        SizedBox(
          height: AutoSize.h(20),
        ),
        const TitleWidget('热门推荐'),
        _recProductWidget()
      ],
    );
  }

  // 猜你喜欢
  Widget _hotProductList() {
    if (_hotList.isNotEmpty) {
      // Listview中嵌套listView的时候，要在外面包一层Container并设置宽高
      // 否则不生效
      return Container(
        height: AutoSize.h(200),
        padding: EdgeInsets.symmetric(horizontal: AutoSize.w(20)),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _hotList.length,
            itemBuilder: (context, index) {
              String sPic = _hotList[index].sPic;
              sPic = Config.domain + sPic.replaceAll('\\', '/');
              return Column(
                children: [
                  Container(
                    height: AutoSize.h(160),
                    margin: EdgeInsets.only(right: AutoSize.w(20)),
                    child: Image.network(
                      sPic,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: AutoSize.h(10)),
                      height: AutoSize.h(34),
                      child: Text('￥${_hotList[index].price}',
                          style: TextStyle(color: Colors.red)))
                ],
              );
            }),
      );
    } else {
      return Text('');
    }
  }

  // 热门推荐
  Widget _recProductWidget() {
    var itemWidth = (AutoSize.getScreenWidth() - 20 - 10) / 2;
    return Container(
      // 这里的数值不使用autosize是因为下面要计算每一个item的宽度
      // 用到的getScreenWidth单位和这里的单位是一样的，所以好计算
      padding: EdgeInsets.all(10),
      child: Wrap(
          runSpacing: 10,
          spacing: 10,
          children: _hotRecommendList.map((value) {
            //图片
            String sPic = value.sPic;
            sPic = Config.domain + sPic.replaceAll('\\', '/');
            return Container(
              padding: EdgeInsets.all(10),
              width: itemWidth,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1, color: Color.fromRGBO(233, 233, 233, 0.9))),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: AspectRatio(
                      aspectRatio: 1 / 1, //防止服务器返回的图片大小不一致，导致高度不一致的问题
                      child: Image.network(sPic),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: AutoSize.h(20)),
                    child: Text('${value.title}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black54)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: AutoSize.h(20)),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '¥${value.price}',
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text('¥${value.oldPrice}',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  decoration: TextDecoration.lineThrough)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }).toList()),
    );
    // 左右pading + 中间
  }

  // 获取轮播图
  _getFocusData() async {
    var api = '${Config.domain}api/focus';
    var result = await Dio().get(api);
    var focusList = FocusModel.fromJson(result.data);
    setState(() {
      _focusData = focusList.result;
    });
  }

  // 获取猜你喜欢
  _getHotProductData() async {
    var api = '${Config.domain}api/plist?is_hot=1';
    var result = await Dio().get(api);
    var hotProductList = ProductModel.fromJson(result.data);
    setState(() {
      _hotList = hotProductList.result!;
    });
  }

  //获取热门推荐
  _getHotRecommend() async {
    var api = '${Config.domain}api/plist?is_best=1';
    var result = await Dio().get(api);
    var recommendList = ProductModel.fromJson(result.data);
    setState(() {
      _hotRecommendList = recommendList.result!;
    });
  }
}
