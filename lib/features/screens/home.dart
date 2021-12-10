import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/features/providers/providers.dart';
import 'package:movie_app/features/screens/single_movie_page.dart';
import '../models/movie_model/movie.dart';

final movieIdProvider = StateProvider((_) => '');

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(futureMoviesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Please Work'),
      ),
      body: movies.when(
        data: (movies) => GridView.extent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 200,
          childAspectRatio: 0.7,
          children: movies
              .map((movie) => Moviebox(movie: movie))
              .toList(growable: false),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => throw (error),
      ),
    );
  }
}

class Moviebox extends ConsumerWidget {
  final Movie movie;
  const Moviebox({
    required this.movie,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialButton(
      onPressed: () {
        ref.read(movieIdProvider.state).state = movie.id;
        print('clicked!');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MoviePage(),
            ));
        print(ref.watch(movieIdProvider.state).state);
      },
      child: Stack(
        children: [
          Image.network(movie.fullImageUrl),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
            child: Stack(
              children: [
                Container(
                  child: const SizedBox(height: 60, width: 200),
                  color: Colors.grey,
                ),
                Center(child: Text(movie.title)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
