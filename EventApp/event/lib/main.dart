import 'package:event/View/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'View/adddata.dart';
import 'View/login.dart';
import 'View/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String title ='';
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EVENT APP',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: LoginPage(
        title: 'EVENT APP',),
        routes: <String, WidgetBuilder>{
          '/dashboard' : (BuildContext context) => new Dashboard(title:title),
          '/adddata' : (BuildContext context) => new AddData(title:title),
          '/register' : (BuildContext context) => new RegisterPage(title:title),
          '/login' : (BuildContext context) => new LoginPage(title:title),
        }
      
    );
  }
}