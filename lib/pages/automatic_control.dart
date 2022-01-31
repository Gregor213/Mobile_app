import 'package:flutter/material.dart';

class Automatic_Control extends StatefulWidget {
  @override
  _Automatic_ControlState createState() => _Automatic_ControlState();
}

class _Automatic_ControlState extends State<Automatic_Control> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: const Text('Sterowanie Automatyczne'),
        centerTitle: true,
        elevation: 1,
      ),
      body:
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget> [
            Expanded(
              flex:5,
              child: Container(
                  height: 200.0,
                  child: Container(child: const Text("Statystyki",
                      style: TextStyle(
                          color: Colors.white60)),
                      margin: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                          width:4,
                        ),
                      )
                  )
              ),
            ),
            Expanded(
                flex: 3,
                child: Container(
                    margin: const EdgeInsets.fromLTRB(40.0,10,40.0,10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            flex: 6,
                            child:Container(
                                alignment: Alignment.center,
                                child:DropdownItem()
                            ),
                          ),
                          //TODO implement OK button function
                          Expanded(
                              flex:4,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.blueGrey)
                                ),
                                onPressed: ()=> null,
                                child: Text("OK",
                                style: TextStyle(
                                    color: Colors.blueGrey[900]),
                                ),
                              )
                              )
                        ]
                    )
                )
            ),
            Expanded(
                flex: 2,
                child: Container(
                  color: Colors.black87,
                  child: toggleControl(),
                )
            )
          ]
      ),
    );
  }
}
List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Trasa 1"), value: "Trasa1",),
    DropdownMenuItem(child: Text("Trasa 2"), value: "Trasa2"),
    DropdownMenuItem(child: Text("Trasa 3"), value: "Trasa3"),
  ];
  return menuItems;
}

class toggleControl extends StatefulWidget {
  @override
  _toggleControlState createState() => _toggleControlState();
}

class _toggleControlState extends State<toggleControl>{
  bool toggle = true;
  @override
  Widget build(BuildContext context){
    return SwitchListTile(
        activeTrackColor: Colors.blueGrey,
        activeColor: Colors.white60,
        title: Center(child: const Text("Tryb Automatyczny",
        style:TextStyle(color: Colors.white60 ))),
        value: toggle,

        onChanged: (bool value){
          setState(() {
            toggle=value;
            if (toggle == false){
              Navigator.popAndPushNamed(context,'/manual');
            }
          });
        }
    );
  }
}

class DropdownItem extends StatefulWidget {
  @override
  _DropdownItemState createState() => _DropdownItemState();
}
class _DropdownItemState extends State<DropdownItem>{
  String selectedValue = "Trasa1";
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: selectedValue,
        icon: const Icon(Icons.amp_stories),
        iconSize: 40,
        style: TextStyle(color: Colors.grey),
        dropdownColor: Colors.black87,
        onChanged: (String? newValue){
          setState(() {
            selectedValue=newValue!;
          });
        },
        items: dropdownItems
    );
  }
}