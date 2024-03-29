# flutter_barrage_craft

English | [简体中文](https://github.com/taxze6/flutter_barrage_craft/blob/main/README-CN.md)

### About☘
2024 © Taxze

Flutter Barrage Craft is a platform-wide barrage component. It can automatically calculate the Size of the bullet screen widget and insert it into the bullet screen track. Support all bullet screen suspension, playback, motion speed control, support a single bullet screen suspension, playback, click event, double click event...
### When is this component needed🍖
- **Short video platform, live broadcast platform... And other scenes that require a barrage**
  The flutter-barrage-craft allows you to complete integration in minutes, simply by passing the barrage data into the barrage controller. In this way, you can devote more energy to writing functional code that deals with the barrage data.
- **Scrolling animation related functions**
  Although flutter-barrage-craft is a barrage plugin, it can be used to complete the scrolling animation related functions, just need to loop the scrolling data into the barrage controller.
  This example is from [flutter-chat-craft](https://github.com/taxze6/flutter-chat-craft).
  
  ![chatModel.png](https://camo.githubusercontent.com/c20d3b4f779255cb4e5b102e75024508c507349d1df6e61faa42421e87a930c4/68747470733a2f2f63646e2e6e6c61726b2e636f6d2f79757175652f302f323032342f706e672f33343934303838342f313730363439363031383237322d63393837333061372d336665352d343238642d393362312d6565323734336132616434662e706e6723617665726167654875653d25323337363666363826636c69656e7449643d7531656333643539302d623139312d342666726f6d3d7061737465266865696768743d3831322669643d753630646530323332266f726967696e4865696768743d383132266f726967696e57696474683d333735266f726967696e616c547970653d62696e61727926726174696f3d3126726f746174696f6e3d302673686f775469746c653d66616c73652673697a653d333934353331267374617475733d646f6e65267374796c653d6e6f6e65267461736b49643d7562386639333137392d633764372d343664662d626535662d3133396531333163613763267469746c653d2677696474683d333735)
### Screenshots 🌮
![img](https://img2.imgtp.com/2024/03/29/FfpKYqmN.gif)
### Installation 🍩
Run flutter pub add flutter_barrage_craft or manually add flutter_barrage_craft to the pubspec.yaml dependency.
```
dependencies:
  flutter_barrage_craft: ^latest_version
```
Then, run flutter pub get to install the plug-in.
### Usage 🍝
To use flutter_barrage_craft in Flutter, first import the package:
```
import 'package:flutter_barrage_craft/flutter_barrage_craft.dart';
```
#### Initializes the barrage controller
Passed in initState `WidgetsBinding.instance.addPostFrameCallback` callback function is introduced to barrage mobile area, The move area passed in here is size (MediaQuery.of(context).size.width, 300).
```
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
```
#### Add a barrage screen through the controller
You can add any normally rendered widget to the Barrage queue with addBarrage.

**Method 1: The widget size has been manually calculated**

💥 I recommend that you choose this option because it reduces the number of builds passed in to the widget and provides a performance boost.
```
controller.addBarrage(
  barrageWidget: const SizedBox(
    width: 100,
    height: 20,
    child: Text(
      "Test Barrage",
      style: TextStyle(
        fontSize: 14,
        color: Colors.white,
      ),
    ),
  ),
  widgetSize: const Size(100, 20),
);
```
**Method 2: Unconstrained widget size**

🚩 This is convenient. If you can't figure out the size of a widget, leave it to flutter_barrage_craft and flutter_barrage_craft will calculate the size of the widget.
> Note the following when using this method:
> 1. An additional widget will be built for size calculation.
> 2. You must pass BuildContext, otherwise assert(context!) cannot be passed. = null).
```
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
```
#### Adds a click/double-click event to the barrage screen
##### Add click event
```
controller.setBarrageTapCallBack((value) {
    print(value);
});
```
##### Add double click event
```
controller.setBarrageDoubleTapCallBack((value) {
    print(value);
});
```
#### Adds render/remove screen listening events to the barrage screen
##### Single barrage screen to complete the display on screen processing
```
controller.setSingleBarrageShowScreenCallBack((value) {
    print(value);
});
```
##### Single barrage-removal screen handling
```
controller.setSingleBarrageRemoveScreenCallBack((value) {
    print(value);
});
```
#####  All barrages screen removal processing
```
controller.setAllBarragesRemoveScreenCallBack((value) {
    print(value);
});
```
#### Change the speed of the barrage movement
Pass in any floating point number greater than 0.
This example is three times faster than the original moving speed.
```
controller.changeBarrageRate(3.0);
```
If you want to go back to the original speed, you just pass in 1.
```
controller.changeBarrageRate(1.0);
```
#### Play/pause the barrage
##### Play
```
controller.play();
```
##### Pause
```
controller.pause();
```
##### Pause/play a single barrage
All you need to do is set `pause = !pause` is enough, and here is the pause/play of a single barrage achieved by clicking the event.
```
controller.setBarrageTapCallBack((value) {
  print(value.toString());
  //Pause a single barrage.
  setState(() {
    value.pause = !value.pause;
  });
});
```

## 🎈At Last

If you encounter any problems with this project, please feel free to add me on WeChat. By the way, there is a WeChat communication group for this project! Welcome to join~

🌱 I'm looking for a Flutter software engineer position in Hangzhou or remotely. Please feel free to contact me.

<img src="https://img2.imgtp.com/2024/03/29/yXE6WeNB.jpg" alt="联系方式" width="400">

