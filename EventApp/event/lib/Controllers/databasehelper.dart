import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class DatabaseHelper{
  String serverUrl = "https://obscure-hollows-36531.herokuapp.com/api/v1";

  var status;
  var token;

  var email;

  Map data;
  List userData;

loginData(String password, String email) async{

  String myUrl = "$serverUrl/sessions";
  final response = await http.post(myUrl,
    headers: {
      'Content-Type': 'application/json'
     },
     body: json.encode({
	"data": {
		"type": "session",
		"attributes": {
			   "password":"$password",
    		  "email":"$email"
		}
	}
}));

status = response.body.contains('errors');

var data = json.decode(response.body);

if (status) {
  print('ERROR LOGIN');
  print('data :  ${data['errors'][0]['title']}');
  

}else{
  print('data : ${data['data']['attributes']['token']}');
  token = (data['data']['attributes']['token']);
  email = (data['data']['attributes']['email']);
}

}


registerData(String name, String email, String password) async{

  String myUrl = "$serverUrl/users";
  final response = await http.post(myUrl,
    headers: {
      'Content-Type': 'application/json'
     },
     body: json.encode({  
  "data":{  
    "type":"users",
    "attributes":{  
      "password":"$password",
      "email":"$email",
      "name":"$name"
    }
  }
}));

status = response.body.contains('errors');

var data = json.decode(response.body);

if (status) {
  print('ERROR REGISTER');
  print('data :  ${data['errors'][0]['title']}');
  print('ERROR REGISTER');
}else{
  print('data : ${data['data']['attributes']['email']}');
  //_save(data['data']['attributes']['name']);
  print('Registered');
}

}


 Future<Map>getMicropost() async{
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key) ?? 0;

  final prefs1 = await SharedPreferences.getInstance();
  final key1 = 'email';
  final value1 = prefs1.get(key1) ?? 0;

  String myUrl = "$serverUrl/microposts/";
  http.Response response = await http.get(myUrl,
  headers: {
    'Content-Type': 'application/json',
    //'Authorization' : 'Token token="$value",email=$value1',
    'Authorization' : 'Token token="$token",email=$email',
  });
  return json.decode(response.body);


}


void deleteData(int id) async{
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key) ?? 0;

  final prefs1 = await SharedPreferences.getInstance();
  final key1 = 'email';
  final value1 = prefs1.get(key1) ?? 0;

  String myUrl = "$serverUrl/users/$id";
  http.delete(myUrl,
  headers: {
    'Content-Type': 'application/json',
    'Authorization' : 'Token token="$value",email=$value1',
  },).then((response){
  print('Response Status : ${response.statusCode}');
  print('Response Body : ${response.body}');
});
}


void addMicropostData(String micropost) async{


  String myUrl = "$serverUrl/microposts";
  http.post(myUrl,
  headers: {
    'Content-Type': 'application/json',
    'Authorization' : '#YOUR_TOKEN',
  },
  body: json.encode({  
  "data":{  
    "type":"microposts",
    "attributes":{  
       
        "content": "$micropost",
        "user_id": 1
      
    }
  }
}
)).then((response){
  print('Response Status : ${response.statusCode}');
  print('Response Body : ${response.body}');
});
}


void editData(int id, String name) async{

    final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key) ?? 0;

  final prefs1 = await SharedPreferences.getInstance();
  final key1 = 'email';
  final value1 = prefs1.get(key1) ?? 0;

  
  String myUrl = "$serverUrl/users/$id";
  http.put(myUrl,
  headers: {
    'Content-Type': 'application/json',
    'Authorization' : 'Token token="$value",email=$value1',
  },
  body: json.encode({
  "data": {
    "id": "$id",
    "type": "users",
    "attributes": {
      "name": "$name",
    }
  }
})).then((response){
  print('Response Status : ${response.statusCode}');
  print('Response Body : ${response.body}');
});
}




_save(String token) async{
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = token;
  prefs.setString(key, value);
}

_save1(String email) async{
  final prefs1 = await SharedPreferences.getInstance();
  final key1 = 'email';
  final value1 = email;
  prefs1.setString(key1, value1);
}


read() async{
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key) ?? 0;
  print('read : $value');
}

read1() async{
  final prefs1 = await SharedPreferences.getInstance();
  final key1 = 'email';
  final value1 = prefs1.get(key1) ?? 0;
  print('read : $value1');
}

}