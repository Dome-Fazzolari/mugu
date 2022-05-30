import 'package:flutter/material.dart';
import 'serverRequests.dart' as sr;

class userSearched extends StatefulWidget {
  final String user_id;
  userSearched({Key? key,required this.user_id}) : super(key: key);

  @override
  _userSearchedState createState() => _userSearchedState();
}

String username = '';
String weapon = '';
String discord = '';
String bio = '';
String HR = '';
String preferences = '';
String onTime = '';

class _userSearchedState extends State<userSearched> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.endOfFrame.then(
          (_) {
        if (mounted) layData(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('user: '+widget.user_id);
    return Scaffold(
      backgroundColor: Color(0XFF000F2C),
      appBar: AppBar(
        leading: InkWell(
          onTap: (){Navigator.pop(context);},
          child: Icon(Icons.arrow_back,color: Colors.white,),
        ),
        title: Text('User info',style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0XFF123057),
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
                  Text('$username',style: TextStyle(color: Colors.white,fontSize: 40),overflow: TextOverflow.ellipsis,),
                  new Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0,right: 10),
                    child: InkWell(
                      splashFactory: NoSplash.splashFactory,
                      onTap: (){},
                      child: Container(
                        width: 50,
                        height: 50,
                        child: Icon(Icons.favorite_outline,size: 40,),
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
    var precc = Map<String,String>();
    precc['FFN'] = 'For fun';
    precc['TRH'] = 'Tryhard';
    precc['GRD'] = 'Grind';
    precc['GVH'] = 'Giving help';
    precc['SRH'] = 'Searching help';
    var datiUtente = await sr.user(widget.user_id,'192.168.1.74');
    setState(() {
      username = datiUtente['username'];
      weapon = datiUtente['arma_preferita'];
      discord = datiUtente['discord_data'];
      bio = datiUtente['bio_personale'];
      HR = datiUtente['HR'];
      preferences = precc[datiUtente['preferenze_caccia']] ?? '';
      onTime =datiUtente['orario_libero_inizio'] + '-' + datiUtente['orario_libero_fine'];
    });
  }
}
