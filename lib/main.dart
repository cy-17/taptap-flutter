import 'package:flutter/material.dart';
import 'package:taptap/config/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TAPTAP',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: _TransitPage(),
    );
  }
}

class _TransitPage extends StatefulWidget {
  const _TransitPage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<_TransitPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        "assets/images/launch/launch_main.jpeg",
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
