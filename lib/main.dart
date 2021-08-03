import 'package:flutter/material.dart';
import 'views/login/login_page.dart';
import 'package:asuka/asuka.dart' as asuka;

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
    debugShowCheckedModeBanner: false,
    builder: asuka.builder,
  ));
}
 