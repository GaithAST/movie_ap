import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/environment_config.dart';
import 'package:movie_app/features/fetchers/movie_repository.dart';
import 'package:movie_app/features/fetchers/popular_movies_getter.dart';
import 'package:movie_app/features/models/movie_model/movie.dart';
import 'package:movie_app/features/screens/home.dart';

Dio _dio = Dio();

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  final config = ref.read(environmentConfigProvider);
  final movieId = ref.read(movieIdProvider);
  return MovieRepository(id: movieId, dio: _dio, config: config);
});

final movieServiceProvider = Provider<MovieService>((ref) {
  final config = ref.watch(environmentConfigProvider);
  return MovieService(dio: _dio, config: config);
});

final futureMovieProvider = FutureProvider<Movie>((ref) async {
  final movieservice = ref.watch(movieRepositoryProvider);
  final movie = await movieservice.getMovie();
  return movie;
});

final futureMoviesProvider =
    FutureProvider.autoDispose<List<Movie>>((ref) async {
  ref.maintainState = true;
  final movieservice = ref.read(movieServiceProvider);
  final movies = await movieservice.getMovies();
  return movies;
});
