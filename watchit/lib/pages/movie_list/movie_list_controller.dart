import 'dart:async';

import 'package:watchit/data/models/movie.dart';
import 'package:watchit/data/movie_api.dart';
import 'package:watchit/service_locator.dart';

class MovieListController {
  final api = getIt<MovieApi>();

  final _controller = StreamController<List<Movie>>();
  Stream<List<Movie>> get stream => _controller.stream;

  void init() {
    getMovies();
  }

  Future<void> getMovies() async {
    var result = await api.getMovies();
    _controller.sink.add(result);
  }
}