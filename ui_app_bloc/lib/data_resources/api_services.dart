import 'package:http/http.dart' as http;
import 'package:ui_app/data_resources/api_url.dart';
import 'package:ui_app/pages/popular_cast/popular_movie_cast.dart';
import 'package:ui_app/pages/popular_movies/popular_movie.dart';
import 'dart:convert' show json;

import 'package:ui_app/resources/string.dart';

class ApiServices {

  fetchAllPopularMovies() async{

    List<PopularMovieModel> popularMoviesList = [];
    var response = await http.get(ApiUrls().popularMovieApiUrl());
    if (response.statusCode == 200)
    {
      var body = json.decode(response.body);
      List listJson = body['results'];
      for(int i = 0; i < listJson.length ; i++ )
      {
        PopularMovieModel movieModel = PopularMovieModel.fromJson(listJson[i]);
        popularMoviesList.add(movieModel);
      }

    }
    else throw Exception(errorFromApi);

    return popularMoviesList;
  }


  fetchMovieCast(movieId) async {

    List<PopularMovieCastModel> popularMoviesCastList = [];
    var fullVideoUrl = ApiUrls().movieCastUrl(movieId);

    var response = await http.get(fullVideoUrl);


    if (response.statusCode == 200)
    {
      var body = json.decode(response.body);
      List listJson = body['cast'];
      for(int i = 0; i < listJson.length ; i++ )
      {
        if (listJson[i]['profile_path'] != null) {
          PopularMovieCastModel castModel = PopularMovieCastModel.fromJson(listJson[i]);
          popularMoviesCastList.add(castModel);
        }


      }

    }
    else throw Exception(errorFromApi);

    return popularMoviesCastList;
  }
}