import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //String deviceName =

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Okno główne'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: <Widget> [
          Container(
            color: Colors.grey[500],
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children:  const [
                Text('Nazwa urządzenia:',
                style: TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                ),
                ),
                SizedBox(width: 5.0),
                Text('123',
                  style: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[500],
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: const [
                Text('Stan Połączenia BT:',
                  style: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5.0),
                Text('ON/OFF',
                  style: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            child: TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/automatic');
              },
              icon: const Icon(Icons.account_tree_rounded,
                size: 30.0,
                color: Colors.black,
              ),
              label: const Text('Sterowanie',
                style: TextStyle(
                  color:Colors.black,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
