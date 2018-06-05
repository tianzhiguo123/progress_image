# progress_image

#####flutter的图片上传进度(类似qq发送图片)

## Getting Started

For help getting started with Flutter, view our online [documentation](https://flutter.io/).

For help on editing package code, view the [documentation](https://flutter.io/developing-packages/).
![image](https://github.com/zhangruiyu/progress_image/blob/master/example.gif)

##How to use ?

1. Depend on it
 
```yaml
dependencies:
  progress_image: "^0.0.1"
```

2. Install it
 
```sh
$ flutter packages get
```

3. Import it

```dart
import 'package:progress_image/progress_image.dart';
```

##属性
* width 宽度 
* height:  高度(影响水波纹大小)
* builder: 返回显示的内容
* initProgress: 默认进度,-1代表默认不显示阴影遮罩,0代表显示遮罩

##Example
```
import 'package:flutter/material.dart';
import 'package:progress_image/progress_image.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ProgressImageState> progressImageKey =
      new GlobalKey<ProgressImageState>();

  void _incrementCounter() {
    progressImageKey.currentState.setProgress(100);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new ProgressImage(
                key: progressImageKey,
                builder: (BuildContext context, Size size) {
                  return new Image.network(
                    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527862078037&di=3ce4750ed2aa7629c2e25e49f065e06e&imgtype=0&src=http%3A%2F%2Fimg15.3lian.com%2F2015%2Ff2%2F82%2Fd%2F7.jpg',
                    width: size.width,
                    fit: BoxFit.fill,
                    height: size.height,
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
```

##### 有需求的话,后期再加入其他的吧