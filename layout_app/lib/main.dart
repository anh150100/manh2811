import 'dart:html';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

void main() {
  // String value = "";
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Raleway'
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Column(
          children: [
            // image widget
            image(),
            //title widget
            title(),
            //buttons widget
            button(),
            //description widget
            description(
                text: 'Lake Oeschinen lies at the foot of the Bluemlisalp in the Bernese '
                    'Alps, Situated 1,578 meter above sea level, it is one of the '
                    'larger Alpine Lakers.A gondola ride from Kandersteg, followed by a '
                    'half-hour walk through pastures and pine in the summer. Activities '
                    'enjoyed here include rowing, and riding the summer toboggan run.'
            ),
          ],
        ),
      );



  }


    Widget image(){
    return Image.asset(
      "lake.jpg",
      fit: BoxFit.cover,
      height: MediaQuery.of(context).size.height/2.5,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget title(){
    return Container(
      padding: EdgeInsets.only(top: 40,bottom: 40,left: 30,right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // text column
          Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Oeschinen Lake Campground",style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("Kandersteg, Switzerland",style: TextStyle(color: Colors.black26),),
                ],
              ),
          ),
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.star, color: Colors.red,),
                  Text("41"),
                ],
              ),
          ),
        ],
      ),
    );
  }

 Widget button() {
   return Container(
     child: Row(
       children:<Widget> [
         Expanded(
           flex: 1,
           child:
            buttonItemWidget(
             icon: Icons.call,
             title: "CALL",
             color: Colors.blue,
           ),
         ),
         Expanded(
           flex: 1,
           child: buttonItemWidget(
               icon: Icons.call,
               title: "CALL",
               color: Colors.blue,
             ),
         ),
         Expanded(
           flex: 1,
           child: buttonItemWidget(
               icon: Icons.share,
               title: "SHARE",
               color: Colors.blue,
              ),
         ),
       ],
     ),
   );
 }

 buttonItemWidget({@required icon, @required title, @required color, @required function}){
    return GestureDetector(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color,),
            SizedBox(height: 10,),
            Text(title,style: TextStyle(color: color),),
          ],
        ),
      ),
      onTap: function,
    );
 }

  Widget description({@required text}){
    return Container(
      padding: EdgeInsets.only(left: 30,top: 40),
      child: Text(text, softWrap: true,),
    );
  }

}






