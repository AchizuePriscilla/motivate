import 'dart:math';

class APIUrl {
  static const String base = 'https://api.pexels.com';
  static const String baseUrl = '$base/v1';

  //Search API
  static String search({query, int page: 0}) =>
      '$baseUrl/search?query=$query&per_page=$page&page=${DateTime.now().day + Random().nextInt(10)}';
}
