import 'package:flutter/material.dart';

class BarrageTrack {
  UniqueKey trackId = UniqueKey();
  UniqueKey? lastBarrageId;
  double offsetTop;
  double trackHeight;

  BarrageTrack(this.offsetTop, this.trackHeight);

  void unloadLastBarrageId() {
    lastBarrageId = null;
  }

  @override
  String toString() {
    return 'BarrageTrack(trackId: $trackId, lastBarrageId: $lastBarrageId, offsetTop: $offsetTop, trackHeight: $trackHeight)';
  }
}
