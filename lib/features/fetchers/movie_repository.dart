import 'package:dio/dio.dart';
import 'package:movie_app/environment_config.dart';
import 'package:movie_app/features/models/movie_model/movie.dart';

class MovieRepository {
  final Dio dio;
  final EnvironmentConfig config;
  final String id;
  MovieRepository({
    required this.id,
    required this.dio,
    required this.config,
  });
  Future<Movie> getMovie() async {
    try {
      final response = await dio.get(
          'https://api.themoviedb.org/3/movie/$id?api_key=a863e7e8d16656b0365ee6d93cff8307');
      final result = Map<String, dynamic>.from(response.data);
      final movie = Movie.fromMap(result);
      return movie;
    } on DioError {
      rethrow;
    }
  }
}
