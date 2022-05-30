import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



class userTile{

  String username = '';
  String weapon = '';
  String user_id = '';
  String hr = '';

  userTile(this.username, this.weapon, this.hr,this.user_id);
}


Future<bool> logout(String Server,String cookie)async{
  http.Response response = await http.post(
      Uri.parse('http://$Server/mhgh_api/logout.php'),
      headers: {'Cookie': '$cookie'});
  if(response.statusCode == 200){
    return true;
  }
  return false;
}

Future<Map<String,dynamic>> edit_profile(
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
  var risposta = jsonDecode(response.body);
  if (response.statusCode == 200) {
    risposta['status'] = jsonDecode(response.body)['status'];
    risposta['failed'] = jsonDecode(response.body)['reason'] ?? '';
    risposta['error'] = jsonDecode(response.body)['error'] ?? '';
  }else{
    risposta['status'] =  'error';
    risposta['error'] = 'unidentified error';
  }
  return risposta;
}

Future<Map<String,dynamic>> signin(
    String email, String password, String username, String Server) async {
  var body = Map<String, dynamic>();
  body['username'] = username;
  body['email'] = email;
  body['password'] = password;

  http.Response response = await http
      .post(Uri.parse('http://$Server/mhgh_api/signin.php'), body: body);
  var risposta = jsonDecode(response.body);
  if (response.statusCode == 200) {
    String cookie = response.headers['set-cookie']?.split(';')[0] ?? '';

    risposta['status'] = jsonDecode(response.body)['status'];
    risposta['failed'] = jsonDecode(response.body)['reason'] ?? '';
    risposta['error'] = jsonDecode(response.body)['error'] ?? '';
    risposta['user_id'] = jsonDecode(response.body)['user_id'] ?? '';
    risposta['cookie'] = cookie;
  }else{
    risposta['status'] =  'error';
    risposta['error'] = 'unidentified error';
  }
  return risposta;
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
        map['user_id'] = jsonDecode(response.body)['user_id'].toString();
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

Future<Map<String,dynamic>> user(String user_id,String Server) async {
  http.Response response = await http
      .get(Uri.parse('http://$Server/mhgh_api/user.php?user_id=$user_id'));
  var risposta = Map<String,dynamic>();
  print(response.statusCode);
  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    risposta['status'] = json['status'].toString();
    if (json['result'].toString().compareTo('none') != 0) {
      risposta['noResults'] = false;
      risposta['username'] = json['result']['username'];
      risposta['discord_data'] = json['result']['discord_data'];
      risposta['bio_personale'] = json['result']['bio_personale'];
      risposta['arma_preferita'] = json['result']['arma_preferita'];
      risposta['preferenze_caccia'] = json['result']['preferenze_caccia'];
      risposta['orario_libero_inizio'] = json['result']['orario_libero_inizio'].toString();
      risposta['orario_libero_fine'] = json['result']['orario_libero_fine'].toString();
      risposta['HR'] = json['result']['HR'].toString();
      risposta['piattaforma'] = json['result']['piattaforma'];
    }else{
      risposta['noResults'] = true;
    }
  }else{
    risposta['status'] = 'error';
    risposta['error'] = 'unidentified error';
  }
  return risposta;
}

Future<List<userTile>> search_hunt(String preferenza,String HRMinimo) async {
  List<userTile> utenti = [];
  var prefs = await SharedPreferences.getInstance();
  http.Response response = await http.get(
      Uri.parse(
          'http://192.168.1.74/mhgh_api/search_hunt.php?preferenze_caccia=$preferenza&HR=$HRMinimo'),
      headers: {'Cookie': prefs.getString('PHPSESSID') ?? ''});
  Map<String, dynamic> json = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if(json['results'].toString().compareTo('none')!=0){
      for (int i = 0; i < (json['results'] as List).length; i++) {
        utenti.add(
            userTile(json['results'][i]['username'],
                json['results'][i]['arma_preferita'],
                json['results'][i]['HR'].toString(),
                json['results'][i]['fk_credenziali'].toString()));
      }
    }
  }
  return utenti;
}

Future<List<userTile>> home() async {
  List<userTile> utenti = [];
  var prefs = await SharedPreferences.getInstance();
  http.Response response = await http.get(
      Uri.parse('http://192.168.1.74/mhgh_api/home.php?'),
      headers: {'Cookie': prefs.getString('PHPSESSID') ?? ''});
  Map<String, dynamic> json = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if(json['results'].toString().compareTo('none')!=0){
      for (int i = 0; i < (json['results'] as List).length; i++) {
        utenti.add(
            userTile(json['results'][i]['username'],
                json['results'][i]['arma_preferita'],
                json['results'][i]['HR'].toString(),
                json['results'][i]['fk_credenziali'].toString()));
      }
    }
  }
  return utenti;
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
