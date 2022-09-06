import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:latihan_23_tsa/database/database_helper.dart';
import 'package:latihan_23_tsa/interface/form_contact.dart';
import 'package:latihan_23_tsa/model/contact_model.dart';

class ListContact extends StatefulWidget {
  const ListContact({Key? key}) : super(key: key);

  @override
  State<ListContact> createState() => _ListContactState();
}

class _ListContactState extends State<ListContact> {
  List<Contact> _listContact = [];
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    _getAllContact();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Contact App',
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _listContact.length,
        itemBuilder: (
          context,
          index,
        ) {
          Contact contact = _listContact[index];
          return Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: ListTile(
              leading: const Icon(
                Icons.person,
                size: 50,
              ),
              title: Text('${contact.name}'),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                    child: Text('Email: ${contact.email}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                    child: Text('Email: ${contact.mobileNumber}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                    child: Text('Email: ${contact.company}'),
                  ),
                ],
              ),
              trailing: FittedBox(
                fit: BoxFit.fill,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        _openFormEdit(
                          contact,
                        );
                      },
                      icon: Icon(
                        Icons.edit,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        AlertDialog delete = AlertDialog(
                          title: Text('Informations'),
                          content: Container(
                            height: 100,
                            child: Column(
                              children: [
                                Text(
                                  'Are you sure you want to delete this ${contact.name} ?',
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                _deleteContact(
                                  contact,
                                  index,
                                );
                                Navigator.pop(
                                  context,
                                );
                              },
                              child: Text(
                                'Yes',
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('No'),
                            ),
                          ],
                        );
                        showDialog(
                          context: context,
                          builder: (context) => delete,
                        );
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          _openFormCreate;
        },
      ),
    );
  }

  //adding value
  Future<void> _getAllContact() async {
    var list = await databaseHelper.getAllContact();

    setState(() {
      _listContact.clear();

      list!.forEach((contact) {
        _listContact.add(Contact.fromMap(contact));
      });
    });
  }

  Future<void> _deleteContact(Contact contact, int position) async {
    await databaseHelper.deleteContact(contact.id!);
    setState(() {
      _listContact.removeAt(position);
    });
  }

  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormContact(),
      ),
    );
    if (result == 'save') {
      await _getAllContact();
    }
  }

  Future<void> _openFormEdit(Contact contact) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormContact(),
      ),
    );
    if (result == 'update') {
      await _getAllContact();
    }
  }
}
