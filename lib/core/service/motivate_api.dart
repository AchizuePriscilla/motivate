import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'url.dart';

class MotivateApi {
  Future<Either<Exception, String>> getNatureImages(int number) async {
    try {
      var headers = {
        'Authorization': 'Bearer Your Token',
      };

      final response = await http.get(
        APIUrl.search(page: number),
        headers: headers,
      );

      return Right(response.body);
    } catch (e) {
      return (Left(e));
    }
  }
