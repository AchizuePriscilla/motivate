import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:motivate/core/models/glitch/glitch.dart';
import 'package:motivate/core/models/glitch/no_Internet_glitch.dart';
import 'package:motivate/core/models/pexels_photo_model.dart';
import 'package:motivate/core/service/motivate_api.dart';

class MotivateHelper {
  final api = MotivateApi();
  Future<Either<Glitch, PexelsPhotoModel>> getRandomPhotos(
      {int number = 0}) async {
    final apiResult = await api.getNatureImages(number);

    return (await fold(apiResult)).fold(
      (l) => Left(l),
      (r) {
        print(r);
        return Right(PexelsPhotoModel.fromJson(json.decode(r)));
      },
    );
  }

  FutureOr<Either<Glitch, String>> fold(Either<Exception, String> apiResult) {
    return apiResult.fold((l) {
      print(l.toString());
      return Left(NoInternetGlitch());
    }, (r) {
      return Right(r);
    });
  }
}
