import 'package:coworkingspace_admin/category/category_edit/edit_screen.dart';
import 'package:flutter/material.dart';

class MyCatEditBody extends StatelessWidget {
  final String catNAME;
  final List<dynamic> chipFilter;
  final String img;
  MyCatEditBody({this.catNAME,this.chipFilter,this.img});
  
  @override
  Widget build(BuildContext context) {
           print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
           print(chipFilter);
           print(img);
           print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>______1st--");
    return AlertDialog(
      content: SingleChildScrollView(
        child: Stack(
          // ignore: deprecated_member_use
          overflow: Overflow.visible,
          children: <Widget>[
            Positioned(
              right: -40.0,
              top: -40.0,
              child: InkResponse(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: CircleAvatar(
                  child: Icon(Icons.close),
                  backgroundColor: Colors.red,
                ),
              ),
            ),

            Container(
              child: Column(
                children: [
                  Text("Edit category Info",style: TextStyle(fontWeight: FontWeight.bold),),
                  MyEditPage(catNAME: catNAME,chipFilter: chipFilter,img: img,),
                ],
              ),
            )

            // Form(
            //   key: _formKey,
            //   child: Column(
            //     mainAxisSize: MainAxisSize.min,
            //     children: <Widget>[
            //       Padding(
            //         padding: EdgeInsets.all(8.0),                  
            //         child: TextFormField(
            //           decoration: InputDecoration(labelText: 'Category Name'),      
            //           onChanged: (value) => null,       
            //         ),
            //       ),
            //       Padding(
            //         padding: EdgeInsets.all(8.0),
            //         child:InputChipExample(),
            //         //  TextFormField(
            //         //   decoration: InputDecoration(labelText: 'Category type'),      
            //         //   onChanged: (value) => null,       
            //         // ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         // ignore: deprecated_member_use
            //         child: RaisedButton(
            //           child: Text("Submitß"),
            //           onPressed: () {
            //             if (_formKey.currentState.validate()) {
            //               _formKey.currentState.save();
            //             }
            //           },
            //         ),
            //       )
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}