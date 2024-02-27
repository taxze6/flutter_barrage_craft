import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_barrage_craft/src/config/barrage_config.dart';
import 'package:flutter_barrage_craft/src/manager/barrage_manager.dart';
import 'package:flutter_barrage_craft/src/manager/track_manager.dart';
import 'package:flutter_barrage_craft/src/utils/barrage_utils.dart';

import 'model/barrage_model.dart';
import 'model/track_model.dart';

class BarrageController {
  ///Whether to pause the movement of the barrage.
  bool get isPause => BarrageConfig.pause;

  ///Whether it has been initialized.
  bool _isInit = false;

  bool get isInit => _isInit;

  Timer? _timer;

  ///Barrage and track management.
  BarrageManager barrageManager = BarrageManager();
  BarrageTrackManager barrageTrackManager = BarrageTrackManager();

  List<BarrageModel> get barrages => barrageManager.barrages;

  List<BarrageTrack> get tracks => barrageTrackManager.tracks;

  void init(Size size) {
    //Initializes the run range of the barrage.
    BarrageConfig.areaSize = size;
    //Fill the tracks allowed by the barrage.
    barrageTrackManager.buildTrackFullScreen();
    if (_isInit) return;
    _isInit = true;
    play();
  }

  void play() {
    BarrageConfig.pause = false;
  }

  void pause() {
    BarrageConfig.pause = true;
  }

  /// The barrage cleared the screen.
  void clearScreen() {
    barrageManager.removeAllBarrage();
  }

  void setBarrageTapCallBack(Function(BarrageModel) callBack) {
    BarrageConfig.barrageTapCallBack = callBack;
  }

  ///When all the barrages are off the screen
  void allBarrageOffScreenCallBack({
    required UniqueKey barrageId,
    // required Function() callBack,
  }) {
    if (barrageId == barrageManager.barrageKeys.last) {
      // callBack();
    }
  }

  ///Render the next frame
  List<BarrageModel> renderNextFrameRate(
    List<BarrageModel> oldBarrages,
    Function(UniqueKey) singleBarrageOffScreenCallBack,
    Function(UniqueKey) allBarrageOffScreenCallBack,
  ) {
    List<BarrageModel> newBarrages =
        List.generate(oldBarrages.length, (index) => oldBarrages[index]);
    for (var barrage in newBarrages) {
      barrage.runNextFrame();
      //End of single screen run (off screen).
      if (barrage.allOutLeave) {
        allBarrageOffScreenCallBack(barrage.barrageId);
        singleBarrageOffScreenCallBack(barrage.barrageId);
      }
    }
    return newBarrages;
  }

  BarrageTrack? findAllowInsertTrack(Size barrageSize) {
    BarrageTrack? track;
    for (int a = 0; a < tracks.length; a++) {
      //The current track overflows the available zone.
      if (BarrageUtils.isEnableTrackOverflowArea(tracks[a])) break;
      bool allowInsert = _trackAllowInsert(tracks[a], barrageSize);
      if (allowInsert) {
        track = tracks[a];
        break;
      }
    }
    return track;
  }

  /// Query whether the track allows injection.
  bool _trackAllowInsert(BarrageTrack track, Size needInsertBarrageSize) {
    UniqueKey? lastBarrageId;
    assert(needInsertBarrageSize.height > 0);
    assert(needInsertBarrageSize.width > 0);
    if (track.lastBarrageId == null) return true;
    lastBarrageId = track.lastBarrageId;
    BarrageModel? lastBarrage = barrageManager.barragesMap[lastBarrageId];
    if (lastBarrage == null) return true;
    //If the sending barrage hits the previous one, it cannot be inserted.
    return !BarrageUtils.trackInsertBarrageHashMap(
      trackLastBarrage: lastBarrage,
      needInsertBarrageSize: needInsertBarrageSize,
    );
  }

  // BarrageModel addBarrage() {
  //
  // }
}
