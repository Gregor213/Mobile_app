import 'dart:async';

import 'package:apps/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:apps/pages/BackgroundCollectingTask.dart';
import 'package:apps/pages/discovery_page.dart';
import 'package:apps/pages/bluetooth_device_list_entry.dart';
import 'package:apps/pages/select_bonded_device_page.dart';
import 'package:apps/pages/chat_page.dart';

import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          title: const Text('Okno ustawień Bluetooth'),
          centerTitle: true,
          elevation: 1,
        ),
        body: const MyHomePage(),
      );
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  static String? deviceName;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  String _address = "...";
  String _name = "...";

  Timer? _discoverableTimeoutTimer;
  int _discoverableTimeoutSecondsLeft = 0;

  BackgroundCollectingTask? _collectingTask;

  bool _autoAcceptPairingRequests = false;

  @override
  void initState() {
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      // Wait if adapter not enabled
      if ((await FlutterBluetoothSerial.instance.isEnabled) ?? false) {
        return false;
      }
      await Future.delayed(const Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      // Update the address field
      FlutterBluetoothSerial.instance.address.then((address) {
        setState(() {
          _address = address!;
        });
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() {
        _name = name!;
      });
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;

        // Discoverable mode is disabled when Bluetooth gets disabled
        _discoverableTimeoutTimer = null;
        _discoverableTimeoutSecondsLeft = 0;
      });
    });
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    _collectingTask?.dispose();
    _discoverableTimeoutTimer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) =>
      Scaffold(
        //key: UniqueKey(),
          backgroundColor: Colors.black87,
          body: Container(
              child: ListView(
                  children: <Widget>[
                    const ListTile(title: Text('Główne',
                      style: TextStyle(
                          color:Colors.white60))),
                    const Divider(color: Colors.blueGrey),
                    SwitchListTile(
                      activeColor: Colors.white60,
                      activeTrackColor: Colors.blueGrey[900],
                      inactiveTrackColor: Colors.blueGrey[900],
                      title: const Text('Uruchomienie usługi Bluetooth',
                      style: TextStyle(color: Colors.white60),),
                      value: _bluetoothState.isEnabled,
                      onChanged: (bool value) {
                        // Do the request and update with the true value then
                        future() async {
                          // async lambda seems to not working
                          if (value) {
                            await FlutterBluetoothSerial.instance
                                .requestEnable();
                          } else {
                            await FlutterBluetoothSerial.instance
                                .requestDisable();
                          }
                        }

                        future().then((_) {
                          setState(() {});
                        });
                      },
                    ),
                    ListTile(
                      title: const Text('Status połączenia: ',style: TextStyle(
                        color: Colors.white60
                      ),),
                      subtitle: Text(_bluetoothState.toString(),
                        style: const TextStyle(color: Colors.white60),),
                      trailing: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                              MaterialStateProperty.all(Colors.blueGrey[900])),
                        child: const Text('Ustawienia',style: TextStyle(
                          color: Colors.white60
                        ),),
                        onPressed: () {
                          FlutterBluetoothSerial.instance.openSettings();
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Adres urządzenia',
                        style: TextStyle(color: Colors.white60) ,),
                      subtitle: Text(_address,
                        style: const TextStyle(color:Colors.white60 ),),
                    ),
                    ListTile(
                      title: const Text('Nazwa urządzenia',
                        style: TextStyle(color: Colors.white60) ,),
                      subtitle: Text(_name,
                        style: const TextStyle(color: Colors.white60),),
                      onLongPress: null,
                    ),
                    ListTile(
                      title: _discoverableTimeoutSecondsLeft <= 0
                          ? const Text("Niewidoczny",
                              style: TextStyle(color:Colors.white60))
                          : Text(
                          "Widoczny przez ${_discoverableTimeoutSecondsLeft}s",
                            style: const TextStyle(color: Colors.white60),),
                      subtitle: const Text("MI-8",
                        style: TextStyle(color: Colors.white60),),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            activeColor: Colors.white60,
                            value: _discoverableTimeoutSecondsLeft != 0,
                            onChanged: null,
                          ),
                          // const IconButton(
                          //   color: Colors.white60,
                          //   icon: Icon(Icons.edit),
                          //   onPressed: null,
                          // ),
                          IconButton(
                            color: Colors.white60,
                            icon: const Icon(Icons.refresh),
                            onPressed: () async {
                              print('Discoverable requested');
                              final int timeout = (await FlutterBluetoothSerial.instance
                                  .requestDiscoverable(60))!;
                              if (timeout < 0) {
                                print('Discoverable mode denied');
                              } else {
                                print(
                                    'Discoverable mode acquired for $timeout seconds');
                              }
                              setState(() {
                                _discoverableTimeoutTimer?.cancel();
                                _discoverableTimeoutSecondsLeft = timeout;
                                _discoverableTimeoutTimer =
                                    Timer.periodic(Duration(seconds: 1), (Timer timer) {
                                      setState(() {
                                        if (_discoverableTimeoutSecondsLeft < 0) {
                                          FlutterBluetoothSerial.instance.isDiscoverable
                                              .then((isDiscoverable) {
                                            if (isDiscoverable ?? false) {
                                              print(
                                                  "Discoverable after timeout... might be infinity timeout :F");
                                              _discoverableTimeoutSecondsLeft = 0;
                                            }
                                          });
                                          timer.cancel();
                                          _discoverableTimeoutSecondsLeft = 0;
                                        } else {
                                          _discoverableTimeoutSecondsLeft -= 1;
                                        }
                                      });
                                    });
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    const Divider(color: Colors.blueGrey),
                    const ListTile(
                        title: Text('Nawiązywanie połączeń',
                        style: TextStyle(color: Colors.white60),)),
                    ListTile(
                      title: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                MaterialStateProperty.all(Colors.blueGrey[900]) ),
                          child: const Text('Pokaż urządzenia w pobliżu',
                          style: TextStyle(color: Colors.white60),),
                          onPressed: () async {
                            final BluetoothDevice? selectedDevice =
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return const DiscoveryPage();
                                },
                              ),
                            );

                            if (selectedDevice != null) {
                              print('Discovery -> selected ' +
                                  selectedDevice.address);
                            } else {
                              print('Discovery -> no device selected');
                            }
                          }),
                    ),
                    ListTile(
                      title: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                              MaterialStateProperty.all(Colors.blueGrey[900])),
                        child: const Text('Połącz z sparowanym urządzeniem',
                        style: TextStyle(color: Colors.white60),
                        ),
                        onPressed: () async {
                          final BluetoothDevice? selectedDevice =
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return const SelectBondedDevicePage(checkAvailability: false);
                              },
                            ),
                          );

                          if (selectedDevice != null) {
                            print('Connect -> selected ' + selectedDevice.address);
                            //_startChat(context, selectedDevice);

                          } else {
                            print('Connect -> no device selected');
                          }
                        },
                      ),
                    ),
                    const Divider(color: Colors.blueGrey),
                  ]
              )
          )
      );
  }
    void _startChat(BuildContext context, BluetoothDevice server) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ChatPage(server: server);
        },
      ),
    );
  }
