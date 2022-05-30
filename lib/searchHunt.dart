import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:mugu/homePage.dart';
import 'package:mugu/serverRequests.dart';
import 'package:mugu/userSearched.dart';
import 'serverRequests.dart' as sr;

class searchHunt extends StatefulWidget {
  const searchHunt({Key? key}) : super(key: key);

  @override
  _searchHuntState createState() => _searchHuntState();
}

List<Widget> utenti = [];
String preferences = 'FFN';
List<S2Choice<String>> preferenze_caccia = [
  S2Choice<String>(value: 'FFN', title: 'For fun'),
  S2Choice<String>(value: 'TRH', title: 'Tryhard'),
  S2Choice<String>(value: 'GRD', title: 'Grind'),
  S2Choice<String>(value: 'GVH', title: 'Giving help'),
  S2Choice<String>(value: 'SRH', title: 'Searching help')
];
double _currentSliderValue = 0;

bool _isLoaded = false;
bool _isSearched = false;

class _searchHuntState extends State<searchHunt> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF000F2C),
      appBar: AppBar(
        title: Text('Search hunt',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        leading: InkWell(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>const homePage()));
              },
            child:Icon(Icons.arrow_back,color: Colors.white,)),
        backgroundColor: Color(0XFF123057),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Theme(
                  data: ThemeData(
                    textTheme: TextTheme(headline1: TextStyle(color: Colors.white))
                  ),
                  child: SmartSelect<String>.single(
                    title: 'Hunt preferences',
                    selectedValue: preferences,
                    choiceItems: preferenze_caccia,
                    onChange: (state)=>setState(() {
                      preferences = state.value ?? 'FFN';

                    }),
                    modalType: S2ModalType.bottomSheet,
                    tileBuilder: (context, state) {
                      return S2Tile.fromState(
                        state,
                        title: Text( 'Hunt preferences',
                            style: TextStyle(color: Colors.white)),
                      );
                    },

                    modalHeaderStyle: const S2ModalHeaderStyle(
                        textStyle: TextStyle(color: Colors.white)
                    ),
                    choiceActiveStyle: const S2ChoiceStyle(
                      color: Colors.white,
                    ),
                    choiceStyle: const S2ChoiceStyle(
                      titleStyle: TextStyle(color: Colors.white),
                    ),
                    modalConfig: const S2ModalConfig(
                      headerStyle:  S2ModalHeaderStyle(
                          backgroundColor: Color(0XFF000F2C),
                          textStyle: TextStyle(color: Colors.white)
                      ),
                      style: S2ModalStyle(
                        backgroundColor: Color(0XFF000F2C),
                      ),
                    ),
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10,left: 15),
                  child: Text('MIN HR: '+_currentSliderValue.round().toString(),style: TextStyle(color: Colors.white,fontSize: 20),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 5,
                      thumbColor: Colors.white,
                      valueIndicatorColor: Color(0XFF194175),
                      valueIndicatorTextStyle: TextStyle(color: Colors.white),
                      activeTrackColor: Color(0XFF194175),
                      inactiveTrackColor: Color(0XFF123057),
                    ),
                    child: Slider(
                      label:  _currentSliderValue.round().toString(),
                        value: _currentSliderValue,
                        max: 999,
                        divisions: 100,
                        onChanged: (double value)=>setState(() {
                          _currentSliderValue = value;
                        }),

                    ),
                  ),
                ),
                Center(
                  child: InkWell(
                    onTap: ()async{
                      setState(() {
                        _isSearched = true;
                        _isLoaded = false;
                      });
                      var users = await caricaRicerca(context, preferences, _currentSliderValue.toString());
                      setState(() {
                        utenti = users;
                        _isLoaded = true;
                      });

                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0XFF194175),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text('Search',style: TextStyle(color: Colors.white,fontSize: 30),),
                    ),
                  ),
                )
              ],
            ),
          ),
          _isLoaded
          ?Expanded(
            child: ListView(
              children: utenti,
            ),
          )
          : _isSearched
          ?Expanded(
            child: Center(
              child: CircularProgressIndicator() ,
            ),
          ):Center()
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

Future<List<Widget>> caricaRicerca(BuildContext context,String preferences,String HR)async{
  List<userTile> utenti = await sr.search_hunt(preferences,HR);

  List<Widget> carte = [];
  if(utenti.length > 0){
    for(int i = 0;i<utenti.length;i++){
      carte.add(stampaCarta(context, utenti[i].weapon, utenti[i].hr, utenti[i].username, utenti[i].user_id.toString()));
    }
  }else{
    carte.add(Center(child: Text('No results',style: TextStyle(color: Colors.white,fontSize: 30),),));
  }
  return carte;
}