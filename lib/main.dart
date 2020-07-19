import 'dart:async';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
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
  double _suhu = 0;
  double _humidity = 0;
  double _cahaya = 0;
  int _counter = 0;
  var chart;
  var data = [new LinearSales(0, 0)];
  void koneksi() async {
    var series = [
      charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
    chart = charts.LineChart(series);
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
    client.handleString('building/suhu', MqttQos.atLeastOnce).listen((message) {
      data.add(new LinearSales(_counter, int.parse(message)));
      setState(() {
        _counter++;
        data = data;
        _suhu = double.parse(message);
      });
    });
    client
        .handleString('building/humidity', MqttQos.atLeastOnce)
        .listen((message) => setState(() {
              _humidity = double.parse(message);
            }));
    client
        .handleString('building/light', MqttQos.atLeastOnce)
        .listen((message) => setState(() {
              _cahaya = double.parse(message);
            }));
  }

  @override
  Widget build(BuildContext context) {
    koneksi();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
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
                              _suhu.toString(),
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
                              _cahaya.toString(),
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
                              _humidity.toString(),
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
              height: 32,
            ),
            OutlineButton(
              onPressed: () => {_pubKirim()},
              child: statusButton(_temp.toString()),
            ),
            OutlineButton(
              onPressed: () {
                data.add(
                  new LinearSales(_counter, 25),
                );
                setState(() {
                  _counter++;
                  data = data;
                });
              },
              child: Text("Tes"),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: 200,
              child: chart,
            )
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

    client.publishString('building/lampu', 'on', MqttQos.atLeastOnce);

    // Then we wait a bit before we cancel our subscription.
    await Future.delayed(Duration(seconds: 2));
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

// import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Chart Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Chart Demo'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class ClicksPerYear {
//   final String year;
//   final int clicks;
//   final charts.Color color;

//   ClicksPerYear(this.year, this.clicks, Color color)
//       : this.color = charts.Color(
//             r: color.red, g: color.green, b: color.blue, a: color.alpha);
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var data = [
//       ClicksPerYear('2016', 12, Colors.red),
//       ClicksPerYear('2017', 42, Colors.yellow),
//       ClicksPerYear('2018', _counter, Colors.green),
//     ];
//     var series = [
//       charts.Series(
//         domainFn: (ClicksPerYear clickData, _) => clickData.year,
//         measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
//         colorFn: (ClicksPerYear clickData, _) => clickData.color,
//         id: 'Clicks',
//         data: data,
//       ),
//     ];

//     var chart = charts.BarChart(
//       series,
//       animate: true,
//     );

//     var chartWidget = Padding(
//       padding: EdgeInsets.all(32.0),
//       child: SizedBox(
//         height: 200.0,
//         child: chart,
//       ),
//     );

//     return Scaffold(
//       appBar: AppBar(title: Text(widget.title)),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('You have pushed the button this many times:'),
//             Text('$_counter', style: Theme.of(context).textTheme.display1),
//             chartWidget,
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             _counter++;
//           });
//           data.add(
//             ClicksPerYear(_counter.toString(), 12, Colors.red),
//           );
//         },
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
