import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coworkingspace_admin/places/add_places/body.dart';
import 'package:flutter/material.dart';

class MyplaceBody extends StatefulWidget {
  static const String routename="\placebody";

  @override
  _MyplaceBodyState createState() => _MyplaceBodyState();
}

class _MyplaceBodyState extends State<MyplaceBody> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
              floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        elevation: 9,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return MyPlaceBody();
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
        // backgroundColor: Colors.grey,
        body: Container(
        child: StreamBuilder(
          stream: Firestore.instance.collection("places").snapshots(),
          // initialData: initialData ,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot docsnap=snapshot.data.documents[index];

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                    elevation: 6,
                    child: Column(
                      children: [
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
                                    Firestore.instance
                                        .collection("places")
                                        .document(snapshot.data.documents[index].documentID)
                                        .delete();                                                                        
                                  }),
                                  // edit
                                  IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.grey[800],
                                  ),
                                  onPressed: () {                                    
                                    // Firestore.instance
                                    //     .collection("places")
                                    //     .document(snapshot.data.documents[index].documentID)
                                    //     .delete();                                                                        
                                  }),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(image:NetworkImage(snapshot.data.documents[index]['img'][0]))
                            ),
                          // child: Container(height: 100,color: Colors.red,)//Image.asset("imgs/s1.jpg"),
                        ),),
                        // Image.asset("imgs\s1.jpg"),
                        ExpansionTile(
                          title: Text(snapshot.data.documents[index]['spacename']),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(                              
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              //     Row(
                              //   children: [
                              //     Icon(Icons.home_outlined),
                              //     Padding(
                              //       padding: const EdgeInsets.all(8.0),
                              //       child: Text(snapshot.data.documents[index]['address']),
                              //     ),
                              //   ],                                                                                              
                              // ),
                              ListTile(leading: Icon(Icons.home_outlined),title: Text(snapshot.data.documents[index]['address']),),

                              ListTile(leading: Icon(Icons.info_outline_rounded),title: Text(snapshot.data.documents[index]['overview']),),

                              (docsnap.data.containsKey('day_price'))?ListTile(leading: Icon(Icons.monetization_on),title: Text("Per Day :" + snapshot.data.documents[index]['day_price'].toString()),):Text(""),

                              (docsnap.data.containsKey('hour_price'))?ListTile(leading: Icon(Icons.monetization_on),title: Text("Per Hour :" + snapshot.data.documents[index]['hour_price'].toString()),):Text(""),

                              (docsnap.data.containsKey('rating'))?ListTile(leading: Icon(Icons.star_border),title: Text( snapshot.data.documents[index]['rating'].toString()),):Text(""),

                              (docsnap.data.containsKey('placeofcity'))?ListTile(leading: Icon(Icons.location_city),title: Text( snapshot.data.documents[index]['placeofcity']),):Text(""),

                              (docsnap.data.containsKey('amenities'))?ListTile(leading: Icon(Icons.assignment_ind_outlined),title: Text( snapshot.data.documents[index]['amenities'].toString()),):Text(""),
                              
                              (docsnap.data.containsKey('spaceinfo'))?ListTile(leading: Icon(Icons.assignment_ind_outlined),title: Text( snapshot.data.documents[index]['spaceinfo'].toString()),):Text(""),

                              (docsnap.data.containsKey('type'))?ListTile(leading: Icon(Icons.assignment_ind_outlined),title: Text( snapshot.data.documents[index]['type']),):Text(""),







                              // (docsnap.data.containsKey('day_price'))?
                              // Text("per day : " + snapshot.data.documents[index]['day_price'].toString()):Text(""),

                              // (docsnap.data.containsKey('hour_price'))?
                              // Text("per hour : " + snapshot.data.documents[index]['hour_price'].toString()):Text(""),

                              // Text(snapshot.data.documents[index]['placeofcity']),
                              // Text(snapshot.data.documents[index]['rating'].toString()),
                              // Text(snapshot.data.documents[index]['overview']),  
                              // (docsnap.data.containsKey('amenities'))?Text(snapshot.data.documents[index]['amenities'].toString()):Text(""), 
                                ],
                              ),
                            )
                          ],
                        ),
                        // Image.network(
                        //   "${snapshot.data.documents[index]['icon']}",
                        // ),
                        // Text(
                        //   "${snapshot.data.documents[index]['name']}",
                        //   style: TextStyle(fontWeight: FontWeight.bold),
                        // ),
                        // Container(
                        //   width: double.infinity,
                        //   height: 50,
                        //   child: ListView.builder(
                        //       scrollDirection: Axis.horizontal,
                        //       itemCount: List.from(snapshot
                        //               .data.documents[index]['cat_type'])
                        //           .length,
                        //       itemBuilder: (context, indexcat) {
                        //         return Padding(
                        //           padding: const EdgeInsets.all(3.0),
                        //           child: ChoiceChip(
                        //             label: Text(
                        //                 "${snapshot.data.documents[index]['cat_type'][indexcat].toString()}"),
                        //             selected: true,
                        //             selectedColor: Colors.amber,
                        //             // onSelected: (bool selected) {
                        //             // setState(() {
                        //             //   _choiceIndex = selected ? index : 0;
                        //             // });
                        //             // },
                        //             // backgroundColor: Colors.green,
                        //             labelStyle: TextStyle(
                        //                 color: Colors.black,
                        //                 fontWeight: FontWeight.bold),
                        //           ),
                        //         );
                        //       }),
                        // ),
                       
                        
                      ],
                    ),
                  );
                });
          },
        ),
      ),
      )
    );
  }
}