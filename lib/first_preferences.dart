import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:mugu/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'serverRequests.dart' as sr;

class first_preferences extends StatefulWidget {
  const first_preferences({Key? key}) : super(key: key);

  @override
  _first_preferencesState createState() => _first_preferencesState();
}
String weapon = 'LS';
List<S2Choice<String>> armi = [
  S2Choice<String>(value: 'GS', title: 'Great sword'),
  S2Choice<String>(value: 'LS', title: 'Long sword'),
  S2Choice<String>(value: 'SNS', title: 'Sword and shied'),
  S2Choice<String>(value: 'DB', title: 'Dual blades'),
  S2Choice<String>(value: 'HAM', title: 'Hammer'),
  S2Choice<String>(value: 'HH', title: 'Hunting horn'),
  S2Choice<String>(value: 'LNC', title: 'Lance'),
  S2Choice<String>(value: 'GL', title: 'Gunlance'),
  S2Choice<String>(value: 'SA', title: 'Switch axe'),
  S2Choice<String>(value: 'IG', title: 'Insect glaive'),
  S2Choice<String>(value: 'CB', title: 'Charge blade'),
  S2Choice<String>(value: 'LBG', title: 'Light bowgun'),
  S2Choice<String>(value: 'HBG', title: 'Heavy bowgun'),
  S2Choice<String>(value: 'BOW', title: 'Bow')
];
String preferences = 'FFN';
List<S2Choice<String>> preferenze_caccia = [
  S2Choice<String>(value: 'FFN', title: 'For fun'),
  S2Choice<String>(value: 'TRH', title: 'Tryhard'),
  S2Choice<String>(value: 'GRD', title: 'Grind'),
  S2Choice<String>(value: 'GVH', title: 'Giving help'),
  S2Choice<String>(value: 'SRH', title: 'Searching help')
];
String platform = 'NS';
List<S2Choice<String>> piattaforma = [
  S2Choice<String>(value: 'NS', title: 'Switch'),
  S2Choice<String>(value: 'PC', title: 'Pc')
];

var HRController = TextEditingController();
var DiscordController = TextEditingController();
var BioController = TextEditingController();
var TStartController = TextEditingController();
var TEndController = TextEditingController();
class _first_preferencesState extends State<first_preferences> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Color(0XFF000F2C),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  Text('Hunter info',style: TextStyle(color: Colors.white,fontSize: 40),),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        child: TextField(
                          controller: HRController,
                          style: TextStyle(color: Colors.white,fontSize: 20),
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: TextStyle(color: Colors.white),
                            labelText: 'HR',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)
                            ),
                            focusedBorder:  UnderlineInputBorder(
                                borderSide:  BorderSide(color: Colors.white)
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Container(
                          width: 270,
                          child: TextField(
                            controller: DiscordController,
                            style: TextStyle(color: Colors.white,fontSize: 20),
                            decoration: const InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              enabledBorder:UnderlineInputBorder(
                                  borderSide:  BorderSide(color: Colors.white)
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:  BorderSide(color: Colors.white)
                              ),
                              labelText: 'Discord',
                              labelStyle: TextStyle(color: Colors.white,fontSize: 20),
                              hintStyle: TextStyle(color: Colors.grey),
                              hintText: ' ex. pius#2107'
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child:  TextField(
                      style: TextStyle(color: Colors.white,fontSize: 20),
                      maxLines: 3,
                      decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          enabledBorder:UnderlineInputBorder(
                              borderSide:  BorderSide(color: Colors.white)
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:  BorderSide(color: Colors.white)
                          ),
                          labelText: 'Bio',
                          labelStyle: TextStyle(color: Colors.white,fontSize: 20),
                      ),
                      controller: BioController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      width: 340,
                      child: SmartSelect<String>.single(
                        title: 'Favourite weapon',
                        selectedValue: 'LS',
                        choiceItems: armi,
                        onChange: (state) {
                          weapon = state.value.toString() ?? 'LS'; //definitely not my favoutite weapon
                          setState(() => weapon = state.value.toString());
                          print(weapon);
                          },
                        modalHeaderStyle: S2ModalHeaderStyle(
                          textStyle: TextStyle(color: Colors.white)
                        ),
                        choiceActiveStyle: S2ChoiceStyle(
                          color: Colors.white
                        ),
                        choiceStyle: S2ChoiceStyle(
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
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      width: 340,
                      child: SmartSelect<String>.single(
                        title: 'Hunt preferences',
                        selectedValue: preferences,
                        choiceItems: preferenze_caccia,
                        onChange: (state) {
                          preferences = state.value.toString() ?? 'GRD';
                          setState(() => preferences = state.value .toString()?? 'GRD');
                          },

                        modalHeaderStyle: const S2ModalHeaderStyle(
                            textStyle: TextStyle(color: Colors.white)
                        ),
                        choiceActiveStyle: const S2ChoiceStyle(
                            color: Colors.white
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
                      ),
                    ),
                  ),Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      width: 340,
                      child: SmartSelect<String>.single(
                        title: 'Platform',
                        selectedValue: platform,
                        choiceItems: piattaforma,
                        onChange: (state) {platform = state.value.toString() ?? 'NS';setState(() => platform = state.value.toString());},

                        modalHeaderStyle: const S2ModalHeaderStyle(
                            textStyle: TextStyle(color: Colors.white)
                        ),
                        choiceActiveStyle: const S2ChoiceStyle(
                            color: Colors.white
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
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Text("Game start time",style: TextStyle(color: Colors.white,fontSize: 20),),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Container(
                            width: 50,
                            child: TextField(
                              controller: TStartController,
                              style: TextStyle(color: Colors.white,fontSize: 20),
                              decoration: const InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                labelStyle: TextStyle(color: Colors.white),

                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)
                                ),
                                focusedBorder:  UnderlineInputBorder(
                                    borderSide:  BorderSide(color: Colors.white)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Text("Game end time",style: TextStyle(color: Colors.white,fontSize: 20),),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Container(
                            width: 50,
                            child: TextField(
                              controller: TEndController,
                              style: TextStyle(color: Colors.white,fontSize: 20),
                              decoration: const InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                labelStyle: TextStyle(color: Colors.white),

                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)
                                ),
                                focusedBorder:  UnderlineInputBorder(
                                    borderSide:  BorderSide(color: Colors.white)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: TextButton(
                      child: Container(
                        width: 250,
                        child: Center(
                          child: Text("FINISH"),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () async{
                      var prefs = await SharedPreferences.getInstance();
                      var editResult = await sr.edit_profile(
                          prefs.getString('username') ?? '',
                          DiscordController.text,
                          BioController.text,
                          weapon,
                          preferences,
                          int.parse(TStartController.text),
                          int.parse(TEndController.text),
                          int.parse(HRController.text),
                          platform,
                          prefs.getString('cookie') ?? '',
                          '192.168.1.74'
                      );
                      if(editResult['status'].toString().compareTo('success') == 0){
                        var precc = Map<String,String>();
                        precc['FFN'] = 'For fun';
                        precc['TRH'] = 'Tryhard';
                        precc['GRD'] = 'Grind';
                        precc['GVH'] = 'Giving help';
                        precc['SRH'] = 'Searching help';

                        prefs.setString('username', prefs.getString('username') ?? '');
                        prefs.setString('discord_data', DiscordController.text);
                        prefs.setString('bio_personale', BioController.text);
                        prefs.setString('arma_preferita', weapon);
                        prefs.setString('preferenze_caccia', precc[preferences] ?? 'For fun');
                        prefs.setInt('orario_libero_inizio', int.parse(TStartController.text));
                        prefs.setInt('orario_libero_fine', int.parse(TEndController.text));
                        prefs.setInt('HR', int.parse(HRController.text));
                        prefs.setString('piattaforma', platform);

                        Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>const homePage())
                        );
                        }else{
                          showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                            title: Text(editResult['status'] ?? ''),
                            content: Text(editResult[editResult['status']] ?? ''),
                            );
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
            ),

          ),
        ),
      ),
    );
  }
}
