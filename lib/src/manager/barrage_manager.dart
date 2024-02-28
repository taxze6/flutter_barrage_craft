import 'package:flutter/material.dart';

import '../model/barrage_model.dart';

class BarrageManager {
  Map<UniqueKey, BarrageModel> _barrages = {};

  List<BarrageModel> get barrages => _barrages.values.toList();

  List<UniqueKey> get barrageKeys => _barrages.keys.toList();

  Map<UniqueKey, BarrageModel> get barragesMap => _barrages;

  /// Record the barrage into the map
  recordBarrage(BarrageModel barrage) {
    _barrages[barrage.barrageId] = barrage;
  }

  void removeBarrageByKey(UniqueKey id) => _barrages.remove(id);

  void removeAllBarrage() {
    _barrages = {};
  }

  BarrageModel initBarrage({
    required Widget barrageWidget,
    required double offsetY,
    required double everyFrameRunDistance,
    required double runDistance,
    required Size barrageSize,
    required int offsetMS,
  }) {
    UniqueKey barrageId = UniqueKey();
    BarrageModel barrage = BarrageModel(
      barrageId: barrageId,
      barrageWidget: barrageWidget,
      offsetY: offsetY,
      everyFrameRunDistance: everyFrameRunDistance,
      runDistance: runDistance,
      barrageSize: barrageSize,
      offsetMS: offsetMS,
    );
    recordBarrage(barrage);
    return barrage;
  }
}
