

import 'package:rxdart/rxdart.dart';
import 'package:ui_app/data_resources/repository.dart';
import 'package:ui_app/pages/popular_movies/popular_movie.dart';


class PopularBloc {
  final _repository = Repository();

  // Tạo Stream
  final videoSubject = PublishSubject<List<PopularMovieModel>>();

  // nhúng data từ Data Layer vào Stream
  fetchAllMovies () async {
    List<PopularMovieModel> videoList = await _repository.fetchAllMovies();
    videoSubject.sink.add(videoList);
  }

  // xuất Stream
  Stream<List<PopularMovieModel>> get allMovie => videoSubject.stream;

  // dispose Bloc
  dispose() {
    videoSubject.close();
  }
}
