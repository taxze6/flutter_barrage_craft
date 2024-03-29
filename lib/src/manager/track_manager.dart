import 'package:flutter/material.dart';
import 'package:flutter_barrage_craft/src/config/barrage_config.dart';
import 'package:flutter_barrage_craft/src/model/barrage_model.dart';

import '../model/track_model.dart';

class BarrageTrackManager {
  List<BarrageTrack> tracks = [];

  ///Calculate the current track height.
  double get allTrackHeight {
    if (tracks.isEmpty) return 0;
    return tracks.last.offsetTop + tracks.last.trackHeight;
  }

  ///Track remaining height.
  double get remainderHeight => BarrageConfig.areaSize.height - allTrackHeight;

  ///Calculates whether track overflows.
  bool get isTrackOverflowArea =>
      allTrackHeight > BarrageConfig.areaSize.height;

  ///Whether to allow a new track to be built.
  bool areaAllowBuildNewTrack(double trackHeight) {
    assert(trackHeight > 0);
    if (tracks.isEmpty) return true;
    return remainderHeight >= trackHeight;
  }

  ///Fill the area with track.
  void buildTrackFullScreen() async {
    Size trackSize = const Size(200, 30);
    while (
        allTrackHeight < (BarrageConfig.areaSize.height - trackSize.height)) {
      if (areaAllowBuildNewTrack(trackSize.height)) {
        buildTrack(trackSize.height);
      }
    }
  }

  ///Delete the barrage id bound to track.
  void removeTrackWithId(BarrageModel barrageModel) {
    tracks.firstWhere((model) => model.lastBarrageId == barrageModel.barrageId);
  }

  ///Build track.
  BarrageTrack buildTrack(double trackHeight) {
    assert(trackHeight > 0);
    BarrageTrack track = BarrageTrack(allTrackHeight, trackHeight);
    tracks.add(track);
    return track;
  }
}
