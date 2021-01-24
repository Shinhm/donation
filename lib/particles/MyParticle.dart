import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pimp_my_button/pimp_my_button.dart';

class MyParticle extends Particle {
  @override
  void paint(Canvas canvas, Size size, progress, seed) {
    int randomMirrorOffset = 5000;
    CompositeParticle(children: [
      CircleMirror(
          numberOfParticles: 500,
          child: AnimatedPositionedParticle(
            begin: Offset(0.0, 90.0),
            end: Offset(0.0, 40.0),
            child: FadingCircle(radius: 1.6, color: Color(0xFF5E35B1)),
          ),
          initialRotation: -pi / randomMirrorOffset),
      CircleMirror(
          numberOfParticles: 500,
          child: AnimatedPositionedParticle(
            begin: Offset(0.0, 80.0),
            end: Offset(0.0, 30.0),
            child:
                FadingCircle(radius: 1.3, color: Color(0xFF5E35B1)),
          ),
          initialRotation: -pi / randomMirrorOffset),
      CircleMirror(
          numberOfParticles: 500,
          child: AnimatedPositionedParticle(
            begin: Offset(0.0, 70.0),
            end: Offset(0.0, 20.0),
            child:
                FadingCircle(radius: 1.1, color: Color(0xFF5E35B1)),
          ),
          initialRotation: -pi / randomMirrorOffset),
      CircleMirror(
          numberOfParticles: 500,
          child: AnimatedPositionedParticle(
            begin: Offset(0.0, 60.0),
            end: Offset(0.0, 10.0),
            child:
                FadingCircle(radius: 1.1, color: Color(0xFF5E35B1)),
          ),
          initialRotation: -pi / randomMirrorOffset),
    ]).paint(canvas, size, progress, seed);
  }
}
