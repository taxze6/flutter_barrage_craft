import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_barrage_craft/flutter_barrage_craft.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Barrage Craft',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BarrageController controller = BarrageController();

  @override
  void initState() {
    super.initState();
    controller.setBarrageTapCallBack((value) {});
    controller.setBarrageDoubleTapCallBack((value) {});
    controller.setSingleBarrageRemoveScreenCallBack((value) {});
    controller.setAllBarragesRemoveScreenCallBack((value) {});
    controller.setSingleBarrageShowScreenCallBack((value) {});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        controller.init(Size(MediaQuery.of(context).size.width, 300));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Barrage Craft'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                "Barrage Demo",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              height: 300,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Stack(
                children: [
                  BarrageView(
                    controller: controller,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 12,
                runSpacing: 10,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      controller.pause();
                    },
                    child: const Text("Pause"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.play();
                    },
                    child: const Text("Play"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.changeBarrageRate(3);
                    },
                    child: const Text("Speed 🍖"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.changeBarrageRate(1);
                    },
                    child: const Text("Speed 🥝"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      controller.addBarrage(
                        barrageWidget: const Text(
                          "Test Barrage",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        context: context,
                      );
                    },
                    child: const Text("Add Barrage"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      controller.addBarrage(
                        barrageWidget: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.primaries[
                                Random().nextInt(Colors.primaries.length)],
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FlutterLogo(),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                "Container Test Barrage",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        context: context,
                      );
                    },
                    child: const Text("Add Box Barrage"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      controller.addBarrage(
                        barrageWidget: Image.asset(
                          "assets/app.png",
                          width: 200,
                          height: 100,
                        ),
                        context: context,
                      );
                    },
                    child: const Text("Add Image Barrage"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
