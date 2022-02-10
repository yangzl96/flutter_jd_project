// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:jd_project/pages/cart/cart_item.dart';
import 'package:jd_project/utils/autoSize.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('购物车'),
        actions: [IconButton(onPressed: null, icon: Icon(Icons.launch))],
      ),
      body: Stack(
        children: [
          ListView(
            children: [CartItem(), CartItem(), CartItem()],
          ),
          Positioned(
              bottom: 0,
              width: AutoSize.w(750),
              height: AutoSize.h(80),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(width: 1, color: Colors.black12)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              width: AutoSize.w(60),
                              child: Checkbox(
                                  onChanged: (v) {},
                                  value: false,
                                  activeColor: Colors.red),
                            ),
                            Text('全选')
                          ],
                        ),
                      ),
                      Container(
                        child: Container(
                          width: AutoSize.w(200),
                          padding: EdgeInsets.only(right: AutoSize.w(10)),
                          child: ElevatedButton(
                            child: Text('结算',
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                          ),
                        ),
                      )
                    ],
                  )))
        ],
      ),
    );
  }
}
