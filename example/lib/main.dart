import 'package:flutter/material.dart';
import 'package:flutter_barrage_craft/flutter_barrage_craft.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BarrageController controller = BarrageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        controller.init(Size(MediaQuery.of(context).size.width, 300));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                  "Barrage Demonstration",
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
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            controller.pause();
                          },
                          child: const Text("Pause"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            controller
                                .addBarrage(
                                  barrageWidget: Text(
                                    "1111",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                              widgetSize: Size(80,20)
                                )
                                .then((value) => {});
                          },
                          child: const Text("Add Barrage"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            controller.play();
                          },
                          child: const Text("Play"),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
