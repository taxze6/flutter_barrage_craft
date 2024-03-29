import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_barrage_craft/src/config/barrage_config.dart';
import 'package:flutter_barrage_craft/src/model/barrage_model.dart';
import 'package:flutter_barrage_craft/src/model/track_model.dart';

class BarrageUtils {
  ///Calculate the width and height of the barrage.
  static Size getBarrageSizeByText(String text) {
    const constraints = BoxConstraints(
      maxWidth: 999.0, // maxWidth calculated
      minHeight: 0.0,
      minWidth: 0.0,
    );
    RenderParagraph renderParagraph = RenderParagraph(
      TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );
    renderParagraph.layout(constraints);
    double w = renderParagraph.getMinIntrinsicWidth(14).ceilToDouble();
    double h = renderParagraph.getMinIntrinsicHeight(999).ceilToDouble();
    return Size(w, h);
  }

  static Future<Size> getBarrageSizeByWidget(
    BuildContext c,
    Widget widget,
  ) async {
    // Create the Completer to wait for the size calculation to complete
    Completer<Size> completer = Completer<Size>();

    final overlayEntry = OverlayEntry(
      builder: (context) {
        return MeasurableWidget(
          onChange: (Size size) async {
            if (kDebugMode) {
              print('Barrage size: $size');
            }
            completer.complete(size);
          },
          child: widget,
        );
      },
    );

    Overlay.of(c).insert(overlayEntry);

    try {
      // Wait for the size calculation to complete
      Size size = await completer.future;
      return size;
    } finally {
      // The OverlayEntry needs to be removed regardless of whether the dimensions were successfully obtained.
      overlayEntry.remove();
    }
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
  static bool trackInsertBarrageHashMap({
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
    } else {
      return false;
    }
  }
}

class MeasurableWidget extends StatefulWidget {
  const MeasurableWidget({
    Key? key,
    required this.onChange,
    required this.child,
  }) : super(key: key);

  final Future<void> Function(Size size) onChange;
  final Widget child;

  @override
  _MeasurableWidgetState createState() => _MeasurableWidgetState();
}

class _MeasurableWidgetState extends State<MeasurableWidget> {
  late Size _size;

  @override
  void initState() {
    super.initState();
    _size = Size.zero;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getSize();
    });
  }

  Future<void> _getSize() async {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    setState(() {
      _size = renderBox.size;
    });
    await widget.onChange(_size);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -1999,
      child: widget.child,
    );
  }
}

// class MeasurableWidget extends SingleChildRenderObjectWidget {
//   const MeasurableWidget({
//     Key? key,
//     required this.onChange,
//     required Widget child,
//   }) : super(key: key, child: child);
//
//   final void Function(Size size) onChange;
//
//   @override
//   RenderObject createRenderObject(BuildContext context) =>
//       MeasureSizeRenderObject(onChange);
// }
//
// class MeasureSizeRenderObject extends RenderProxyBox {
//   MeasureSizeRenderObject(this.onChange);
//
//   void Function(Size size) onChange;
//
//   Size _prevSize = Size.zero;
//
//   @override
//   void performLayout() {
//     super.performLayout();
//     Size newSize = child?.size ?? Size.zero;
//     if (_prevSize == newSize) return;
//     _prevSize = newSize;
//
//     WidgetsBinding.instance.addPostFrameCallback((_) => onChange(newSize));
//   }
// }

// typedef OnSized = void Function(Rect rect);
//
// mixin MeasurableMixin<T extends StatefulWidget> on State<T> {
//   @override
//   BuildContext get context;
//
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback(_afterRendering);
//     super.initState();
//   }
//
//   void _afterRendering(Duration timeStamp) {
//     RenderObject? renderObject = context.findRenderObject();
//     if (renderObject != null) {
//       Size size = renderObject.paintBounds.size;
//       var box = renderObject as RenderBox;
//       onSized(
//         Rect.fromLTWH(
//           box.localToGlobal(Offset.zero).dx,
//           box.localToGlobal(Offset.zero).dy,
//           size.width,
//           size.height,
//         ),
//       );
//     } else {
//       onSized(Rect.zero);
//     }
//   }
//
//   void onSized(Rect rect);
// }
//
// class MeasurableWidget extends StatefulWidget {
//   final Widget child;
//
//   final OnSized onSized;
//
//   const MeasurableWidget({
//     Key? key,
//     required this.child,
//     required this.onSized,
//   }) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() {
//     return _MeasurableWidgetState();
//   }
// }
//
// class _MeasurableWidgetState extends State<MeasurableWidget>
//     with MeasurableMixin<MeasurableWidget> {
//   @override
//   Widget build(BuildContext context) => widget.child;
//
//   @override
//   void onSized(Rect rect) => widget.onSized(rect);
// }
