import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:motivate/core/models/pexels_photo_model.dart';
import 'package:motivate/core/providers.dart';
import 'package:motivate/utils/margin.dart';
import 'package:motivate/utils/theme.dart';

class PhotoDetail extends HookWidget {
  final Photos photo;
  final int id;

  PhotoDetail(this.photo, this.id);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MotivateContent(photo, id),
    );
  }
}

class MotivateContent extends HookWidget {
  final Photos photo;
  final int id;

  const MotivateContent(this.photo, this.id);

  @override
  Widget build(BuildContext context) {
    var provider = useProvider(motivateVM);
    return GestureDetector(
      onDoubleTap: () {
        Navigator.pop(context);
      },
      child: Stack(
        children: [
          Center(
            child: Hero(
              tag: photo.id,
              child: Container(
                width: context.screenWidth(),
                height: context.screenHeight(),
                decoration: BoxDecoration(
                  color: grey,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(photo?.src?.large),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: context.screenWidth(),
              height: context.screenHeight(),
              decoration: BoxDecoration(
                color: black.withOpacity(0.2),
              ),
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '${DateTime.now().day}',
                        style: GoogleFonts.montserrat(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: white),
                      ),
                      const XMargin(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${DateFormat('EEEE').format(DateTime.now())}',
                            style: GoogleFonts.montserrat(
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                                color: white),
                          ),
                          const YMargin(5),
                          Text(
                            '${DateFormat('MMMM y').format(DateTime.now())}',
                            style: GoogleFonts.montserrat(
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                                color: white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  ClipRRect(
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.06)),
                          padding: EdgeInsets.all(14),
                          child: Text(
                            provider.motivations[id],
                            style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1.2,
                                color: white),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
