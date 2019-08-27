import 'package:flutter/material.dart';

void main() {
  runApp(HttpApp());
}

class HttpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HttpExampleWidget(),
    );
  }
}

class HttpExampleWidget extends StatefulWidget {
  @override
  _HttpExampleWidgetState createState() => _HttpExampleWidgetState();
}

class _HttpExampleWidgetState extends State<HttpExampleWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Http Example'),
      ),
    );
  }
}
