import 'package:flutter/material.dart';
import 'package:mugu/login.dart';
import 'package:mugu/signin.dart';

class welcome extends StatelessWidget {
  const welcome({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: _welcome(),
    );
  }
}
class _welcome extends StatefulWidget {
  const _welcome({Key? key}) : super(key: key);

  @override
  State<_welcome> createState() => _welcomeState();
}

class _welcomeState extends State<_welcome> {


  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/sfondo.png'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
          body:
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top:75.0),
                  child: Image.asset('assets/logoIniziale.png'),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 200.0),
                    child: TextButton(
                      child: Container(
                        width: 250,
                        child: Text("LOG IN",textAlign: TextAlign.center,),
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: (){
                        Navigator.push(context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const login(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero
                        ));
                      },
                    )
                ),
                TextButton(
                  onPressed: ()=>{
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>const signin())
                    )

                  },
                  child: Text("New user? Sign In",style: TextStyle(color: Colors.white),),
                )
              ],
            ),

      ),
    );
  }


}





