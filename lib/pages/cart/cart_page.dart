// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:jd_project/pages/cart/cart_item.dart';
import 'package:jd_project/provider/Cart.dart';
import 'package:jd_project/utils/autoSize.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // 是否编辑
  bool _isEdit = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 获取provider cart
    var cartProvider = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('购物车'),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    _isEdit = !_isEdit;
                  });
                },
                icon: Icon(Icons.launch))
          ],
        ),
        body: cartProvider.cartList.isNotEmpty
            ? Stack(
                children: [
                  ListView(
                    // 遍历购物车数据
                    children: cartProvider.cartList.map((value) {
                      return CartItem(value);
                    }).toList(),
                  ),
                  Positioned(
                      bottom: 0,
                      width: AutoSize.w(750),
                      height: AutoSize.h(80),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                top: BorderSide(
                                    width: 1, color: Colors.black12)),
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
                                          onChanged: (v) {
                                            // 实现全选反选
                                            cartProvider.checkedAll(v);
                                          },
                                          value: cartProvider.isCheckedAll,
                                          activeColor: Colors.red),
                                    ),
                                    Text('全选'),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    _isEdit == false ? Text('合计:') : Text(''),
                                    _isEdit == false
                                        ? Text("${cartProvider.allPrice}",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.red))
                                        : Text('')
                                  ],
                                ),
                              ),
                              _isEdit == false
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          right: AutoSize.w(16)),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: ElevatedButton(
                                            onPressed: () {},
                                            child: Text(
                                              '结算',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            style: ButtonStyle(
                                                padding:
                                                    MaterialStateProperty.all(
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8)),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.red))),
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.only(
                                          right: AutoSize.w(16)),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: ElevatedButton(
                                          child: Text("删除",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.red)),
                                          onPressed: () {
                                            cartProvider.removeItem();
                                          },
                                        ),
                                      ),
                                    ),
                              // Container(
                              //   child: Container(
                              //     width: AutoSize.w(200),
                              //     padding:
                              //         EdgeInsets.only(right: AutoSize.w(10)),
                              //     child: ElevatedButton(
                              //       child: Text('结算',
                              //           style: TextStyle(color: Colors.white)),
                              //       onPressed: () {},
                              //       style: ButtonStyle(
                              //           backgroundColor:
                              //               MaterialStateProperty.all(
                              //                   Colors.red)),
                              //     ),
                              //   ),
                              // )
                            ],
                          )))
                ],
              )
            : Center(
                child: Text('购物车空空如也 ~'),
              ));
  }
}
