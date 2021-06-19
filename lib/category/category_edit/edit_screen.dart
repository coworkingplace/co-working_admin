import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coworkingspace_admin/category/category_edit/cat_chip_edit.dart';
import 'package:coworkingspace_admin/category/category_edit/img_picker_edit_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;

// ignore: must_be_immutable
class MyEditPage extends StatefulWidget {
  static String routename = "/categorypage";
  final String catNAME;
  List<dynamic> chipFilter;
  final String img;  

  MyEditPage({this.catNAME,this.chipFilter,this.img });

  @override
  _MyEditPageState createState() => _MyEditPageState();
}

class _MyEditPageState extends State<MyEditPage> {
  File currentImage;
  // ignore: deprecated_member_use
  List<int> editedchipsFliter = new List();
  String editedcatName;
  File editedimg;
  
  var uploadedFileURL;

  @override
  Widget build(BuildContext context) {
                                                  print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                                          print(widget.chipFilter);
                                          print(widget.img);
                                          print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>_________________________-2nd");
    return
        // Scaffold(
        //   appBar: AppBar(title: Text("category"),),
        // body:
        Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: TextField(            
            controller: TextEditingController(text: "${widget.catNAME}"),
            decoration: InputDecoration(labelText: 'Category Name',),
            onChanged: (value) {
              setState(() {
                editedcatName = value;
              });
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        InputChipExample(    
          values: widget.chipFilter,      
          onCatTypeAdd: (value) {
            setState(() {
              editedchipsFliter = value;
            });
          },
        ),
        Text("Image"),

        ImagePickerForCategory(
          iconimgdata: widget.img,
          onimageselects: (value) {
            setState(() {
              print(value);
              editedimg = value;
            });
          },
        ),

        // ignore: deprecated_member_use
        RaisedButton(
          onPressed: () async {
            // print("??????????????????>>>>>><<<<<<!@###########");
            print(editedcatName);
            print(widget.chipFilter);
            print(currentImage);

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
                uploadedFileURL = fileURL;//.toString();
                // print(uploadedFileURL);
              });
            });

            print(uploadedFileURL);
            print("??????????????????>>>>>><<<<<<!@###########");
            if (uploadedFileURL != null) {
              Firestore.instance.collection("category").add({
                'name': editedcatName,
                // 'cat_type': chipsFliter,
                'icon': uploadedFileURL
              }).then((value) {
                Navigator.of(context).pop();
              });
            }
          },
          child: Text("ADD CATEGORY"),
        )
        // Padding(
        //         padding: const EdgeInsets.all(15),
        //         child: TextField(
        //           decoration: InputDecoration(labelText: 'Category type'),
        //           onChanged: (value) => null,
        //         ),
        // ),
      ],
    );
    // );
  }
}
