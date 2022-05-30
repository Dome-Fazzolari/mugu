import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mugu/searchHunt.dart';
import 'package:mugu/serverRequests.dart';
import 'package:mugu/signin.dart';
import 'package:mugu/userPage.dart';
import 'package:mugu/userSearched.dart';
import 'package:mugu/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

String username = 'User';
bool isFavLoaded = false;
List<Widget> utenti = [];

class _homePageState extends State<homePage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.endOfFrame.then(
          (_)async {
        if (mounted) {
          var prefs = await SharedPreferences.getInstance();
          setState(() {
            username = prefs.getString('username') ?? 'balls';
          });
          var users = await caricaPreferiti(context);
          setState(() {
            utenti = users;
            isFavLoaded = true;
          });
        };
      },
    );
  }

  @override
  Widget build(BuildContext context){

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
              Padding(
                padding: EdgeInsets.only(left: 10.0,bottom: 10),
                child: Text('$username',style: TextStyle(color: Colors.white,fontSize: 40),),
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
                    bool risultato = await logout('mugu.altervista.org', sess);
                    if(risultato){
                      await prefs.clear();
                      Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context)=>const welcome()));
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
            isFavLoaded
            ? Expanded(
                child: ListView(
                  children: utenti,
                ))
            : Center(
              child: CircularProgressIndicator(),
            )
          ],
        ),
    );

  }


}
  stampaCarta(context,String arma,String HR,String username,String user_id) {
    return InkWell(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=>userSearched(user_id: user_id))
        );
      },
      child: Card(
        child: Row(
          children: [
            Image(image: AssetImage('assets/weapon_logo/$arma.png'),height: 75,width: 75,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$username',style: TextStyle(color: Colors.white,fontSize: 30),),
                Text('HR: $HR',
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
Future<List<Widget>> caricaPreferiti(BuildContext context)async{
  List<userTile> utenti = await home();

  List<Widget> carte = [];
  if(utenti.length > 0){
    for(int i = 0;i<utenti.length;i++){
      carte.add(stampaCarta(context, utenti[i].weapon, utenti[i].hr, utenti[i].username, utenti[i].user_id.toString()));
    }
  }else{
    carte.add(Center(child: Text('No favourites',style: TextStyle(color: Colors.white,fontSize: 30),),));
  }
  return carte;
}



