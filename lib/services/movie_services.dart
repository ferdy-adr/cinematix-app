part of 'services.dart';

class MovieServices {
  static Future<List<Movie>> getMovies(int page, {http.Client? client}) async {
    var apiURI = Uri.https('api.themoviedb.org', '/3/discover/movie', {
      'api_key': apiKey,
      'language': 'en-US',
      'sort_by': 'popularity.desc',
      'include_adult': 'false',
      'include_video': 'false',
      'page': page.toString(),
      'with_watch_monetization_types': 'flatrate'
    });

    client ??= http.Client();

    http.Response response = await client.get(apiURI);

    if (response.statusCode != 200) {
      return [];
    } else {
      var data = json.decode(response.body);
      List listData = data['results'];

      return listData.map((e) => Movie.fromJson(e)).toList();
    }
  }

  static Future<MovieDetail> getDetails(Movie movie,
      {http.Client? client}) async {
    String apiURL =
        'https://api.themoviedb.org/3/movie/${movie.id}?api_key=$apiKey&language=en-US';

    client ??= http.Client();

    http.Response response = await client.get(Uri.parse(apiURL));

    var data = json.decode(response.body);

    List<String> genres = ((data as Map<String, dynamic>)['genres'] as List)
        .map((e) => (e as Map<String, dynamic>)['name'].toString())
        .take(8)
        .toList();
    String language = '';

    switch (data['original_language']) {
      case 'en':
        language = 'English';
        break;
      case 'id':
        language = 'Indonesian';
        break;
      case 'ja':
        language = 'Japanese';
        break;
      case 'ko':
        language = 'Korean';
        break;
      default:
    }

    return MovieDetail(movie, genres: genres, language: language);
  }

  static Future<List<Credit>> getCredits(int movieId,
      {http.Client? client}) async {
    String apiURL =
        'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey&language=en-US';

    client ??= http.Client();

    http.Response response = await client.get(Uri.parse(apiURL));

    var jsonResult = json.decode(response.body);
    List<Map<String, dynamic>> data = jsonResult['cast'];

    return data
        .map((e) => Credit(name: e['name'], profilePath: e['profile_path']))
        .toList();
  }
}
