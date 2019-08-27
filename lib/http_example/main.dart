import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  String _text = "Http Example";

  void _fetchPosts() async {
    final response = await http.get('https://jsonplaceholder.typicode.com/posts');
    setState(() {
      _text = response.body;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(_text),
      ),
    );
  }
}
