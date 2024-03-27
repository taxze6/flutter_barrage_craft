import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_barrage_craft/src/config/barrage_config.dart';
import 'package:flutter_barrage_craft/src/manager/barrage_manager.dart';
import 'package:flutter_barrage_craft/src/manager/track_manager.dart';
import 'package:flutter_barrage_craft/src/utils/barrage_utils.dart';

import 'model/barrage_model.dart';
import 'model/track_model.dart';

class BarrageController {
  late Function setState;

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
    run(
      () {
        renderNextFrameRate(
          barrages,
          allBarrageOffScreenCallBack,
          singBarrageOffScreenCallBack,
        );
      },
      setState,
    );
  }

  void run(Function nextFrame, Function setState) {
    _timer = Timer.periodic(Duration(milliseconds: BarrageConfig.unitTimer),
        (timer) {
      // When the barrage is suspended, it is not executed.
      if (!BarrageConfig.pause) {
        nextFrame();
        setState(() {});
      }
    });
  }

  void play() {
    BarrageConfig.pause = false;
  }

  void pause() {
    BarrageConfig.pause = true;
  }

  void dispose() {
    _timer?.cancel();
  }

  /// The barrage cleared the screen.
  void clearScreen() {
    barrageManager.removeAllBarrage();
  }

  void setBarrageTapCallBack(Function(BarrageModel) callBack) {
    BarrageConfig.barrageTapCallBack = callBack;
  }

  void setBarrageDoubleTapCallBack(Function(BarrageModel) callBack) {
    BarrageConfig.barrageDoubleTapCallBack = callBack;
  }

  ///When all the barrages are off the screen
  void allBarrageOffScreenCallBack(
    UniqueKey barrageId,
    // required Function() callBack,
  ) {
    if (barrageId == barrageManager.barrageKeys.last) {
      // callBack();
    }
  }

  ///When a single barrage disappears from the screen.
  void singBarrageOffScreenCallBack(
    UniqueKey barrageId,
    // required Function() callBack,
  ) {
    // if (barrageId == barrageManager.barrageKeys.last) {
    // callBack();
    // }
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
      if(barrage.pause){
        barrage.runNextFrame();
        //End of single screen run (off screen).
        if (barrage.allOutLeave) {
          allBarrageOffScreenCallBack(barrage.barrageId);
          singleBarrageOffScreenCallBack(barrage.barrageId);
        }
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

  Future<BarrageModel> addBarrage({
    required Widget barrageWidget,
    Size? widgetSize,
  }) async {
    late Size barrageSize;
    if (widgetSize != null) {
      barrageSize = widgetSize;
    } else {
      try {
        barrageSize = await BarrageUtils.getBarrageSizeByWidget(barrageWidget);
      } catch (e) {
        print(e);
      }
    }
    double everyFrameRunDistance =
        BarrageUtils.getBarrageEveryFrameRateRunDistance(barrageSize.width);
    double runDistance = BarrageConfig.unitTimer * everyFrameRunDistance;
    //TODO To be optimized: If no track can have an injection barrage, wait for a while.
    BarrageTrack? track = findAllowInsertTrack(barrageSize);
    if (track == null) {
      // If no track can have an injection barrage, wait for a while and try again
      await Future.delayed(
        const Duration(milliseconds: 500),
      ); // Wait for 500 milliseconds
      return addBarrage(barrageWidget: barrageWidget, widgetSize: widgetSize);
    }
    double offsetY = track.offsetTop;
    BarrageModel barrage = barrageManager.initBarrage(
      barrageWidget: barrageWidget,
      offsetY: offsetY,
      everyFrameRunDistance: everyFrameRunDistance,
      runDistance: runDistance,
      barrageSize: barrageSize,
      // offsetMS: Random().nextInt(5000),
      offsetMS: 0,
    );
    track.lastBarrageId = barrage.barrageId;
    print(" Join the track as: ${track.toString()}");
    return barrage;
  }
}
