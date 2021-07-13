import 'package:coworkingspace_admin/all_users/body.dart';
import 'package:coworkingspace_admin/category/category_display/body.dart';
import 'package:coworkingspace_admin/order/body.dart';
import 'package:coworkingspace_admin/places/body.dart';
import 'package:flutter/material.dart';

class Choice {
  const Choice({this.title, this.icon,this.routename});
  final String title;
  final IconData icon;
  final String routename;
}

// const String home=MyCatbody.routeanme;

const List<Choice> choices = const <Choice>[
   const Choice(title: 'Category', icon: Icons.home,routename:MyCatbody.routeanme),
   const Choice(title: 'Places', icon: Icons.photo_album,routename:MyplaceBody.routename),
   const Choice(title: 'Order', icon: Icons.photo_album,routename:MyorderBody.routename),
   const Choice(title: 'Users', icon: Icons.contacts_sharp,routename:AllUserBody.routename),
  // const Choice(title: 'Map', icon: Icons.map),
  // const Choice(title: 'Phone', icon: Icons.phone),
  // const Choice(title: 'Camera', icon: Icons.camera_alt),
  // const Choice(title: 'Setting', icon: Icons.settings),
  // const Choice(title: 'Album', icon: Icons.photo_album),
  // const Choice(title: 'WiFi', icon: Icons.wifi),
];