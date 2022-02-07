// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:jd_project/utils/autoSize.dart';
import 'package:jd_project/widgets/button/index.dart';

class ProductDetailMain extends StatefulWidget {
  ProductDetailMain({Key? key}) : super(key: key);

  @override
  _ProductDetailMainState createState() => _ProductDetailMainState();
}

class _ProductDetailMainState extends State<ProductDetailMain> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                'https://www.itying.com/images/flutter/p1.jpg',
                fit: BoxFit.cover,
              )),
          Container(
              padding: EdgeInsets.only(top: 10),
              child: Text('联想阿达是被盗号ad啊大安市啊啊大ad阿斯达 阿斯达啊萨达萨达啊 是',
                  style: TextStyle(
                      color: Colors.black87, fontSize: AutoSize.sp(36)))),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              '子标题子标题子标题子标题子标题子标题子标题子标题',
              style:
                  TextStyle(color: Colors.black54, fontSize: AutoSize.sp(28)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(children: [
              Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Text('特价：'),
                      Text('￥22',
                          style: TextStyle(
                              color: Colors.red, fontSize: AutoSize.sp(36)))
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('原价：'),
                      Text('￥50',
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.black38,
                              fontSize: AutoSize.sp(28)))
                    ],
                  ))
            ]),
          ),
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              height: AutoSize.h(80),
              child: InkWell(
                onTap: () {
                  _attrBottomSheet();
                },
                child: Row(
                  children: [
                    Text(
                      '已选：',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('115，黑色，XL，1件')
                  ],
                ),
              ),
            ),
          ),
          Divider(),
          Container(
            height: AutoSize.h(80),
            child: Row(
              children: [
                Text(
                  '运费：',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('免运费')
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  // 选择商品类型
  void _attrBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return GestureDetector(
              onTap: () {},
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(AutoSize.w(20)),
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            Wrap(
                              children: [
                                // 左侧名称
                                Container(
                                  width: AutoSize.w(100),
                                  padding: EdgeInsets.only(top: AutoSize.h(30)),
                                  child: Text(
                                    '颜色：',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                // 右侧选项
                                Container(
                                  width: AutoSize.w(610),
                                  child: Wrap(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: Chip(
                                          label: Text('白色'),
                                          padding: EdgeInsets.all(10),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: Chip(
                                          label: Text('白色'),
                                          padding: EdgeInsets.all(10),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: Chip(
                                          label: Text('白色'),
                                          padding: EdgeInsets.all(10),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: Chip(
                                          label: Text('白色'),
                                          padding: EdgeInsets.all(10),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: Chip(
                                          label: Text('白色'),
                                          padding: EdgeInsets.all(10),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      width: AutoSize.w(750),
                      height: AutoSize.h(76),
                      child: Row(children: [
                        Container(
                          width: AutoSize.w(750),
                          height: AutoSize.h(76),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: ButtonWidget(
                                        color: Color.fromRGBO(253, 1, 0, 0.9),
                                        text: '加入购物车',
                                        cb: () {}),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: ButtonWidget(
                                        color: Color.fromRGBO(255, 165, 0, 0.9),
                                        text: '立即购买',
                                        cb: () {}),
                                  ))
                            ],
                          ),
                        )
                      ]))
                ],
              ));
        });
  }
}
