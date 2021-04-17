import 'package:rxdart/rxdart.dart';
import 'package:ui_app/data_resources/repository.dart';
import 'package:ui_app/pages/popular_movies/popular_movie.dart';

class PopularBloc {
  final _repository = Repository();
// Tạo Stream, sử dụng PublishSubject
  final _popularFetcher = PublishSubject<List<PopularMovie>>();

// nhúng data vào Stream
  fetchAllMovies() async {
    List<PopularMovie> popularList = await _repository.fetchAllVideo();
    _popularFetcher.sink.add(popularList);
  }
  // Lấy Stream
  Stream<List<PopularMovie>> get allVideos => _popularFetcher.stream;
  // Đóng Stream
  dispose(){
    _popularFetcher.close();
  }
}


