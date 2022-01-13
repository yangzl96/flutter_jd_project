// ignore_for_file: prefer_const_constructors, unused_field

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jd_project/config/index.dart';
import 'package:jd_project/model/CateModel.dart';
import 'package:jd_project/utils/autoSize.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  int _selectIndex = 0;
  List _leftCateList = [];
  List _rightCateList = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getLeftCateList();
  }

  // 获取左侧数据
  _getLeftCateList() async {
    var api = '${Config.domain}api/pcate';
    var result = await Dio().get(api);
    var leftCateList = CateModel.fromJson(result.data);
    setState(() {
      _leftCateList = leftCateList.result!;
    });
    // 先查左侧第一个大类的子数据
    _getRightCateList(leftCateList.result![0].id);
  }

  // 获取右侧数据
  _getRightCateList(pid) async {
    var api = '${Config.domain}api/pcate?pid=$pid';
    var result = await Dio().get(api);
    var rightCateList = CateModel.fromJson(result.data);
    setState(() {
      _rightCateList = rightCateList.result!;
    });
  }

  @override
  Widget build(BuildContext context) {
    // /计算右侧GridView宽高比
    //左侧宽度

    var leftWidth = AutoSize.getScreenWidth() / 4;

    //右侧每一项宽度=（总宽度-左侧宽度-GridView外侧元素左右的Padding值-GridView中间的间距）/3

    var rightItemWidth = (AutoSize.getScreenWidth() - leftWidth - 20 - 20) / 3;

    //获取计算后的宽度
    rightItemWidth = AutoSize.w(rightItemWidth);

    //获取计算后的高度
    var rightItemHeight = rightItemWidth + AutoSize.h(28);
    return Row(
      children: [
        _leftCateWidget(leftWidth),
        _rightCateWidget(rightItemWidth, rightItemHeight)
      ],
    );
  }

  // 左侧
  Widget _leftCateWidget(leftWidth) {
    if (_leftCateList.isNotEmpty) {
      return SizedBox(
        width: leftWidth,
        height: double.infinity,
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectIndex = index;
                      _getRightCateList(_leftCateList[index].id);
                    });
                  },
                  child: Container(
                    height: AutoSize.h(84),
                    child: Text('${_leftCateList[index].title}',
                        textAlign: TextAlign.center),
                    padding: EdgeInsets.only(top: AutoSize.h(28)),
                    width: double.infinity,
                    color: _selectIndex == index
                        ? Color.fromRGBO(240, 246, 246, 0.9)
                        : Colors.white,
                  ),
                ),
                const Divider(
                  height: 1,
                )
              ],
            );
          },
          itemCount: _leftCateList.length,
        ),
      );
    } else {
      return SizedBox(width: leftWidth, height: double.infinity);
    }
  }

  // 右侧
  Widget _rightCateWidget(rightItemWidth, rightItemHeight) {
    if (_rightCateList.isNotEmpty) {
      return Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(10),
            color: Color.fromRGBO(240, 246, 246, 0.9),
            height: double.infinity,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: rightItemWidth / rightItemHeight,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: _rightCateList.length,
                itemBuilder: (ctx, index) {
                  String pic = _rightCateList[index].pic;
                  pic = Config.domain + pic.replaceAll('\\', '/');
                  return Container(
                    child: Column(
                      children: [
                        AspectRatio(
                            aspectRatio: 1 / 1,
                            child: Image.network(pic, fit: BoxFit.cover)),
                        Container(
                            padding: EdgeInsets.only(top: AutoSize.h(5)),
                            height: AutoSize.h(33),
                            child: Text(
                              '${_rightCateList[index].title}',
                            ))
                      ],
                    ),
                  );
                }),
          ));
    } else {
      return Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.all(10),
              child: Text('加载中'),
              color: Color.fromRGBO(240, 246, 246, 0.9),
              height: double.infinity));
    }
  }
}
