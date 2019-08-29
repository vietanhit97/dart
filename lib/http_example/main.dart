import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(HttpApp());
}

class Post {
  final int userId;
  final int id;
  final String title;

  Post({
    this.userId,
    this.id,
    this.title,
  });

  factory Post.fromJSON(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
    );
  }
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
  List<Post> _posts = [];

  void _fetchPosts() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/posts');
    final List<Post> parsedResponse = jsonDecode(response.body)
        .map<Post>((json) => Post.fromJSON(json))
        .toList();
    setState(() {
      _posts.clear();
      _posts.addAll(parsedResponse);
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
        child: ListView.builder(
          itemCount: this._posts.length,
          itemBuilder: (context, index) {
            final post = this._posts[index];
            return ListTile(
              title: Text(post.title),
              subtitle: Text('Id: ${post.id}  UserId: ${post.userId}'),
            );
          },
        ),
      ),
    );
  }
}
