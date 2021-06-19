import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coworkingspace_admin/category/category_add/cat_type_chip.dart';
import 'package:coworkingspace_admin/category/category_add/image_picker_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;

class MycatPage extends StatefulWidget {
  static String routename = "/categorypage";

  @override
  _MycatPageState createState() => _MycatPageState();
}

class _MycatPageState extends State<MycatPage> {
  File currentImage;
  // ignore: deprecated_member_use
  List<int> chipsFliter = new List();
  String catName;
  var uploadedFileURL;

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   appBar: AppBar(title: Text("category"),),
        // body:
        Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: TextField(
            decoration: InputDecoration(labelText: 'Category Name'),
            onChanged: (value) {
              setState(() {
                catName = value;
              });
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        InputChipExample(
          onCatTypeAdd: (value) {
            setState(() {
              chipsFliter = value;
            });
          },
        ),
        Text("Image"),

        ImagePickerForCategory(
          onimageselects: (value) {
            setState(() {
              print(value);
              currentImage = value;
            });
          },
        ),

        // ignore: deprecated_member_use
        RaisedButton(
          onPressed: () async {
            // print("??????????????????>>>>>><<<<<<!@###########");
            print(catName);
            print(chipsFliter);
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
                'name': catName,
                'cat_type': chipsFliter,
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
