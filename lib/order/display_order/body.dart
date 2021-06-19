import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Allordersbody extends StatefulWidget {
  @override
  _AllordersbodyState createState() => _AllordersbodyState();
}

class _AllordersbodyState extends State<Allordersbody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: StreamBuilder(
          stream: Firestore.instance.collection("check").orderBy("mydate").snapshots(),
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
                                  Text(
                                    "start date" +
                                        snapshot.data.documents[index]['mydate']
                                            .toDate()
                                            .toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(" to "),
                                  Text(
                                    "end date : " +
                                        snapshot
                                            .data.documents[index]['end_date']
                                            .toDate()
                                            .toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("payment Id :" +
                                      snapshot
                                          .data.documents[index]['payment_id']
                                          .toString()),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("total amount : " + snapshot
                                      .data.documents[index]['total_payment']
                                      .toString()),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("place id : " +
                                      snapshot.data.documents[index]
                                          ['place_id']),
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
