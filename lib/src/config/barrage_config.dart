import 'package:flutter/material.dart';

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

  ///Barrage moves double speed, default is 1.
  static double barrageRate = 1.0;

  static late Function() barrageTapCallBack;
}
