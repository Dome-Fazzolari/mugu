import 'package:flutter/material.dart';
import 'package:mugu/homePage.dart';

class login extends StatelessWidget {
  const  login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mailController = TextEditingController();
    final passwordController = TextEditingController();

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
                TextButton(
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
                    onPressed: ()=>{
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>const homePage())
                      )
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
