part of 'shared.dart';

String apiKey = tmdbKeyAPI;
String baseURL = '';
String imageBaseURL = 'https://image.tmdb.org/t/p';

PageEvent? prevPageEvent;

Map<String, dynamic> imageFileToUpload = {'uid': null, 'profilePicture': null};
