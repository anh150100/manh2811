import 'package:http/http.dart' as http;
import 'package:ui_app/data_resources/api_url.dart';
import 'package:ui_app/pages/popular_cast/popular_movie_cast.dart';
import 'package:ui_app/pages/popular_movies/popular_movie.dart';
import 'dart:convert' show json;

import 'package:ui_app/resources/string.dart';

class ApiServices {
  getPopularList() async {
    List<PopularMovie> popularList = [];
    var fullPopularUrl = ApiUrls().popularApiUrl;

    var response = await http.get(fullPopularUrl);

    if(response.statusCode == 200){

      var body = json.decode(response.body);
      List listJson = body['results'];
      for(int i = 0; i < listJson.length ; i++ )
      {
      //  print("here");
        var json = listJson[i];
        PopularMovie popularModel = PopularMovie.fromJson(json);
      //  print("Độ dài:" + imageList.length.toString());
        popularList.add(popularModel);
      }


    }
    else throw Exception(errorFromApi);
    return popularList;
  }


  getPopularCastList(movieId) async {
    List<PopularMovieCast> popularCastList = [];
    var fullPopularCastUrl = ApiUrls().movieCastUrl(movieId);

    var response = await http.get(fullPopularCastUrl);

    if(response.statusCode == 200){

      var body = json.decode(response.body);
      List listJson = body['cast'];
      for(int i = 0; i < listJson.length ; i++ )
      {
       // print("here");
        if (listJson[i]['profile_path'] != null){
          var json = listJson[i];
        PopularMovieCast castModel = PopularMovieCast.fromJson(json);
       // print("Độ dài:" + popularCastList.length.toString());
        popularCastList.add(castModel);}
      }

    }
    else throw Exception(errorFromApi);
    return popularCastList;
  }

}