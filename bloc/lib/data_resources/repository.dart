
import 'package:ui_app/data_resources/api_services.dart';
import 'package:ui_app/pages/popular_movies/popular_movie.dart';


class Repository {
  final ApiServices apiServices = ApiServices();
  Future<List<PopularMovie>> fetchAllVideo() => apiServices.getPopularList();
}