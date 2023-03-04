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
}
