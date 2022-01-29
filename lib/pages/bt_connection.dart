import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter/services.dart';

import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black87,
    appBar: AppBar(
      backgroundColor: Colors.blueGrey[900],
      title: const Text('FlutterBT'),
      centerTitle: true,
      elevation: 1,
    ),
    body: MyHomePage(),
  );
}
 //late String deviceName;
 //  class Helper {
 //    String writing(){
 //    device.name
 //  }
//}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  // final String title;
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> devicesList =  <BluetoothDevice>[];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

 class _MyHomePageState extends State<MyHomePage> {

  BluetoothDevice? connectedDevice;
  late List<BluetoothService> services;

  _addDeviceTolist(final BluetoothDevice device) {
    if (!widget.devicesList.contains(device)) {
      setState(() {
        widget.devicesList.add(device);
      });
    }
  }

   @override
  void initState() {
    super.initState();
    widget.flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        _addDeviceTolist(device);
      }
    });
    widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceTolist(result.device);
      }
    });
    widget.flutterBlue.startScan(timeout: const Duration(seconds: 4));
  }
  ListView _buildListViewOfDevices() {
    List<Container> containers = <Container>[];
    for (BluetoothDevice device in widget.devicesList) {
      containers.add(
        Container(
          height: 50,
          color: Colors.blueGrey[700],
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(device.name == '' ? '(unknown device)' : device.name,
                      style: const TextStyle(color: Colors.white60) ,),
                    Text(device.id.toString(),
                      style: const TextStyle(color: Colors.white60),),
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blueGrey[900]),
                ),
                  child: const Text(
                  'Połącz',
                  style: TextStyle(color: Colors.white60),
                ),
                  onPressed: () async{
                      widget.flutterBlue.stopScan();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            duration: const Duration(seconds: 3),
                            content: Text('Łączenie z '
                                '${device.name == '' ? '(unknown device)' : device.name}')));
                      try {
                        await device.connect();
                      } catch (e){
                        if (e.hashCode.toString() != 'already_connected') {
                          rethrow;
                        }
                      } finally {
                        services = await device.discoverServices();
                      }
                      setState(() {
                        connectedDevice = device;
                     });
                  }
              ),
            ],
          ),
        ),
      );
      containers.add(Container(child: const SizedBox(height: 5.0)));
    }
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }
  ListView _buildConnectDeviceView() {
    List<Container> containers = <Container>[];
    for (BluetoothService service in services) {
      containers.add(
        Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(service.uuid.toString(),
                    style: const TextStyle(color: Colors.white60),),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  ListView _buildView() {
    if (connectedDevice != null) {
      return _buildConnectDeviceView();
    }
    return _buildListViewOfDevices();
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    //key: UniqueKey(),
    backgroundColor: Colors.black87,
      body:_buildView());//Scaffold(
    //appBar: AppBar(
     // title: const Text("TEXT"),
    //),
    //body: _buildView(),

  //);

}

