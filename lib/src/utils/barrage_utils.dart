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
  static bool hasInsertOffsetSpaceComputed(
      BarrageModel trackLastBarrage, double willInsertBarrageRunDistance) {
    return (trackLastBarrage.runDistance - trackLastBarrage.barrageSize.width) >
        willInsertBarrageRunDistance;
  }

  ///Whether the injection barrage will collide
  static bool trackInsertBarrageHashmap({
    required BarrageModel trackLastBarrage,
    required Size needInsertBarrageSize,
    int offsetMillisecond = 0,
  }) {
    ///The barrage is off the right screen.
    if (!trackLastBarrage.allOutRight) return true;

    ///Need to insert the barrage every frame rate run distance.
    double insertBarrageEveryFrameRateRunDistance =
        BarrageUtils.getBarrageEveryFrameRateRunDistance(
      needInsertBarrageSize.width,
    );
    bool hasInsertOffsetSpace = true;
    double insertBarrageRunDistance =
        BarrageConfig.unitTimer * insertBarrageEveryFrameRateRunDistance;
    if (offsetMillisecond > 0) {
      insertBarrageRunDistance = (offsetMillisecond / BarrageConfig.unitTimer) *
          insertBarrageEveryFrameRateRunDistance;
    }
    hasInsertOffsetSpace = hasInsertOffsetSpaceComputed(
      trackLastBarrage,
      insertBarrageRunDistance,
    );
    if (!hasInsertOffsetSpace) return true;

    ///Compare the velocity of the barrage to be injected with that of the last barrage.
    if (insertBarrageEveryFrameRateRunDistance >
        trackLastBarrage.everyFrameRunDistance) {
      double insertBarrageLeaveScreenRemainderTime = remainderTimeLeaveScreen(
        insertBarrageRunDistance,
        0,
        insertBarrageEveryFrameRateRunDistance,
      );
      return trackLastBarrage.leaveScreenRemainderTime >
          insertBarrageLeaveScreenRemainderTime;
    }else{
      return false;
    }
  }
}
