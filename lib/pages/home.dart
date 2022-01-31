import 'package:apps/pages/bluetooth_device_list_entry.dart';
import 'package:apps/pages/bt_connection.dart';
import 'package:apps/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text('Okno główne'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: <Widget> [
             const SizedBox(height: 50.0),
             Center(child:TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/manual');
              },
              icon: const Icon(Icons.account_tree_rounded,
                size: 30.0,
                color: Colors.white60,
              ),
              label: const Text('Sterowanie',
                style: TextStyle(
                  color:Colors.white60,
                  fontSize: 20.0,
                ),
              ),
            ),),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blueGrey[900])),
            onPressed: (){
              Navigator.pushNamed(context,'/BT_Connection');
            },
            child: const Text("Połącz z Robotem poprzez Bluetooth",
              style: TextStyle(color: Colors.white60),),
          ),
        ],
      ),
    );
  }
}