import 'dart:async';

import 'package:watchit/data/models/movie.dart';
import 'package:watchit/data/movie_api.dart';
import 'package:watchit/service_locator.dart';

class MovieDetailController {
  final api = getIt<MovieApi>();

  final _controller = StreamController<Movie>();
  Stream<Movie> get stream => _controller.stream;
  late Movie _movie;

  void init(Movie movie) {
    _movie = movie;
    getMovie();
  }

  Future<void> getMovie() async {
    var result = await api.getMovie(_movie.id);
    _controller.sink.add(result);
  }
}