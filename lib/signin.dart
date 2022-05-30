import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:mugu/first_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'serverRequests.dart'as sr;

class signin extends StatefulWidget {
  const signin({Key? key}) : super(key: key);

  @override
  _signinState createState() => _signinState();
}

class _signinState extends State<signin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF000F2C),
      body: FlowBuilder<user>(
        state: const user(),
        onGeneratePages: (utente,pages){
          return [
            MaterialPage(child: credentialsForm()),
            if(utente.username != null)   MaterialPage(child: first_preferences()),
          ];
        }
      ),
    );
  }
}

class credentialsForm extends StatefulWidget {
  const credentialsForm({Key? key}) : super(key: key);

  @override
  _credentialsFormState createState() => _credentialsFormState();
}

class _credentialsFormState extends State<credentialsForm> {
  @override
  Widget build(BuildContext context) {

    var usernameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Color(0XFF000F2C),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 100,bottom: 20.0),
                  child: Text('Register',
                    style: TextStyle(color: Colors.white,fontSize: 40),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20,right: 10),
                      child: Icon(Icons.account_box,color: Colors.white,),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom:20),
                      child: Container(
                        width: 300,
                        child: TextField(
                          controller: usernameController,
                          style: TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )
                              ),
                              labelText: 'Username',
                              hintText: '  insert username',
                              labelStyle: TextStyle(color: Colors.white),
                              hintStyle: TextStyle(color: Colors.grey)
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 20,right: 10),
                      child: Icon(Icons.email,color: Colors.white,),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Container(
                        width: 300,
                        child: TextField(
                          controller: emailController,
                          style: TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )
                              ),
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.white),
                              hintText: '  example@mail.com',
                              hintStyle: TextStyle(color: Colors.grey)
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 20,right: 10),
                        child: Icon(Icons.key,color: Colors.white,)
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Container(
                        width: 300,
                        child: TextField(
                          obscureText: true,
                          controller: passwordController,
                          style: TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )
                              ),
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.white),
                              hintText: '  insert password',
                              hintStyle: TextStyle(color: Colors.grey),
                              focusColor: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  child: Container(
                    width: 250,
                    child: Center(
                      child: Text("CONTINUE"),
                    ),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blueAccent,
                  ),
                  onPressed: () async {
                    if(
                      emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty &&
                      usernameController.text.isNotEmpty
                    ){
                      var signinresult = await sr.signin(
                          emailController.text,
                          passwordController.text,
                          usernameController.text,
                          '192.168.1.74'
                      );
                      if(signinresult['status'].toString().compareTo('success') == 0){
                        var prefs = await SharedPreferences.getInstance();
                        prefs.setString('username', usernameController.text);
                        prefs.setString('user_id', signinresult['user_id'].toString());
                        prefs.setString('cookie', signinresult['cookie']);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>const first_preferences())
                        );
                      }else{
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(signinresult['status'] ?? ''),
                                content: Text(signinresult[signinresult['status']] ?? ''),
                              );
                            });
                      }

                    }else{
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              title: Text("Error"),
                              content: Text(
                                  "Insert your SignIn info"),
                            );
                          });
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class user {
  final String? username;
  final String? bio;
  final String? discord;
  final String? arma_preferita;
  final String? preferenza_caccia;
  final String? orario_libero_inizio;
  final String? orario_libero_fine;
  final String? HR;
  final String? piattaforma;

  const user({this.username, this.bio, this.discord, this.arma_preferita, this.preferenza_caccia, this.orario_libero_inizio, this.orario_libero_fine, this.HR, this.piattaforma});

 user CopyWith({
      String? username,
      String? bio,
      String? discord,
      String? arma_preferita,
      String? preferenza_caccia,
      String? orario_libero_inizio,
      String? orario_libero_fine,
      String? HR,
      String? piattaforma,}
     ){
   return user(
     username : username ?? this.username,
     bio : bio ?? this.bio,
     discord : discord ?? this.discord,
     arma_preferita : arma_preferita ?? this.arma_preferita,
     preferenza_caccia : preferenza_caccia ?? this.preferenza_caccia,
     orario_libero_inizio : orario_libero_inizio ?? this.orario_libero_inizio,
     orario_libero_fine : orario_libero_fine ?? this.orario_libero_fine,
     HR : HR ?? this.HR,
     piattaforma : piattaforma ?? this.piattaforma,
   );
 }
}
