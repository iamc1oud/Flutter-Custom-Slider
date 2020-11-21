import 'package:custom_range_selector/custom_range_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  double start = 0.25;
  double end = 0.75;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double rsWidth = size.width * 0.75;
    double rsHeight = rsWidth*0.25;
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Text("Start : $start", style: TextStyle(fontSize: 50, color: Colors.white)),
            Divider(),
            CustomRangeSelector(
              width: rsWidth,
              height: rsHeight,
              divisions: 10,
              start: start,
              end: end,
              onStartChange: (value){
                setState(() {
                  start = value;
                });
              },
              onEndChange: (value){
                setState(() {
                  end = value;
                });
              },
            ),
            Divider(),
            //Text("End : $end", style: TextStyle(fontSize: 50, color: Colors.white),),
          ],
        ),
      )
    );
  }
}
