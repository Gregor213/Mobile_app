import 'package:flutter/material.dart';

class manual_Control extends StatefulWidget {
  @override
  _manual_ControlState createState() => _manual_ControlState();
}

class _manual_ControlState extends State<manual_Control> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Sterowanie Ręczne'),
        centerTitle: true,
      ),
    );
  }
}
