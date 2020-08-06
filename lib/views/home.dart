import 'dart:math' as math;
import 'dart:ui';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:motivate/core/models/pexels_photo_model.dart';
import 'package:motivate/core/providers.dart';
import 'package:motivate/utils/margin.dart';
import 'package:motivate/utils/navigator.dart';
import 'package:motivate/utils/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'details.dart';

class Home extends StatefulHookWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AfterLayoutMixin {
  @override
  void afterFirstLayout(BuildContext context) {
    var provider = motivateVM.read(context);
    provider.loadData();
    provider.controller.addListener(() {
      provider.pageOffset =
          provider.controller.page; //<-- add listener and set state
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = useProvider(motivateVM);
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: Row(
                children: [
                  Text(
                    'MOTIVATE',
                    style: GoogleFonts.raleway(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Colors.black),
                  ),
                  Spacer(),
                  IconButton(icon: Icon(LineIcons.share_alt), onPressed: () {})
                ],
              ),
            ),
            Container(
              height: context.screenHeight(0.76),
              child: PageView.builder(
                itemCount: provider?.pexelsPhotoModel?.photos?.length ?? 0,
                physics: BouncingScrollPhysics(),
                controller: provider.controller,
                itemBuilder: (context, i) {
                  return MotivateCard(provider?.pexelsPhotoModel?.photos[i]);
                },
              ),
            ),
            YMargin(context.screenHeight(0.034)),
            Center(
              child: SmoothPageIndicator(
                controller: provider.controller,
                count: provider?.pexelsPhotoModel?.photos?.length ?? 0,
                effect: ExpandingDotsEffect(
                  expansionFactor: 3,
                  activeDotColor: black,
                  dotColor: Colors.grey[300],
                  dotWidth: 10,
                  dotHeight: 3,
                ),
              ),
            ),
            const YMargin(50),
          ],
        ),
      ),
    );
  }
}

class MotivateCard extends HookWidget {
  final Photos photo;
  MotivateCard(this.photo);

  @override
  Widget build(BuildContext context) {
    var provider = useProvider(motivateVM);
    double gauss = math.exp(-(math.pow((provider.pageOffset.abs() - 0.5), 2) /
        0.08)); //<--caluclate Gaussian function
    return Transform.translate(
        offset: Offset(-32 * gauss * provider.pageOffset.sign, 0),
        child: MotivateContent(gauss, photo));
  }
}

class MotivateContent extends HookWidget {
  final Photos photo;
  const MotivateContent(this.offset, this.photo);

  final double offset;

  @override
  Widget build(BuildContext context) {
    var provider = useProvider(motivateVM);
    var id =
        provider.pexelsPhotoModel.photos.indexWhere((_) => _.id == photo.id);

    return Padding(
      padding: const EdgeInsets.all(30),
      child: GestureDetector(
        onTap: () => context.navigate(
          PhotoDetail(photo, id),
          isDialog: true,
        ),
        child: CupertinoContextMenu(
            actions: [
              Text('')
            ], 
                  child: Material(
            color:Colors.transparent,
            child: Stack(
              children: [
                Center(
                  child: Hero(
                    tag: photo.id,
                    child: Container(
                      width: context.screenWidth(),
                      height: context.screenHeight(0.7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: grey,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black38,
                              blurRadius: 34,
                              spreadRadius: -5),
                        ],
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          alignment: Alignment(-offset.abs() * -1, 0),
                          image: NetworkImage(photo?.src?.large),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: context.screenWidth(),
                    height: context.screenHeight(0.7),
                    decoration: BoxDecoration(
                      color: black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Transform.translate(
                          offset: Offset(42 * offset, 0),
                          child: Row(
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
                        ),
                        Spacer(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.06)),
                                padding: EdgeInsets.all(14),
                                child: Transform.translate(
                                  offset: Offset(16 * offset, 0),
                                  child: Text(
                                    provider.motivations[id],
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2,
                                        color: white),
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
