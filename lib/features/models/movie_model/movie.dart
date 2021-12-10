import 'dart:convert';

class Movie {
  final String title;
  final String posterpath;
  final String overview;
  final dynamic id;
  String get fullImageUrl => 'https://image.tmdb.org/t/p/w200$posterpath';
  Movie(
    this.title,
    this.posterpath,
    this.overview,
    this.id,
  );

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'overview': overview,
      'poster_path': posterpath,
      'id': id,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      map['title'],
      map['poster_path'],
      map['overview'],
      map['id'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));
}
