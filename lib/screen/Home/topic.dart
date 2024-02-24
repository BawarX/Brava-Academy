import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class topcDescTest extends StatefulWidget {
  topcDescTest({super.key, required this.title});
  String title;
  @override
  State<topcDescTest> createState() => _topcDescTestState();
}

class _topcDescTestState extends State<topcDescTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.title),
        ],
      ),
    );
  }
}
