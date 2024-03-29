# flutter_barrage_craft

### 关于☘

2024 © Taxze

Flutter Barrage Craft是一个全平台可用的弹幕组件。它可以自动计算弹幕widget的Size，并插入到弹幕轨道当中。支持全部弹幕的暂停、播放、运动速度控制，支持单个弹幕的暂停、播放、单击事件、双击事件...

### 什么时候需要该组件🍖

- 短视频平台、直播平台...等需要弹幕的场景

flutter-barrage-craft可以让您在几分钟内完成集成，只需要将弹幕数据传入弹幕控制器即可。这样，您可以将更多的精力用于编写处理弹幕数据相关功能代码。

- **滚动动画相关功能**

flutter-barrage-craft虽然是一个弹幕插件，但是可以借助该插件完成滚动动画相关功能，只需要将滚动的数据循环进弹幕控制器即可。

该例子来自[flutter-chat-craft](https://github.com/taxze6/flutter-chat-craft)

![img](https://img2.imgtp.com/2024/03/29/FfpKYqmN.gif)

### 功能演示🌮

![img](https://img2.imgtp.com/2024/03/29/FfpKYqmN.gif)

### 安装🍩

运行 `flutter pub add flutter_barrage_craft` 或者手动添加 `flutter_barrage_craft` 到 `pubspec.yaml` 依赖项。

```plain
dependencies:
  flutter_barrage_craft: ^latest_version
```

然后，运行 `flutter pub get` 安装该插件。

### 用法🍝

要在 Flutter 中使用 flutter_barrage_craft，请首先导入包：

```plain
import 'package:flutter_barrage_craft/flutter_barrage_craft.dart';
```

#### 初始化弹幕控制器

在`initState`中通过`WidgetsBinding.instance.addPostFrameCallback`回调函数传入弹幕移动区域，此处传入的移动区域为`Size(MediaQuery.of(context).size.width, 300)`。

```plain
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

#### 通过控制器添加弹幕

您可以将任何正常渲染的`widget`通过`addBarrage`添加到弹幕队列中。

**方式一：已经手动计算完成widget size**

**💥**我推荐您选择这种方式，因为会减少一次对传入widget的build，有一定的性能提升。

```plain
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

**方式二：非固定尺寸（unconstrained）的widget size**

**🚩**这种方式非常方便，如果您无法确定传入`widget`的尺寸，没关系，把它交给`flutter_barrage_craft`，`flutter_barrage_craft`会完成对该`widget`的尺寸计算。

*使用该方式需注意：*

*1.会额外build一次widget，用于尺寸计算。*

*2.必须要传入BuildContext，否则无法通过 assert(context != null) 。*

```plain
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

#### 给弹幕添加单击/双击事件

##### 添加单击事件

```plain
controller.setBarrageTapCallBack((value) {
    print(value);
});
```

##### 添加双击事件

```plain
controller.setBarrageDoubleTapCallBack((value) {
    print(value);
});
```



#### 给弹幕添加渲染/移除屏幕监听事件

##### 添加单个弹幕完成显示在屏幕上处理

```plain
controller.setSingleBarrageShowScreenCallBack((value) {
    print(value);
});
```

##### 添加单个弹幕移除屏幕处理

```plain
controller.setSingleBarrageRemoveScreenCallBack((value) {
    print(value);
});
```

##### 添加全部弹幕移除屏幕处理

```plain
controller.setAllBarragesRemoveScreenCallBack((value) {
    print(value);
});
```

#### 改变弹幕移动速度

传入任何大于0的浮点数。

该例子是在原有移动速度上加速3倍。

```plain
controller.changeBarrageRate(3.0);
```

如果需要回到原来移动速度，只需要传入1。

```plain
controller.changeBarrageRate(1.0);
```

#### 播放/暂停弹幕

##### 播放

```plain
controller.play();
```

##### 暂停

```plain
controller.pause();
```

**暂停/播放单个弹幕**

只需要将该弹幕的 `pause = !pause`即可，下面是通过单击事件实现的暂停/播放单个弹幕。

```plain
controller.setBarrageTapCallBack((value) {
  print(value.toString());
  //Pause a single barrage.
  setState(() {
    value.pause = !value.pause;
  });
});
```

## 🎈最后

如果你在这个项目中遇到任何问题，请随时加我微信。顺便说一下，这个项目有一个微信交流群!欢迎加入~

🌱我正在寻找一个在杭州或远程Flutter软件工程师的职位。请随时与我联系。

<img src="https://img2.imgtp.com/2024/03/29/yXE6WeNB.jpg" alt="联系方式" width="400">
