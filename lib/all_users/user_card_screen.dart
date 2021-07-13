// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget { 
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: StreamBuilder(
          stream: Firestore.instance.collection("userdetails").snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // widget.ontotalusers(snapshot.data.documents.length);
            // setState(() {
            //                   count=snapshot.data.documents.length;
            //                 });
            if (!snapshot.hasData) {
              return Text("empty");
            }
            if (snapshot.hasError) {
              return Text("error");
            }
            return Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "TOTAL USERS : " + snapshot.data.documents.length.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: List.generate(
                    snapshot.data.documents.length,
                    (index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: double.infinity,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              margin:
                                  EdgeInsets.only(left: 20, right: 20, top: 10),
                              elevation: 6,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  //(snapshot.data.containsKey("firstname"))?
                                  Text(
                                    snapshot.data.documents[index]['firstname']
                                            .toUpperCase() +
                                        " " +
                                        snapshot
                                            .data.documents[index]['lastname']
                                            .toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  //:Text(""),
                                  
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // (snapshot.data.documents[index].containsKey('address'))?
                                  Text(snapshot.data.documents[index]
                                      ['address']),//:Container(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // (snapshot.data.documents[index].containsKey('email'))?
                                  Text(snapshot.data.documents[index]['email']),//:Container(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // (snapshot.data.documents[index].containsKey('phone number'))?
                                  Text(snapshot.data.documents[index]
                                      ['phone number']),//:Container(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.redAccent[700],
                                      ),
                                      onPressed: () {
                                        Firestore.instance
                                            .collection("userdetails")
                                            .document(snapshot.data
                                                .documents[index].documentID)
                                            .delete();
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
