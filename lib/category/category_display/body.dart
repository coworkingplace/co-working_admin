import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coworkingspace_admin/category/category_edit/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../category_add/body.dart';

class MyCatbody extends StatefulWidget {
  static const String routeanme = "\displaycategory";

  @override
  _MyCatbodyState createState() => _MyCatbodyState();
}

class _MyCatbodyState extends State<MyCatbody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        elevation: 9,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Mybody();
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      appBar: AppBar(
        title: Text("category"),
      ),
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance.collection("category").snapshots(),
          // initialData: initialData ,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                    elevation: 6,
                    child: Container(
                      child: Column(
                        children: [
                          Image.network(
                            "${snapshot.data.documents[index]['icon']}",
                          ),
                          Text(
                            "${snapshot.data.documents[index]['name']}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: double.infinity,
                            height: 50,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: List.from(snapshot
                                        .data.documents[index]['cat_type'])
                                    .length,
                                itemBuilder: (context, indexcat) {
                                  return Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: ChoiceChip(
                                      label: Text(
                                          "${snapshot.data.documents[index]['cat_type'][indexcat].toString()}"),
                                      selected: true,
                                      selectedColor: Colors.amber,
                                      // onSelected: (bool selected) {
                                      // setState(() {
                                      //   _choiceIndex = selected ? index : 0;
                                      // });
                                      // },
                                      // backgroundColor: Colors.green,
                                      labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  );
                                }),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // delete
                              IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.redAccent[700],
                                  ),
                                  onPressed: () {
                                    //  print("????????????????????<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>!!!!!!!!!!!!!@@@@@@@@@@@@@");
                                    Firestore.instance
                                        .collection("category")
                                        .document(snapshot.data.documents[index].documentID)
                                        .delete();
                                    //  print(snapshot.data.documents[index].documentID);
                                    //  print("????????????????????<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>!!!!!!!!!!!!!@@@@@@@@@@@@@");
                                  }),
                              // edit
                              IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                                          print(snapshot.data.documents[index]['name']);
                                          print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                                          return MyCatEditBody(catNAME: snapshot.data.documents[index]['name'],chipFilter: snapshot.data.documents[index]['cat_type'],img: snapshot.data.documents[index]['icon'],);
                                        });
                                  }),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
