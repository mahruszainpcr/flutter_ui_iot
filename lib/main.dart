import 'dart:async';
import 'package:flutter/material.dart';
import 'package:masjid/ThermometerWidget.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import 'package:mqtt_client/mqtt_client.dart';
import 'package:universal_mqtt_client/universal_mqtt_client.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'IoT Lab 320 PCR'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _temp = 0;
  void koneksi() async {
    // Create a new UniversalMqttClient. This does not start the connection yet.
    final client =
        UniversalMqttClient(broker: Uri.parse('tcp://103.19.208.238:9001'));
    client.status.listen((status) {
      print('Connection Status: $status');
    });

    // We now call `client.connect()` to establish a connection with the MQTT broker.
    // The returned promise resolves when the connection is successful, a timeout
    // has been reached, or the broker responds with an error.
    await client.connect();

    // We now subscribe to the client and save the returned StreamSubscription

    client
        .handleString('building/s_lampu', MqttQos.atLeastOnce)
        .listen((message) => setState(() {
              _temp = double.parse(message);
            }));
    client
        .handleString('building/suhu', MqttQos.atLeastOnce)
        .listen((message) => setState(() {
              _temp = double.parse(message);
            }));
    client
        .handleString('building/humidity', MqttQos.atLeastOnce)
        .listen((message) => setState(() {
              _temp = double.parse(message);
            }));
    client
        .handleString('building/light', MqttQos.atLeastOnce)
        .listen((message) => setState(() {
              _temp = double.parse(message);
            }));

    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    koneksi();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(16),
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.orangeAccent[200]),
              child: Text(
                "Ruangan 320",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Container(
                        child: Column(
                          children: [
                            Text("Suhu"),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "36 C",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        child: Column(
                          children: [
                            Text("Cahaya"),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "80",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        child: Column(
                          children: [
                            Text("Humidity"),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "89",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            statusLampu(_temp.toString()),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 16,
            ),
            OutlineButton(
              onPressed: () => {_pubKirim()},
              child: statusButton(_temp.toString()),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Text statusButton(String status) {
    if (status == "1.0") {
      return Text("Matikan lampu");
    } else {
      return Text("Nyalakan lampu");
    }
  }

  Container statusLampu(String status) {
    // print(status);
    if (status == "1.0") {
      return Container(
        child: Icon(
          Icons.lightbulb_outline,
          size: 100,
          color: Colors.orange,
        ),
      );
    } else {
      return Container(
        child: Icon(
          Icons.lightbulb_outline,
          size: 100,
          color: Colors.black,
        ),
      );
    }
  }

  void _pubKirim() async {
    // Create a new UniversalMqttClient. This does not start the connection yet.
    final client =
        UniversalMqttClient(broker: Uri.parse('tcp://103.19.208.238:9001'));
    client.status.listen((status) {
      print('Connection Status: $status');
    });

    // We now call `client.connect()` to establish a connection with the MQTT broker.
    // The returned promise resolves when the connection is successful, a timeout
    // has been reached, or the broker responds with an error.
    await client.connect();

    client.publishString('building/lampu', 'off', MqttQos.atLeastOnce);

    // Then we wait a bit before we cancel our subscription.
    await Future.delayed(Duration(seconds: 2));
  }
}
