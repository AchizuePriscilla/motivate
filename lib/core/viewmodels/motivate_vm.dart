import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:motivate/core/consts/strings.dart';
import 'package:motivate/core/helper/motivate_helper.dart';
import 'package:motivate/core/models/glitch/no_Internet_glitch.dart';
import 'package:motivate/core/models/pexels_photo_model.dart';

class MotivateViewModel extends ChangeNotifier {
  final controller = PageController();

  double _pageOffset = 0;
  double get pageOffset => _pageOffset;

  List<String> _motivations = [];
  List<String> get motivations => _motivations;

  PexelsPhotoModel _pexelsPhotoModel;
  PexelsPhotoModel get pexelsPhotoModel => _pexelsPhotoModel;

  set pexelsPhotoModel(PexelsPhotoModel val) {
    _pexelsPhotoModel = val;
    notifyListeners();
  }

  set motivations(val) {
    _motivations = val;
    notifyListeners();
  }

  set pageOffset(double val) {
    _pageOffset = val;
    notifyListeners();
  }

  Future<void> loadData() async {
    final photos = await MotivateHelper().getRandomPhotos(number: 6);
    photos.fold((l) {
      if (l is NoInternetGlitch) {
        print(l.toString());
      }
    }, (r) {
      List<String> temp = [];
      temp.addAll(affirmations);
      temp.shuffle();
      _motivations = temp.sublist(0, r?.photos?.length ?? 0);
      _pexelsPhotoModel = r;
    });

    notifyListeners();
  }

  void refresh() => loadData();

  @override
  void dispose() {
    super.dispose();
  }
}
