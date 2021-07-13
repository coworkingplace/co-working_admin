import 'package:coworkingspace_admin/features.dart';
// import 'package:coworkingspace_admin/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridMain extends StatefulWidget {
  // const GridMain({ Key? key }) : super(key: key);
      // final String title;
      // final String title;
  @override
  _GridMainState createState() => _GridMainState();
}

class _GridMainState extends State<GridMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Admin panel"),        
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
