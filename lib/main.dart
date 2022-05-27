import 'package:flutter/material.dart';
import 'package:mugu/homePage.dart';
import 'package:mugu/serverRequests.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'welcome.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  if(prefs.getString('PHPSESSID') != null) {
    String cookie = prefs.getString('PHPSESSID') ?? 'PHPSESSID=';
    if (await login_cookie('192.168.1.74', cookie)) {
      runApp(const MaterialApp(
        home:  homePage()
      ));
    }
  }else{
    runApp(const MaterialApp(
      home: welcome()
    ));
  }
}
