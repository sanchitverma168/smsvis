import 'package:Smsvis/utils/colors.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

Animatable<Color> backgroundOnQuickSendSmsPageHelp = TweenSequence<Color>(
  [
    TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(begin: Colors.orange, end: Colors.orangeAccent)),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Colors.orangeAccent, end: UIColors.orange),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween:
          ColorTween(begin: UIColors.orange, end: UIColors.orangeAvant_Grade),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
          begin: UIColors.orangeAvant_Grade, end: UIColors.orangeBurst),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
          begin: UIColors.orangeBurst, end: UIColors.orangeBellPepper),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
          begin: UIColors.orangeBellPepper, end: UIColors.orangeCrush),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: UIColors.orangeCrush, end: UIColors.orangeDrop),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween:
          ColorTween(begin: UIColors.orangeDrop, end: UIColors.orangeGluttony),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
          begin: UIColors.orangeGluttony, end: UIColors.orangeDelight),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween:
          ColorTween(begin: UIColors.orangeDelight, end: UIColors.orangeDanger),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween:
          ColorTween(begin: UIColors.orangeDanger, end: UIColors.orangeJelly),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: UIColors.orangeJelly, end: Colors.orange),
    ),
  ],
);
