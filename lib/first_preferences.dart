import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
class first_preferences extends StatefulWidget {
  const first_preferences({Key? key}) : super(key: key);

  @override
  _first_preferencesState createState() => _first_preferencesState();
}

class _first_preferencesState extends State<first_preferences> {
  @override
  Widget build(BuildContext context) {
    String? weapon = 'LS';
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

    return Scaffold(
      backgroundColor: Color(0XFF000F2C),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20,),
                Text('Hunter info',style: TextStyle(color: Colors.white,fontSize: 40),),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Container(
                        width: 50,
                        child: TextField(
                          controller: TextEditingController(),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: Container(
                        width: 270,
                        child: TextField(
                          controller: TextEditingController(),
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
                  width: 340,
                  child: const TextField(
                    style: TextStyle(color: Colors.white,fontSize: 20),
                    maxLines: 3,
                    decoration: InputDecoration(
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    width: 340,
                    child: SmartSelect<String>.single(
                      title: 'Favourite weapon',
                      selectedValue: weapon,
                      choiceItems: armi,
                      onChange: (state) => setState(() => weapon = state.value),


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
                      title: 'Favourite weapon',
                      selectedValue: preferences,
                      choiceItems: preferenze_caccia,
                      onChange: (state) => setState(() => weapon = state.value),

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
                      onChange: (state) => setState(() => weapon = state.value),

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
                  padding: EdgeInsets.only(left: 25,top: 20),
                  child: Row(
                    children: [
                      Text("Game start time",style: TextStyle(color: Colors.white,fontSize: 20),),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Container(
                          width: 50,
                          child: TextField(
                            controller: TextEditingController(),
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
                  padding: EdgeInsets.only(left: 25,top: 20),
                  child: Row(
                    children: [
                      Text("Game end time",style: TextStyle(color: Colors.white,fontSize: 20),),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Container(
                          width: 50,
                          child: TextField(
                            controller: TextEditingController(),
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
                    onPressed: ()=>{
                    },
                  ),
                )
              ],
            ),

          ),
        ),
      ),
    );
  }
}
