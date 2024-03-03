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
    controller.init(Size(MediaQuery.of(context).size.width, 300));
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
              Column(
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          controller.addBarrage(
                            barrageWidget: Text(
                              "1111",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                        child: Text("Add Barrage"),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
