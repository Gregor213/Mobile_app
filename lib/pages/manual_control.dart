import 'package:flutter/material.dart';

class Manual_Control extends StatefulWidget {
  @override
  _Manual_ControlState createState() => _Manual_ControlState();
}

class _Manual_ControlState extends State<Manual_Control> {
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
