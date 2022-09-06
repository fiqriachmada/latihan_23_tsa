import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:latihan_23_tsa/database/database_helper.dart';
import 'package:latihan_23_tsa/model/contact_model.dart';

class FormContact extends StatefulWidget {
  // const FormContact({Key? key}) : super(key: key);

  final Contact? contact;

  FormContact({this.contact});

  @override
  State<FormContact> createState() => _FormContactState();
}

class _FormContactState extends State<FormContact> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  TextEditingController? name;
  TextEditingController? lastName;
  TextEditingController? mobileNumber;
  TextEditingController? email;
  TextEditingController? company;

  @override
  void initState() {
    name = TextEditingController(
      text: widget.contact == null ? '' : widget.contact!.name,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center();
  }
}
