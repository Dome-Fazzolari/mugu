import 'package:flutter/material.dart';
import 'package:mugu/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'serverRequests.dart' as sr;

class login extends StatefulWidget {
  const  login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    bool isLoginButtonLoading = false;
    final mailController = TextEditingController(text: 'domenicofazzolari03@gmail.com');
    final passwordController = TextEditingController(text: 'password');
    return Container(
        constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/sfondo.png'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
          body:  SingleChildScrollView(
            physics:NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top:75.0,bottom: 100.0),
                  child: Image.asset('assets/logoIniziale.png'),
                ),
                Container(
                  width: 300,
                  child: TextField(
                    controller: mailController,
                    style: TextStyle(color: Colors.white,fontSize: 18),
                    decoration:  const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Insert email',
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.grey)
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: 300,
                  child: TextField(
                    controller: passwordController,
                    style: TextStyle(color: Colors.white,fontSize: 18),
                    decoration:  const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Insert password',
                        labelStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.grey)
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                isLoginButtonLoading
                ?CircularProgressIndicator()
                    :TextButton(
                    child: Container(
                      width: 250,
                      child: Center(
                        child: Icon(Icons.login),
                      ),
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.blueAccent,
                    ),
                    onPressed: () async {
                      Future.delayed(Duration.zero,()async{
                        if(mailController.text.isNotEmpty || passwordController.text.isNotEmpty){
                          var map = await sr.login(
                              mailController.text, passwordController.text,
                              '192.168.1.74');
                          if (map['status']?.compareTo('success') == 0) {
                            var prefs = await SharedPreferences.getInstance();
                            String cookie = map['cookie'] ?? '';
                            prefs.setString('PHPSESSID', cookie);
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                                    builder: (context) => const homePage())
                            );
                          } else {
                            String status = map['status'] ?? 'Error';
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return  AlertDialog(
                                    title: Text(status),
                                    content: Text(map[status] ?? 'An uninidentified error occourred'),
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
                                      "You have to insert both email and password"),
                                );
                              });
                        }
                      });

                    },
                  ),
                TextButton(
                  onPressed: ()=>{},
                  child: Text("Forgot my password",style: TextStyle(color: Colors.white),),
                )
              ],
            ),
          ),
          )
            );
  }
}
