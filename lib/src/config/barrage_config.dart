import 'package:flutter/material.dart';

import '../model/barrage_model.dart';

class BarrageConfig {
  ///Barrage frame rate.
  static int frameRate = 60;

  ///The time required per frame rate.
  static int unitTimer = 1000 ~/ frameRate;

  ///The distance the barrage moves in unit frame rate.
  static int everyFrameRateRunDistanceScale = 150;

  ///This barrage is not suspended
  static bool pause = false;

  ///The area shown by the barrage.
  static Size areaSize = const Size(0, 0);

  ///Multiple of barrage movement speed, default is 1.
  static double barrageRate = 1.0;

  ///Barrage click event.
  static late Function(BarrageModel) barrageTapCallBack;

  ///Double click event of the bullet screen.
  static late Function(BarrageModel) barrageDoubleTapCallBack;

  ///Single barrage removes screen
  static Function(BarrageModel)? singleBarrageRemoveScreenCallBack;

  ///All barrages removes screen
  static Function(BarrageModel)? allBarragesRemoveScreenCallBack;

  ///Single barrage all show screen
  static Function(BarrageModel)? singleBarrageShowScreenCallBack;
}
