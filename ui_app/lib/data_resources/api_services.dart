import 'package:ui_app/pages/image_model.dart';
import 'package:http/http.dart' as http;
import 'package:ui_app/data_resources/api_url.dart';
import 'dart:convert' show json;

import 'package:ui_app/resources/string.dart';

class ApiServices {


  getImageList() async {
    List<ImageModel> imageList = [];
    var fullImageUrl = ApiUrls().imageApiUrl;

    var response = await http.get(fullImageUrl);

    if(response.statusCode == 200){

      var body = json.decode(response.body);
      List listJson = body['list'];
      print("here");
      for(int i = 0; i < listJson.length ; i++ )
      {
        print("here");
        ImageModel imageModel = ImageModel.fromJson(listJson[i]);
        print("Độ dài:" + imageList.length.toString());
        imageList.add(imageModel);

      }


    }
    else throw Exception(errorFromApi);
    return imageList;
  }

}