import 'package:flutter/material.dart';
import 'package:mugu/editProfile.dart';
import 'package:mugu/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class userPage extends StatefulWidget {
  const userPage({Key? key}) : super(key: key);

  @override
  _userPageState createState() => _userPageState();
}

String username = '';
String weapon = '';
String discord = '';
String bio = '';
String HR = '';
String preferences = '';
String onTime = '';



class _userPageState extends State<userPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.endOfFrame.then(
          (_) {
        if (mounted) layData(context);
      },
    );
  }


  var isSameUser = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF000F2C),
      appBar: AppBar(
        title: Text('User info', style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0XFF123057),
        leading: InkWell(
            onTap: (){Navigator.push(context,
                MaterialPageRoute(builder: (context)=>const homePage()));},
            child:Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/hunter.png'),
                fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,top: 10),
              child: Row(
                children: [
                  Image(image: AssetImage('assets/weapon_logo/$weapon.png'),height: 50,width: 50,),
                  Text('$username',style: TextStyle(color: Colors.white,fontSize: 50),),
                  new Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0,right: 10),
                    child: InkWell(
                      splashFactory: NoSplash.splashFactory,
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>const editProfile()));
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Icon(Icons.edit,color: Colors.white,size: 40,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text('$discord',style: TextStyle(color: Colors.grey,fontSize: 18),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
              child: Container( //Bio info
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Bio',style: TextStyle(color: Colors.white,fontSize: 20),),
                      Padding(padding: EdgeInsets.only(top: 5,bottom: 10),
                        child: Container(
                          width: double.infinity,
                          height: 1,
                          color: Color(0XFF123057),
                          
                        ),
                      ),
                      Text('$bio',
                      style: TextStyle(color: Colors.white,fontSize: 18),
                      ),
                      SizedBox(height: 50,),
                      Text('Hunter info',style: TextStyle(color: Colors.white,fontSize: 20),),
                      Padding(padding: EdgeInsets.only(top: 5,bottom: 10),
                        child: Container(
                          width: double.infinity,
                          height: 1,
                          color: Color(0XFF123057),
                        ),
                      ),
                      Text('HR: $HR',style: TextStyle(color: Colors.white,fontSize: 18),),
                      Text('Gameplay preferences: $preferences',style: TextStyle(color: Colors.white,fontSize: 18),),
                      Text('Online time: $onTime',style: TextStyle(color: Colors.white,fontSize: 18),),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void layData (BuildContext context)async{
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'user_error';
      weapon = prefs.getString('arma_preferita') ?? 'LS';
      discord = prefs.getString('discord_data') ?? 'data_error';
      bio = prefs.getString('bio_personale') ?? 'bio_error';
      HR = prefs.getInt('HR').toString();
      preferences = prefs.getString('preferenze_caccia') ?? 'preferences_error';
      onTime = prefs.getInt('orario_libero_inizio').toString()+"-"+prefs.getInt('orario_libero_fine').toString();
    });
  }
}
