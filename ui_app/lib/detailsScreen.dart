
import 'dart:html';
import 'dart:js';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_app/pages/image_model.dart';
class DetailsScreen extends StatefulWidget {

  final ImageModel videoModel;

  const DetailsScreen({Key key, @required this.videoModel}) : super(key: key);
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // cho phép phần thân nằm ở lớp phía dưới của AppBar
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            "image1.jpg",
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white.withOpacity(0.8),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
               // imageWidget(widget.videoModel),
                titleWidget(widget.videoModel),
               // descriptionWidget(widget.videoModel)
              ],
            ),
          ),
        ],
      ),
    );
  }


  // imageWidget(VideoModel videoModel){
  //
  //   return Image.network(videoModel.url_photo, fit: BoxFit.cover,);
  // }
  titleWidget(ImageModel imageModel){
    return Text(imageModel.title);
  }

  // descriptionWidget(VideoModel videoModel){
  //   print("videoModel.title");
  //   return Text(videoModel.release_date);
  //
  // }

}
