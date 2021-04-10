import 'dart:html';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:ui_app/data_resources/api_services.dart';
import 'package:ui_app/pages/image_model.dart';

import 'detailsScreen.dart';




class PopularView extends StatefulWidget {
  @override
  _PopularViewState createState() => _PopularViewState();
}




class _PopularViewState extends State<PopularView> {

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  body:Container(
  child: FutureBuilder(
  future: ApiServices().getImageList(),
  builder: (context, snapshot){
  if((snapshot.hasError)||(!snapshot.hasData))
  return Center(
  child: Text("Loading.."),
  );
  List<ImageModel> imageList = snapshot.data;
  return GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,
  crossAxisSpacing: 8.0,
  mainAxisSpacing: 8.0),
  itemBuilder: (context, index){
  return GestureDetector(
    // child: Container(
    //   color: Colors.blue,
    // ),
    child: Text(
  imageList[index].title,
  ),
  onTap: (){
  var route = MaterialPageRoute(builder: (context)
  => DetailsScreen(videoModel: imageList[index],));
  Navigator.push(context, route);
  },
  );

  });

  }),
  ) ,
  );
  }
  }






