import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen ({Key? key}) : super(key: key);
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>{

  void setupScreen() async {
    Future.delayed(const Duration(milliseconds: 500),(){
    Navigator.pushReplacementNamed(context, '/home');
    });
  }
  @override
  void initState() {
    super.initState();
  }
   //setupScreen();


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: SpinKitRotatingPlain(
          color: Colors.white60,
          size: 80,
        ),
      ),
    );
  }
}
