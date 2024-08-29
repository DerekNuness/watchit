import 'package:dio/dio.dart';
import 'package:watchit/data/models/movie.dart';

class MovieApi {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: 'https://apifilmes.webevolui.com')
  );

  Future<List<Movie>> getMovies({int skip=0, take=20}) async {
    var response = await _dio.get('/Filme?skip$skip&take=$take');

    return (response.data as List).map((item) => Movie.fromJson(item)).toList();
  }

  Future<Movie> getMovie(int id) async {
    var response = await _dio.get('/Filme/$id');

    return Movie.fromJson(response.data);
  }
}