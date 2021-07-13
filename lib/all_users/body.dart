import 'package:coworkingspace_admin/all_users/user_card_screen.dart';
import 'package:flutter/material.dart';

class AllUserBody extends StatefulWidget {
  static const String routename="\allusers";

  @override
  _AllUserBodyState createState() => _AllUserBodyState();
}

class _AllUserBodyState extends State<AllUserBody> {

  int count=0;
  @override
  void initState() { 
    super.initState();

  //  List<DocumentSnapshot> _myDocCount = _myDoc.documents;
  //   count=_myDocCount.length;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text("user"),
              // Text("$count"),
            ],
          ) ,
          ),
          body: UserScreen(),
          ),
      
    );
  }
}