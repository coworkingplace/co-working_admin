import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coworkingspace_admin/places/add_places/filter_chip/body.dart';
import 'package:coworkingspace_admin/places/add_places/img_picker/body.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyAddPlacesPage extends StatefulWidget {
  static String routename = "/placespage";

  @override
  _MyAddPlacesPageState createState() => _MyAddPlacesPageState();
}

class _MyAddPlacesPageState extends State<MyAddPlacesPage> {
  final _formKey = GlobalKey<FormState>();
  String palcename;
  String address;
  String overview;
  int dayprice;
  int hourprice;
  String cityname;
  // ignore: deprecated_member_use
  List<String> amenities = new List();
  // ignore: deprecated_member_use
  List<String> spaceinfo = new List();
  // String _myActivity;
  // ignore: non_constant_identifier_names
  // List<Dropcategory> MyCategory = [];
  // List<String> currentImage;  
  File currentImage;
  // List<DocumentSnapshot> _queryCat;
  Color primaryColor;
  // Firestore firestore;
  var _mySelectionCategory;

  // ignore: deprecated_member_use
  List<dynamic> uploadedFileURL= new List();
  // List<String> currentImage;

  @override
  void initState() {
    super.initState();
    // MyCategory.add(Dropcategory(display: "1st", value: "1st"));
    // MyCategory.add(Dropcategory(display: "2nd", value: "2nd"));
    // MyCategory.add(Dropcategory(display: "3rd", value: "3rd"));
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'place Name'),
              onChanged: (value) {palcename=value;},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'address'),
              onChanged: (value) => address=value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                if (value.length >= 30) {
                  return 'address should be in <100 words +${value.length}';
                }
                return null;
              },
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('category').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return const Text('Loading...');
              return new DropdownButton<String>(
                isDense: true,
                hint: new Text("Select category"),
                value: _mySelectionCategory,
                onChanged: (String newValue) {
                  print(_mySelectionCategory);
                  setState(() {
                    _mySelectionCategory = newValue;
                  });
                },
                items: snapshot.data.documents.map((DocumentSnapshot map) {
                  return new DropdownMenuItem<String>(
                    value: map.documentID.toString(),
                    child: new Text(
                      map.data["name"],
                    ),
                  );
                }).toList(),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'overview'),
              onChanged: (value) => overview=value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }

                if (value.length >= 50) {
                  return 'address should be in <100 words +${value.length}';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'per day price'),
              keyboardType: TextInputType.number,
              onChanged: (value) => dayprice=int.parse(value),
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter some text';
              //   }
              //   return null;
              // },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'per hour price'),
              keyboardType: TextInputType.number,
              onChanged: (value) => hourprice=int.parse(value),
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter some text';
              //   }
              //   return null;
              // },
            ),
          ),
          InputChipExample(
            title: "amenities",
          onCatTypeAdd: (value) {
            setState(() {
              amenities = value;
            });
          },
        ),

          InputChipExample(
            title: "space info",
          onCatTypeAdd: (value) {
            setState(() {
              spaceinfo = value;
            });
          },
        ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'city'),
              // keyboardType: TextInputType.number,
              onChanged: (value) => cityname=value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter city name';
                }
                return null;
              },
            ),
          ),
          ImagePickerForCategory(
            onimageselects: (value) {
              setState(() {
                print(value);
                // currentImage.add(value);
                currentImage=value;
              });
            },
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'place type'),
              // keyboardType: TextInputType.number,
              onChanged: (value) => null,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter some text';
              //   }
              //   return null;
              // },
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(8.0),
            // ignore: deprecated_member_use
            child: RaisedButton(
              child: Text("Submitß"),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                              StorageReference storageReference = FirebaseStorage.instance
                .ref()
                .child('${Path.basename(currentImage.path)}');
            StorageUploadTask uploadTask =
                storageReference.putFile(currentImage);
            await uploadTask.onComplete;
            print('File Uploaded');
            print("??????????????????>>>>>><<<<<<!@###########");
            storageReference.getDownloadURL().then((fileURL) {
              setState(() {
                // print(fileURL);
                uploadedFileURL.add(fileURL);// fileURL;//.toString();
                print("????????????!!!!!!!!!!!!!<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>");
                print(uploadedFileURL);
                print("????????????!!!!!!!!!!!!!<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>");
              });
            });
            if (uploadedFileURL!=null) {
  Firestore.instance.collection('places').add({
    'spacename':palcename,
    'address':address,
    'category_id':_mySelectionCategory,
    'overview':overview,
    'placeofcity':cityname,
    'img':FieldValue.arrayUnion(uploadedFileURL)
  }).then((value) {
    print("${value.documentID}");
  
                  if(dayprice!=null){
                    Firestore.instance.collection('places').document(value.documentID).updateData({'day_price':dayprice});
                  }
                  if(hourprice!=null){
                    Firestore.instance.collection('places').document(value.documentID).updateData({'hour_price':hourprice});
                  }
                  if(amenities!=null){
                    Firestore.instance.collection('places').document(value.documentID).updateData({'amenities':amenities});
                  }
                  if(spaceinfo!=null){
                    Firestore.instance.collection('places').document(value.documentID).updateData({'spaceinfo':FieldValue.arrayUnion(spaceinfo)});
                  }             
                  Navigator.of(context).pop();     
  });
            }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class Dropcategory {
  String display;
  String value;

  Dropcategory({@required this.display, @required this.value});
}
