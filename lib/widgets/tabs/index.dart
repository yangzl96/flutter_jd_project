// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jd_project/constants/index.dart';
import 'package:jd_project/utils/autoSize.dart';

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  PageController? _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex != 3
          ? AppBar(
            // elevation: 0,
              leading: IconButton(
                  icon: Icon(
                    Icons.center_focus_weak,
                    color: Colors.black87,
                    size: 28,
                  ),
                  onPressed: () {}),
              title: GestureDetector(
                child: Container(
                  height: AutoSize.h(60),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 233, 233, 0.8),
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.search),
                        Text('笔记本', style: TextStyle(fontSize: AutoSize.sp(28)))
                      ]),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/search');
                },
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.message,
                      color: Colors.black87,
                      size: 28,
                    ))
              ],
            )
          : AppBar(
              title: Text('用户中心'),
            ),

      // 方案一：IndexedStack：实现状态保存 原来直接是 pageList[_currentIndex]
      // 会导致每次切换页面都在加载数据 但是这个方案也存在问题
      // 就是一次会加载四个页面 并且如果购物车的数据需要更新？就没有办法了
      // 方案二：AutomaticKeepAliveClientMixin
      // 需要使用pageView将页面包裹起来才可以使用

      body: PageView(
        controller: _pageController,
        children: pageList,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        selectedItemColor: Colors.red,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController!.jumpToPage(_currentIndex);
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: '分类'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: '购物车'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: '我的'),
        ],
      ),
    );
  }
}
