import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<bool> logout(String Server,String cookie)async{
  http.Response response = await http.post(
      Uri.parse('http://$Server/mhgh_api/logout.php'),
      headers: {'Cookie': '$cookie'});
  if(response.statusCode == 200){
    return true;
  }
  return false;
}

void edit_profile(
    String username,
    String discord_data,
    String bio_personale,
    String arma_preferita,
    String preferenze_caccia,
    int orario_libero_inizio,
    int orario_libero_fine,
    int HR,
    String piattaforma,
    String cookie,
    String Server) async {
  var body = Map<String, dynamic>();
  body['username'] = username;
  body['discord_data'] = discord_data;
  body['bio_personale'] = bio_personale;
  body['arma_preferita'] = arma_preferita;
  body['preferenze_caccia'] = preferenze_caccia;
  body['orario_libero_inizio'] = orario_libero_inizio.toString();
  body['orario_libero_fine'] = orario_libero_fine.toString();
  body['HR'] = HR.toString();
  body['piattaforma'] = piattaforma;

  http.Response response = await http.post(
      Uri.parse('http://$Server/mhgh_api/edit_profile.php'),
      body: body,
      headers: {'Cookie': '$cookie'});
  if (response.statusCode == 200) {
    switch (jsonDecode(response.body)['status']) {
      case 'failed':
        print('Failed, reson: ' + jsonDecode(response.body)['reason']);
        break;
      case 'error':
        print('Error, Error: ' + jsonDecode(response.body)['error']);
        break;
      case 'success':
        Map<String, dynamic> json = jsonDecode(response.body);
        print('Stato: ' + jsonDecode(response.body)['status']);
        break;
    }
  }
}

Future<String> signin(
    String email, String password, String username, String Server) async {
  var body = Map<String, dynamic>();
  body['username'] = username;
  body['email'] = email;
  body['password'] = password;

  http.Response response = await http
      .post(Uri.parse('http://$Server/mhgh_api/signin.php'), body: body);
  if (response.statusCode == 200) {
    switch (jsonDecode(response.body)['status']) {
      case 'failed':
        print('Failed, reson: ' + jsonDecode(response.body)['reason']);
        break;
      case 'error':
        print('Error, Error: ' + jsonDecode(response.body)['error']);
        break;
      case 'success':
        Map<String, dynamic> json = jsonDecode(response.body);
        print('Signin Stato: ' + json['status'].toString());
        break;
    }
  }
  String cookie = response.headers['set-cookie']?.split(';')[0] ?? 'vuoto';

  print('Singin Cookie: $cookie');
  return cookie;
}

Future<Map<String,String>> login(String email, String password, String Server) async {
  var body = Map<String, dynamic>();
  body['email'] = email;
  body['password'] = password;

  http.Response response = await http
      .post(Uri.parse('http://$Server/mhgh_api/login.php'), body: body);

  if (response.statusCode == 200) {
    switch (jsonDecode(response.body)['status']) {
      case 'failed':
        var map = Map<String,String>();
        map['status'] = 'failed';
        map['failed'] = jsonDecode(response.body)['reason'];
        return map;
      case 'error':
        var map = Map<String,String>();
        map['status'] = 'error';
        map['error'] = jsonDecode(response.body)['error'];
        return map;
      case 'success':
        Map<String, dynamic> json = jsonDecode(response.body);
        var map = Map<String,String>();
        map['status'] = 'success';
        map['cookie'] = response.headers['set-cookie']!.split(';')[0];
        return map;
    }
  }
  var map = Map<String,String>();
  map['status'] = 'failed';
  map['reson'] = 'dunno';
  return map;
}

Future<bool> login_cookie(String Server, String Cookie) async {
  http.Response response = await http.post(
      Uri.parse('http://$Server/mhgh_api/login.php'),
      headers: {'Cookie': Cookie});

  if (response.statusCode == 200) {
    return true;
  }else return false;
}

void user() async {
  String user_id = '1001';
  http.Response response = await http
      .get(Uri.parse('http://192.168.1.74/mhgh_api/user.php?user_id=$user_id'));

  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    print('Stato: ' + json['status'].toString());
    if (json['result'].toString() != 'none') {
      print('Username: ' + json['result']['username']);
      print('discord_data: ' + json['result']['discord_data']);
      print('bio_personale: ' + json['result']['bio_personale']);
      print('arma_preferita: ' + json['result']['arma_preferita']);
      print('preferenze_caccia: ' + json['result']['preferenze_caccia']);
      print('orario_libero_inizio: ' +
          json['result']['orario_libero_inizio'].toString());
      print('orario_libero_fine: ' +
          json['result']['orario_libero_fine'].toString());
      print('HR: ' + json['result']['HR'].toString());
      print('piattaforma: ' + json['result']['piattaforma']);
    }
  }
}

void search_hunt() async {
  String preferenza = 'ffn';
  int HRMinimo = 1;
  http.Response response = await http.get(
      Uri.parse(
          'http://192.168.1.74/mhgh_api/search_hunt.php?preferenze_caccia=$preferenza&HR=$HRMinimo'),
      headers: {'Cookie': 'PHPSESSID=2qjkhcf6lr82tut7rhianigsji'});
  Map<String, dynamic> json = jsonDecode(response.body);
  print('Stato: ' + json['status'].toString());
  print(response.body);
  if (response.statusCode == 200) {
    for (int i = 0; i < (json['results'] as List).length; i++) {
      print('-----user $i-----');
      print('Username: ' + json['results'][i]['username']);
      print('arma preferita: ' + json['results'][i]['arma_preferita']);
      print('User id: ' + json['results'][i]['fk_credenziali'].toString());
    }
  }
}

void home() async {
  http.Response response = await http.get(
      Uri.parse('http://192.168.1.74/mhgh_api/home.php?'),
      headers: {'Cookie': 'PHPSESSID=2qjkhcf6lr82tut7rhianigsji'});
  Map<String, dynamic> json = jsonDecode(response.body);
  print('Stato: ' + json['status'].toString());
  print(response.body);
  if (response.statusCode == 200) {
    for (int i = 0; i < (json['results'] as List).length; i++) {
      print('-----user $i-----');
      print('Username: ' + json['results'][i]['username']);
      print('arma preferita: ' + json['results'][i]['arma_preferita']);
      print('User id: ' + json['results'][i]['fk_credenziali'].toString());
    }
  }
}

void add_favourites() async {
  String user_id = '1001';
  http.Response response = await http.get(
      Uri.parse(
          'http://192.168.1.74/mhgh_api/add_favourites.php?add_user_id=$user_id'),
      headers: {'Cookie': 'PHPSESSID=2qjkhcf6lr82tut7rhianigsji'});

  if (response.statusCode == 200) {
    if (jsonDecode(response.body)['status'] == 'success') {
      print('Success');
    }
    switch (jsonDecode(response.body)['status']) {
      case 'success':
        print('Success');
        break;
      case 'failed':
        print('Failed, reson: ' + jsonDecode(response.body)['reason']);
        break;
      case 'error':
        print('Error, Error: ' + jsonDecode(response.body)['error']);
        break;
    }
  }
}
