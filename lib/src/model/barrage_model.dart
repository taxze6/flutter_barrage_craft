import 'package:flutter/cupertino.dart';
import '../config/barrage_config.dart';

class BarrageModel {
  UniqueKey barrageId;
  Widget barrageWidget;
  double offsetY;
  double runDistance = 0;
  double everyFrameRunDistance;
  Size barrageSize;
  bool pause = true;

  BarrageModel({
    required this.barrageId,
    required this.barrageWidget,
    required this.offsetY,
    required this.everyFrameRunDistance,
    required this.runDistance,
    required this.barrageSize,
    //offset in milliseconds
    required int offsetMS,
  }) {
    runDistance = (offsetMS / BarrageConfig.unitTimer) * everyFrameRunDistance;
  }

  /// The X-axis position of the barrage.
  double get offsetX => runDistance - barrageSize.width;

  /// Maximum run distance of barrage Barrage width + wall width.
  double get maxRunDistance => barrageSize.width + BarrageConfig.areaSize.width;

  /// The barrage is completely detached from the right wall.
  bool get allOutRight => runDistance > barrageSize.width;

  /// The whole barrage is off the screen.
  bool get allOutLeave => runDistance > maxRunDistance;

  /// Remaining distance away.
  double get remainderDistance => needRunDistance - runDistance;

  /// Distance to travel.
  double get needRunDistance =>
      BarrageConfig.areaSize.width + barrageSize.width;

  /// The time remaining away from the screen.
  double get leaveScreenRemainderTime =>
      remainderDistance / everyFrameRunDistance;

  /// The barrage executes the next frame.
  void runNextFrame() {
    runDistance += everyFrameRunDistance * BarrageConfig.barrageRate;
  }

  @override
  String toString() {
    return 'BarrageModel{barrageId: $barrageId, offsetX: $offsetX, offsetY: $offsetY, runDistance: $runDistance, barrageSize: $barrageSize}';
  }
}
