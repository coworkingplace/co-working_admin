import 'package:flutter/material.dart';

class InputChipExample extends StatefulWidget {
  final String title;
  final Function(List<String>) onCatTypeAdd;
  InputChipExample({this.onCatTypeAdd,@required this.title});

  @override
  InputChipExampleState createState() => new InputChipExampleState();
}

class InputChipExampleState extends State<InputChipExample> {
  TextEditingController _textEditingController = new TextEditingController();
  final number = TextEditingController();
  // ignore: deprecated_member_use
  List<String> _values = new List();
  // ignore: deprecated_member_use
  List<bool> _selected = new List();

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

    for (int i = 0; i < _values.length; i++) {
      InputChip actionChip = InputChip(
        selected: _selected[i],
        label: Text(_values[i].toString()),
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
          _values.removeAt(i);
          _selected.removeAt(i);

          setState(() {
            _values = _values;
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
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[            
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(labelText: '${widget.title}'),
              // keyboardType: TextInputType.number,                         
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
                  _values.add(_textEditingController.text);
                  _selected.add(true);
                  _textEditingController.clear();
                  widget.onCatTypeAdd(_values);                  
                  setState(() {
                    _values = _values;
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
