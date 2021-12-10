import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/features/providers/providers.dart';

class MoviePage extends ConsumerWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movie = ref.watch(futureMovieProvider);
    return Scaffold(
      appBar: AppBar(),
      body: movie.when(
          data: (movie) => Center(
                child: Text(movie.title),
              ),
          error: (e, s) => throw (e),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
    );
  }
}
