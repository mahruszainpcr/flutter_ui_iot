import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          bodyContent,
          Positioned(left: 0, right: 0, bottom: 0, child: bottomNavigationBar)
        ],
      ),
    );
  }

  Widget get bodyContent {
    return SingleChildScrollView(
      child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Header(),
              SizedBox(
                height: 16,
              ),
              Informasi(),
              Menu(),
              Menu2(),
              Menu3(),
              SizedBox(
                height: 70,
              )
            ],
          )),
    );
  }

  Widget get bottomNavigationBar {
    return Container(
        width: double.infinity,
        height: 60,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          child: Container(
            color: Colors.blue[300],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                Icon(
                  Icons.lightbulb_outline,
                  color: Colors.white,
                  size: 30,
                ),
                Icon(
                  Icons.remove_from_queue,
                  color: Colors.white,
                  size: 30,
                ),
                Icon(
                  Icons.hot_tub,
                  color: Colors.white,
                  size: 30,
                )
              ],
            ),
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

class Menu extends StatelessWidget {
  const Menu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 120,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.blue[300],
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          child: Image.asset(
                        "images/ac.png",
                        width: 50,
                      )),
                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "AC",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "5 device",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 120,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          child: Image.asset(
                        "images/lampu.png",
                        width: 50,
                      )),
                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Lampu",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "1 device",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ],
    ));
  }
}

class Menu2 extends StatelessWidget {
  const Menu2({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 120,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          child: Image.asset(
                        "images/meja_kerja.png",
                        width: 50,
                      )),
                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Ruang Kerja",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "1 device",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 120,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          child: Image.asset(
                        "images/ruang_tamu.png",
                        width: 50,
                      )),
                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Ruang Keluarga",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "1 device",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ],
    ));
  }
}

class Menu3 extends StatelessWidget {
  const Menu3({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 120,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          child: Image.asset(
                        "images/mesin_cuci.png",
                        width: 50,
                      )),
                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Mesin Cuci",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "1 device",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 120,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          child: Image.asset(
                        "images/meja_makan.png",
                        width: 50,
                      )),
                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Ruang Makan",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "1 device",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ],
    ));
  }
}

class Informasi extends StatelessWidget {
  const Informasi({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black12),
            ),
            child: Icon(
              Icons.lightbulb_outline,
              size: 30,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text("20.3", style: Theme.of(context).textTheme.display3),
                    Text(" kwh", style: Theme.of(context).textTheme.body1),
                  ],
                ),
                Container(
                  child: Text(
                    "Power usage for today",
                    style: TextStyle(fontSize: 12, color: Colors.black38),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Welcome home",
                      style: TextStyle(fontSize: 12, color: Colors.black38),
                    ),
                    Text(
                      "Mahrus Zain",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
            flex: 4,
          ),
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(8),
            decoration:
                BoxDecoration(color: Colors.blue[300], shape: BoxShape.circle),
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
