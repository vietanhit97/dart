import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(SQLiteApp());

class SQLiteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Contacts(),
    );
  }
}

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class Contact {
  final int id;
  final String phone;

  Contact(this.id, this.phone);

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(json['id'], json['phone']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "phone": this.phone,
    };
  }
}

class _ContactsState extends State<Contacts> {
  Database _database;
  final TextEditingController _phoneTextController = TextEditingController();
  List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  void _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final String path = join(databasePath, "contacts.db");
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE Contact(id INTEGER PRIMARY KEY AUTOINCREMENT, phone TEXT);');
      },
    );
    _fetchContacts();
  }

  void _fetchContacts() async {
    final result = await _database.query("Contact");
    setState(() {
      _contacts =
          result.map<Contact>((contact) => Contact.fromJson(contact)).toList();
    });
  }

  void _saveContact() async {
    final phone = _phoneTextController.text;
    if (phone.isEmpty) {
      return;
    }
    final contact = Contact(null, phone);
    _database.insert("Contact", contact.toJson());
    _phoneTextController.clear();
    _fetchContacts();
  }

  void _deleteContact(int id) async {
    await _database.delete(
      "Contact",
      where: "id = ?",
      whereArgs: [id],
    );
    _fetchContacts();
  }

  @override
  void dispose() {
    super.dispose();
    _database.close();
    _phoneTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _phoneTextController,
              keyboardType: TextInputType.number,
            ),
            RaisedButton(
              child: Text('Save'),
              onPressed: () {
                _saveContact();
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  final contact = _contacts[index];
                  return ListTile(
                    title: Text(contact.phone),
                    onLongPress: () {
                      _deleteContact(contact.id);
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
