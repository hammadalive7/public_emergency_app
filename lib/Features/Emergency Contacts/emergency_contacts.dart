import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  late String _contact1;
  late String _contact2;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _contact1 = prefs.getString('contact1')!;
      _contact2 = prefs.getString('contact2')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Contact List'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Contact 1'),
            subtitle: Text(_contact1 ?? ''),
          ),
          ListTile(
            title: Text('Contact 2'),
            subtitle: Text(_contact2 ?? ''),
          ),
        ],
      ),
    );
  }
}
