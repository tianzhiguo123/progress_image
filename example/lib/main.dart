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
