// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jd_project/pages/cart/cart_num.dart';
import 'package:jd_project/utils/autoSize.dart';

class CartItem extends StatefulWidget {
  CartItem({Key? key}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: AutoSize.w(200),
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: [
          Container(
            width: AutoSize.w(60),
            child: Checkbox(
              onChanged: (v) {},
              value: true,
              activeColor: Colors.red,
            ),
          ),
          Container(
            width: AutoSize.w(160),
            child: Image.network(
                "https://www.itying.com/images/flutter/list2.jpg",
                fit: BoxFit.cover),
          ),
          Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'xxxxxxxxxxxxxxxxx',
                      maxLines: 2,
                    ),
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '￥12',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CartNum(),
                        )
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
