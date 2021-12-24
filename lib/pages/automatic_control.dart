import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Automatic_Control extends StatefulWidget {
  @override
  _Automatic_ControlState createState() => _Automatic_ControlState();
}

class _Automatic_ControlState extends State<Automatic_Control> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Sterowanie Automatyczne'),
        centerTitle: true,
        elevation: 0,
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
                  color: Colors.grey[500],
                  child: Container(child: Text("Statystyki"),
                            margin: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                              width:4,
                                ),
                              )
                          )
                        ),
                      ),
              Expanded(
                flex: 3,
                child: Container(
                  color:Colors.grey[500],
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(40.0,10,40.0,10),
                    //child: DecoratedBox(decoration: BoxDecoration(border: Border.all(color:Colors.cyan,width: 3,) ),)
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ElevatedButton(onPressed: ()=>null,
                          child: Text("L"),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(700)
                              )
                            )
                          )
                        ),
                        DropdownItem(
                          
                        ),
                        ElevatedButton(onPressed: ()=>null,
                            child: Text("R"),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(700)
                                    )
                                )
                            )
                        ),
                  ]
                        )
                    )
                  ),
                  ),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.grey[500],
                  child: const Text("Text 3"),
                      )
                  )
            ]),
        );
    }
  }
List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Przegub 1"), value: "Przegub1",),
    DropdownMenuItem(child: Text("Przegub 2"), value: "Przegub2"),
    DropdownMenuItem(child: Text("Przegub 3"), value: "Przegub3"),
  ];
  return menuItems;
}
class DropdownItem extends StatefulWidget {
  @override
  _DropdownItemState createState() => _DropdownItemState();
}
class _DropdownItemState extends State<DropdownItem>{
  String selectedValue = "Przegub1";
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: selectedValue,
        icon: const Icon(Icons.amp_stories),
        iconSize: 50,
        onChanged: (String? newValue){
          setState(() {
            selectedValue=newValue!;
          });
        },
        items: dropdownItems
    );
  }
}