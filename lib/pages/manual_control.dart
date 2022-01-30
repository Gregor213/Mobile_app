import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class manual_Control extends StatefulWidget {
  @override
  _manual_ControlState createState() => _manual_ControlState();
}

class _manual_ControlState extends State<manual_Control> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: const Text('Sterowanie Ręczne'),
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
                        ElevatedButton(onPressed: ()=>null,
                          child: Text("L"),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(700)
                              )
                            )
                          )
                        ),
                        Expanded(
                            flex: 4,
                            child:Container(
                              alignment: Alignment.center,
                                child:DropdownItem()
                            ),
                        ),
                        ElevatedButton(onPressed: ()=>null,
                            child: Text("R"),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
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
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.black87,
                  child: ToggleControl(),
                    )
              )
            ]
        ),
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

class ToggleControl extends StatefulWidget {
  const ToggleControl({Key? key}) : super(key: key);

  @override
  _ToggleControlState createState() => _ToggleControlState();
}

class _ToggleControlState extends State<ToggleControl>{
  bool toggle = false;
  @override
  Widget build(BuildContext context){
    return SwitchListTile(
        inactiveTrackColor: Colors.blueGrey,
        title: const Center(child: Text("Tryb Manualny",
          style: TextStyle(color: Colors.white60 ))),
        value: toggle,
        onChanged: (bool value){
          setState(() {
            toggle=value;
            if (toggle == true){
              Navigator.popAndPushNamed(context, '/automatic');
            }
          });
        }
    );
  }
}


class DropdownItem extends StatefulWidget {
  const DropdownItem({Key? key}) : super(key: key);

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
