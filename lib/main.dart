import 'package:coworkingspace_admin/route.dart';
import 'package:flutter/material.dart';
// import 'category/category_display/body.dart';
// import 'category/category_screen.dart';
import 'features.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',      
      // theme: ThemeData(
        // primarySwatch: Colors.blue,        
      // ),    
      home:   MyHomePage(title: 'Co-working Admin'),//ImagePickerWidget(),
      routes: routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter GridView Demo"),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){},
      // child: Icon(Icons.add,color: Colors.blueGrey,),
      // ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 9.0,
            mainAxisSpacing: 8.0,
            children: List.generate(choices.length, (index) {
              return Center(
                child: SelectCard(choice: choices[index]),
              );
            })),
      ),
    );
  }
}
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Flutter GridView Demo"),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: (){},
//       child: Icon(Icons.add,color: Colors.blueGrey,),
//       ),
//       body: SelectCard(),
//     );
//   }
// }





class SelectCard extends StatelessWidget {
  const SelectCard({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    // final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return GestureDetector(
      onTap: () {
        // Navigator.push(context,MaterialPageRoute(builder: (context) => MycatPage()),);        
        Navigator.of(context).pushNamed(choice.routename);
      },
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 9,
          // margin: EdgeInsets.all(20),
          color: Colors.blueGrey[800],
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: Icon(choice.icon,
                            size: 50.0,
                            color: Colors.white /*textStyle.color*/)),
                    Text(choice.title,
                        style: TextStyle(color: Colors.white) /*textStyle*/),
                    // InputChipExample(),
                  ]),
            ),
          )),
    );
  }
}


//  final picker = ImagePicker();

//   File _imageFile;

//   Future uploadImageToFirebase(BuildContext context) async {
//     String fileName = basename(_imageFile.path);
//     StorageReference firebaseStorageRef =
//         FirebaseStorage.instance.ref().child('uploads/$fileName');
//     StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
//     StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
//     taskSnapshot.ref.getDownloadURL().then(
//           (value) => print("Done: $value"),
//         );
//   }

