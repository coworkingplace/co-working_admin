import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputChipExample extends StatefulWidget {
  List<dynamic> values;
  final Function(List<int>) onCatTypeAdd;
  InputChipExample({this.onCatTypeAdd,this.values});

  @override
  InputChipExampleState createState() => new InputChipExampleState();
}

class InputChipExampleState extends State<InputChipExample> {
  
  TextEditingController _textEditingController = new TextEditingController();
  final number = TextEditingController();
  // ignore: deprecated_member_use
  List<dynamic> editedvalues = new List();
  // ignore: deprecated_member_use
  List<bool> _selected = new List();


@override
void initState() { 
  super.initState();
  editedvalues=widget.values;
}


  @override
  void dispose() {
    _textEditingController?.dispose();
    super.dispose();
  }
// ignore: deprecated_member_use
// List<Widget> chips = new List();
  Widget buildChips() {
    // ignore: deprecated_member_use
    List<Widget> chips = new List();

    // for (int i = 0; i < widget.values.length; i++) {
    //   InputChip actionChip = InputChip(
    //     // selected: _selected[i],
    //     label: Text(widget.values[i].toString()),
    //     // avatar: FlutterLogo(),
    //     elevation: 10,
    //     pressElevation: 5,
    //     shadowColor: Colors.teal,
    //     onPressed: () {
    //       setState(() {
    //         _selected[i] = !_selected[i];
    //       });
    //     },
    //     onDeleted: () {
    //       widget.values.removeAt(i);
    //       _selected.removeAt(i);

    //       setState(() {
    //         widget.values = widget.values;
    //         _selected = _selected;
    //       });
    //     },
    //   );

    //   chips.add(actionChip);
    // }

    // edited values
    // int n=widget.values.length;
        for (int i = 0; i < editedvalues.length; i++) {
      InputChip actionChip = InputChip(
        // selected: _selected[i],
        label: Text(editedvalues[i].toString()),
        // avatar: FlutterLogo(),
        elevation: 10,
        pressElevation: 5,
        shadowColor: Colors.teal,
        onPressed: () {
          setState(() {
            _selected[i] = !_selected[i];
          });
        },
        onDeleted: () {
          editedvalues.removeAt(i);
          _selected.removeAt(i);

          setState(() {
            editedvalues = editedvalues;
            _selected = _selected;
          });
        },
      );

      chips.add(actionChip);
    }
    return 
    ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, catindex) => Padding(
        padding: EdgeInsets.all(8.0),
        child: chips[catindex],
      ),
      separatorBuilder: (context, catindex) => SizedBox(
        width: 5,
      ),
      itemCount: chips.length,
    );
    // return ListView(
    //   // This next line does the trick.
    //   scrollDirection: Axis.horizontal,
    //   children: chips,
    // );
  }

  @override
  Widget build(BuildContext context) {
                       print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                       print(editedvalues);
                        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[            
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(labelText: 'Category type'),
              keyboardType: TextInputType.number,                         
            ),
            Container(
              height: 60,
              child: buildChips(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              // ignore: deprecated_member_use
              child: RaisedButton(
                onPressed: () {
                  editedvalues.add(int.parse(_textEditingController.text));
                  _selected.add(true);
                  _textEditingController.clear();
                  if(editedvalues.isNotEmpty)
                      widget.onCatTypeAdd(editedvalues);                  
                  else
                      widget.onCatTypeAdd(null); 
                  setState(() {
                    editedvalues = editedvalues;
                    _selected = _selected;
                  });
                },
                child: Text('add'),
              ),
            ),
          ],
        ));
  }
}
