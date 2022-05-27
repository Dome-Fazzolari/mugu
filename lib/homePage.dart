import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mugu/searchHunt.dart';
import 'package:mugu/serverRequests.dart';
import 'package:mugu/userPage.dart';
import 'package:mugu/userSearched.dart';
import 'package:mugu/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children:  [
              const DrawerHeader(
                child: Text(''),
                decoration: BoxDecoration(
                  color: Color(0XFF123057),
                  image: DecorationImage(
                      image: AssetImage('assets/hunter.png'),
                    fit: BoxFit.cover
                  )
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0,bottom: 10),
                child: Text('Arogen',style: TextStyle(color: Colors.white,fontSize: 40),),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.account_circle),
                  onTap: ()=>{
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>const userPage())
                    )
                  },
                  title: Text('User profile',style: TextStyle(color: Colors.white,fontSize: 20),),
                ),
                color: Color(0XFF194175),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.logout,color: Colors.red,),
                  onTap: () async{
                    var prefs = await SharedPreferences.getInstance();
                    String sess = prefs.getString('PHPSESSID') ?? '';
                    bool risultato = await logout('192.168.1.74', sess);
                    if(risultato){
                      prefs.remove('PHPSESSID');
                      Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context)=>const welcome()),
                            (Route<dynamic> route) => false,);
                    }
                  },
                  title: Text('Log out',style: TextStyle(color: Colors.red,fontSize: 20),),
                ),
                color: Color(0XFF194175),
              ),
            ],
          ),
          backgroundColor: Color(0XFF123057),
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          //leading: Icon(Icons.menu, color: Colors.white,),
          title: Text('MUGU', style: TextStyle(color: Colors.white),),
          backgroundColor: Color(0XFF123057),
        ),
        backgroundColor: Color(0XFF000F2C),
        body: Column(
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0XFF123057),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextButton(
                      onPressed: () => {
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>const searchHunt())
                      )
                      },
                      child: Text('Search hunt',
                        style: TextStyle(color: Colors.white, fontSize: 40),)),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  child: Text('Favourite users',
                      style: TextStyle(color: Colors.white, fontSize: 30)),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  stampaCarta(context),
                  stampaCarta(context),
                  stampaCarta(context),
                  stampaCarta(context),
                  stampaCarta(context),
                  stampaCarta(context),
                  stampaCarta(context),
                  stampaCarta(context),
                  stampaCarta(context),
                  stampaCarta(context),
                ],
              ),
            )
          ],
        ),
    );
  }
}
  stampaCarta(context) {
    return InkWell(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=>const userSearched())
        );
      },
      child: Card(
        child: Row(
          children: [
            Image(image: AssetImage('assets/LS.png'),height: 75,width: 75,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Arogen',style: TextStyle(color: Colors.white,fontSize: 30),),
                Text('HR: 69',
                  style: TextStyle(color: Colors.grey,fontSize: 15)
                ),
              ],
            ),
            new Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Icon(Icons.favorite,color: Colors.red,size: 45),
            )
          ],
        ),
        color: Color(0XFF123057),
      ),
    );
  }

