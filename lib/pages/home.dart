import 'package:apps/pages/bt_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

FlutterBlue flutterBlue =FlutterBlue.instance;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //String deviceName =

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
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: const [
                 Text('Nazwa urządzenia:',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                ),
                ),
                SizedBox(width: 5.0),
                DeviceNameText(),
              ],
            ),
          ),
          Container(
            color: Colors.black87,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: const [
                Text('Stan Połączenia BT:',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5.0),
                //TODO implement stateful widget ON/OFF

                //</TODO>
              ],
            ),
          ),
          const SizedBox(height: 10.0),
             TextButton.icon(
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
            ),
          ElevatedButton(
            style: ButtonStyle(
              //side: MaterialStateProperty.all(BorderSide.),
                backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),
            onPressed: (){
              Navigator.pushNamed(context,'/BT_Connection');
            },//BT_Connection_Screen(),
            child: Text("Połącz z Robotem poprzez Bluetooth",style: TextStyle(color: Colors.black87),),
          ),
        ],
      ),
    );
  }
}
class DeviceNameText extends StatefulWidget {
  const DeviceNameText({Key? key}) : super(key: key);
  @override
  _DeviceNameTextState createState() => _DeviceNameTextState();
}
class _DeviceNameTextState extends State<DeviceNameText> {
  String deviceName = "Urządzenie 123";
  @override
  Widget build(BuildContext context) {
    return Text(deviceName,
        style:const TextStyle(
          color: Colors.white60,
          fontSize: 23.0,
          fontWeight: FontWeight.bold,
        ),
      );
  }
}

class Bluetooth extends StatefulWidget {
  const Bluetooth({Key? key}) : super(key: key);
  @override
  _BluetoothState createState() => _BluetoothState();
}

class _BluetoothState extends State<Bluetooth> {
  @override
  Widget build(BuildContext context) {
    return Text("siema");
}
}