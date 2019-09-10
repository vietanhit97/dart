import 'package:flutter/material.dart';

void main() => runApp(SQLiteApp());

class SQLiteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Contacts(),
    );
  }
}

class Contacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
    );
  }
}
