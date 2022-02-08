// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '加载中...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            CircularProgressIndicator(
              strokeWidth: 1,
              backgroundColor: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
