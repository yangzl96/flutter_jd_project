import 'package:flutter/material.dart';
import 'package:jd_project/utils/autoSize.dart';

class CartNum extends StatefulWidget {
  CartNum({Key? key}) : super(key: key);

  @override
  State<CartNum> createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: AutoSize.w(164),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: [_leftBtn(), _centerArea(), _rightBtn()],
      ),
    );
  }

  // -
  Widget _leftBtn() {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        width: AutoSize.w(45),
        height: AutoSize.h(45),
        child: const Text('-'),
      ),
    );
  }

  // 个数
  Widget _centerArea() {
    return Container(
        alignment: Alignment.center,
        width: AutoSize.w(70),
        height: AutoSize.h(45),
        decoration: const BoxDecoration(
            border: Border(
                left: BorderSide(width: 1, color: Colors.black12),
                right: BorderSide(width: 1, color: Colors.black12))),
        child: const Text('1'));
  }

  // +
  Widget _rightBtn() {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        width: AutoSize.w(45),
        height: AutoSize.h(45),
        child: const Text('+'),
      ),
    );
  }
}
