import 'package:coworkingspace_admin/all_users/body.dart';
import 'package:coworkingspace_admin/category/category_display/body.dart';
import 'package:coworkingspace_admin/category/category_add/category_screen.dart';
import 'package:coworkingspace_admin/order/body.dart';
import 'package:coworkingspace_admin/places/add_places/add_screen.dart';
import 'package:coworkingspace_admin/places/body.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
MycatPage.routename: (context) => MycatPage(),
MyCatbody.routeanme:(context)=> MyCatbody(),
MyplaceBody.routename:(context)=>MyplaceBody(),
MyorderBody.routename:(context)=>MyorderBody(),
MyAddPlacesPage.routename:(context)=>MyAddPlacesPage(),
AllUserBody.routename:(context)=>AllUserBody(),
};