import 'package:flutter/material.dart';
import 'package:jd_project/model/ProductContentModel.dart';
import 'package:jd_project/utils/autoSize.dart';

class CartNum extends StatefulWidget {
  ProductContentitem _itemData;
  CartNum(this._itemData, {Key? key}) : super(key: key);

  @override
  State<CartNum> createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  late ProductContentitem _itemData;
  @override
  void initState() {
    super.initState();
    _itemData = widget._itemData;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AutoSize.w(168),
      decoration: BoxDecoration(
          border: Border.all(width: AutoSize.w(2), color: Colors.black12)),
      child: Row(
        children: [_leftBtn(), _centerArea(), _rightBtn()],
      ),
    );
  }

  // -
  Widget _leftBtn() {
    return InkWell(
      onTap: () {
        if (_itemData.count > 1) {
          setState(() {
            _itemData.count = _itemData.count - 1;
          });
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: AutoSize.w(45),
        height: AutoSize.h(45),
        child: const Text('-'),
      ),
    );
  }

  // 中间个数
  Widget _centerArea() {
    return Container(
      alignment: Alignment.center,
      width: AutoSize.w(70),
      height: AutoSize.h(45),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(width: AutoSize.w(2), color: Colors.black12),
              right: BorderSide(width: AutoSize.w(2), color: Colors.black12))),
      child: Text("${_itemData.count}"),
    );
  }

  // +
  Widget _rightBtn() {
    return InkWell(
      onTap: () {
        setState(() {
          _itemData.count = _itemData.count + 1;
        });
      },
      child: Container(
        alignment: Alignment.center,
        width: AutoSize.w(45),
        height: AutoSize.h(45),
        child: const Text('+'),
      ),
    );
  }
}
