import 'package:flutter/material.dart';
import 'package:flutter_barrage_craft/src/config/barrage_config.dart';
import 'package:flutter_barrage_craft/src/model/barrage_model.dart';
import 'package:flutter_barrage_craft/src/model/track_model.dart';

class BarrageUtils {
  ///Calculate the width and height of the barrage.
  static Size getBarrageSize() {
    return const Size(0, 0);
  }

  ///Calculate how far each frame needs to run based on the length of the barrage.
  static double getBarrageEveryFrameRateRunDistance(double barrageWidth) {
    assert(barrageWidth > 0);
    return barrageWidth / BarrageConfig.everyFrameRateRunDistanceScale;
  }

  ///Calculates whether the track overflows relative to the available area
  static bool isEnableTrackOverflowArea(BarrageTrack track) =>
      track.offsetTop + track.trackHeight > BarrageConfig.areaSize.height;

  ///How many frames are left of the barrage leaving the screen.
  static double remainderTimeLeaveScreen(
      double runDistance, double textWidth, double everyFrameRateDistance) {
    assert(runDistance >= 0);
    assert(textWidth >= 0);
    assert(everyFrameRateDistance > 0);
    double remainderDistance =
        (BarrageConfig.areaSize.width + textWidth) - runDistance;
    return remainderDistance / everyFrameRateDistance;
  }

  /// Whether there is room for the barrage to be inserted
  static hasInsertOffsetSpaceComputed(
      BarrageModel trackLastBarrage, double willInsertBarrageRunDistance) {
    return (trackLastBarrage.runDistance - trackLastBarrage.barrageSize.width) >
        willInsertBarrageRunDistance;
  }

  ///Whether the injection barrage will collide
  static bool trackInsertBarrageHashmap() {
    return false;
  }
}
