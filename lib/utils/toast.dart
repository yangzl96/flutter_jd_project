import 'package:fluttertoast/fluttertoast.dart';

class ShowToast {
  static toast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.CENTER,
    );
  }
}
