import 'package:flutter/material.dart';
import 'package:mugu/editProfile.dart';
import 'package:mugu/homePage.dart';

class userPage extends StatefulWidget {
  const userPage({Key? key}) : super(key: key);

  @override
  _userPageState createState() => _userPageState();
}

class _userPageState extends State<userPage> {
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
                  Image(image: AssetImage('assets/LS.png'),height: 50,width: 50,),
                  Text('Arogen',style: TextStyle(color: Colors.white,fontSize: 50),),
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
              child: Text('Ｐｉｕｓ#2107',style: TextStyle(color: Colors.grey,fontSize: 18),),
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
                      Text('Epic gamer gaming',
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
                      Text('HR: 69',style: TextStyle(color: Colors.white,fontSize: 18),),
                      Text('Gameplay preferences: for fun',style: TextStyle(color: Colors.white,fontSize: 18),),
                      Text('Online time: 12-18',style: TextStyle(color: Colors.white,fontSize: 18),),
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
}
