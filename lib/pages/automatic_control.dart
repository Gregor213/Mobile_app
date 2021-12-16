import 'package:flutter/material.dart';


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
        title: Text('Sterowanie Automatyczne'),
        centerTitle: true,
        elevation: 0,
        ),
      body: Column(
        children: <Widget> [
          Container(
            color: Colors.grey[500],
            padding: const EdgeInsets.all(16.0),
              child: Row(
              children: [
                //TODO odtąd coś jest zjebane
                SizedBox.expand(child:
                      FractionallySizedBox(
                        widthFactor:0.5,
                        heightFactor: 0.5,
                        alignment: FractionalOffset.topCenter,
                        child: DecoratedBox (
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                              width: 4.0,
                            )
                          ),
                        //color: Colors.grey[500],
                        //child: const Center(child:Text('Tekst')),
                        ),
                      )
                  ),
                ],
              ),
            ),
            //Row(),
            //Row(),
          ],
        ),
      );
    }
  }