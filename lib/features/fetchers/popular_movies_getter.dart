import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/environment_config.dart';
import '../models/movie_model/movie.dart';

class MovieService {
  final Dio dio;
  final EnvironmentConfig config;
  MovieService({
    required this.dio,
    required this.config,
  });
  Future<List<Movie>> getMovies() async {
    try {
      final response = await dio.get(
          'https://api.themoviedb.org/3/movie/popular?api_key=a863e7e8d16656b0365ee6d93cff8307');
      final results = List<Map<String, dynamic>>.from(response.data['results']);
      List<Movie> movies =
          results.map((md) => Movie.fromMap(md)).toList(growable: false);
      return movies;
    } catch (e) {
      throw Text('error LMAO + $e');
    }
  }
}
