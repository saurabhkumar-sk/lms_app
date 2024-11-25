import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/components/skeleton copy.dart';

class IntroLoginBackgroundWrapper extends StatelessWidget {
  const IntroLoginBackgroundWrapper({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return _IntroLoginBody(
      image: const AssetImage('assets/female-student-choosing-course-distance-learn.jpg'),
    );
  }
}

class _IntroLoginBody extends StatelessWidget {
  const _IntroLoginBody({
    required this.image,
  });

  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // This is the image that will be blurred
        Image(
          image: image,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        // This is the BackdropFilter that applies the blur effect
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent, // This is important!
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black12.withOpacity(0.1),
                  Colors.black12,
                  Colors.black54,
                  Colors.black54,
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}