import 'package:coworkingspace_admin/order/display_order/body.dart';
import 'package:flutter/material.dart';

class MyorderBody extends StatelessWidget {
  static const String routename="\oredrbody";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("oreder"),
          ),
          body: Allordersbody(),
          ),          
    );
  }
}


