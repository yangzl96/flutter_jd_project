// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:jd_project/utils/autoSize.dart';
import 'package:jd_project/widgets/swiper/index.dart';
import 'package:jd_project/widgets/title/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map> imgList = [
    {"url": "https://www.itying.com/images/flutter/slide01.jpg"},
    {"url": "https://www.itying.com/images/flutter/slide02.jpg"},
    {"url": "https://www.itying.com/images/flutter/slide03.jpg"},
  ];
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // 轮播图
        SwiperWidget(imgList),
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
        Container(
          // 这里的数值不使用autosize是因为下面要计算每一个item的宽度
          // 用到的getScreenWidth单位和这里的单位是一样的，所以好计算
          padding: EdgeInsets.all(10),
          child: Wrap(
            runSpacing: 10,
            spacing: 10,
            children: [
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget()
            ],
          ),
        )
      ],
    );
  }

  // 热门商品
  Widget _hotProductList() {
    // Listview中嵌套listView的时候，要在外面包一层Container并设置宽高
    // 否则不生效
    return Container(
      height: AutoSize.h(200),
      padding: EdgeInsets.symmetric(horizontal: AutoSize.w(20)),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  height: AutoSize.h(160),
                  margin: EdgeInsets.only(right: AutoSize.w(20)),
                  child: Image.network(
                    'https://www.itying.com/images/flutter/hot${index + 1}.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top: AutoSize.h(10)),
                    height: AutoSize.h(34),
                    child: Text('第$index条'))
              ],
            );
          }),
    );
  }

  // 推荐商品
  Widget _recProductItemWidget() {
    // 左右pading + 中间
    var itemWidth = (AutoSize.getScreenWidth() - 20 - 10) / 2;
    return Container(
      padding: EdgeInsets.all(10),
      width: itemWidth,
      decoration: BoxDecoration(
          border:
              Border.all(width: 1, color: Color.fromRGBO(233, 233, 233, 0.9))),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: AspectRatio(
              aspectRatio: 1 / 1, //防止服务器返回的图片大小不一致，导致高度不一致的问题
              child:
                  Image.network('https://itying.com/images/flutter/list1.jpg'),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: AutoSize.h(20)),
            child: Text('2021夏季新款气质高贵洋气阔太太女人味中长款宽松大码',
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
                    '￥123',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('￥56',
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
  }
}
