import 'package:flutter/material.dart';
import 'package:flutter_barrage_craft/src/barrage_controller.dart';
import 'package:flutter_barrage_craft/src/config/barrage_config.dart';
import 'package:flutter_barrage_craft/src/model/barrage_model.dart';

class BarrageView extends StatefulWidget {
  const BarrageView({Key? key, required this.controller}) : super(key: key);

  final BarrageController controller;

  @override
  State<BarrageView> createState() => _BarrageViewState();
}

class _BarrageViewState extends State<BarrageView> {
  @override
  void initState() {
    super.initState();
    widget.controller.setState = setState;
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
  }

  Widget buildBarrage(BuildContext context, BarrageModel barrageModel) {
    return Positioned(
      right: barrageModel.offsetX,
      top: barrageModel.offsetY,
      child: GestureDetector(
        onTap: () => BarrageConfig.barrageTapCallBack(barrageModel),
        onDoubleTap: () => BarrageConfig.barrageDoubleTapCallBack(barrageModel),
        child: barrageModel.barrageWidget,
      ),
    );
  }

  List<Widget> buildAllBarrage(BuildContext context) {
    return List.generate(
      widget.controller.barrages.length,
      (index) => buildBarrage(
        context,
        widget.controller.barrages[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [...buildAllBarrage(context)],
    );
  }
}
