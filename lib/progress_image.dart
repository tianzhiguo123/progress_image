library progress_image;

import 'package:flutter/material.dart';
import 'dart:math';

typedef Widget WidgetBuilderWithSize(BuildContext context, Size size);

class ProgressImage extends StatefulWidget {
  final double width;
  final double height;
  final int initProgress;
  final WidgetBuilderWithSize builder;

  ProgressImage({
    Key key,
    this.width: 70.0,
    this.height: 150.0,
    this.initProgress: -1,
    @required this.builder,
  }) : super(key: key);

  @override
  ProgressImageState createState() => new ProgressImageState();
}

class ProgressImageState extends State<ProgressImage>
    with TickerProviderStateMixin {
  AnimationController animation;
  Tween<double> tween;
  AnimationController elasticityCircleAnimation;
  Tween<double> elasticityCircleTween;
  double dataSet = 0.0;
  final random = new Random();
  // -1 代表刚开始
  int progress;

  @override
  void initState() {
    super.initState();
    progress = widget.initProgress;
    initSplashTween();
    initElasticityCircleTween();
  }

  void initSplashTween() {
    //    创建动画控制器
    animation = new AnimationController(
        duration: new Duration(milliseconds: this.progress < 100 ? 0 : 300),
        vsync: this)
      ..addListener(() {
        setState(() {});
      });
    dataSet = widget.height * 2;
    tween = new Tween<double>(
        begin:this.progress == -1 ?0.0: dataSet.toDouble(),
        end: this.progress == -1 ?0.0:this.progress < 100 ? dataSet.toDouble() : 0.0);
    animation.forward();
  }

  void initElasticityCircleTween() {
    //    创建动画控制器
    elasticityCircleAnimation = new AnimationController(
        duration: new Duration(milliseconds: 500), vsync: this)
      ..addListener(() {
        if (elasticityCircleAnimation.status == AnimationStatus.completed) {
          elasticityCircleAnimation.reverse();
        }
        if (elasticityCircleAnimation.status == AnimationStatus.dismissed) {
          elasticityCircleAnimation.forward();
        }

        setState(() {});
      });
    elasticityCircleTween = new Tween<double>(begin: 2.0, end: 4.0);
    elasticityCircleAnimation.forward();
  }

  void setProgress(int progress) {
    setState(() {
      this.progress = progress;
      if (this.progress == 100 && elasticityCircleAnimation != null) {
//        elasticityCircleAnimation.dispose();
//        elasticityCircleAnimation = null;

      }
      animation.dispose();
      initSplashTween();
    });
  }

  @override
  void dispose() {
    animation?.dispose();
    elasticityCircleAnimation?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSufficient = this.progress == 100 || this.progress == -1;
    Size size = new Size(widget.width, widget.height);
    return new Container(
      width: widget.width,
      height: widget.height,
      child: new ClipPath(
        child: new Stack(
          children: <Widget>[
            widget.builder(context, size),
            new CustomPaint(
              size: size,
              painter: new ProgressImageContent(tween.animate(animation).value),
            ),
            isSufficient
                ? null
                : new Center(
                    child: new Text(
                    '$progress%',
                    style: new TextStyle(color: Colors.white),
                  )),
            new CustomPaint(
              size: size,
              painter: new ElasticityCircle(isSufficient
                  ? -1.0
                  : elasticityCircleTween
                      .animate(elasticityCircleAnimation)
                      .value),
            ),
          ].where((o) => o != null).toList(),
        ),
      ),
    );
  }
}

class ProgressImageContent extends CustomPainter {
  final double animateValue;

  ProgressImageContent(this.animateValue);

  @override
  void paint(Canvas canvas, Size size) {
    if (animateValue > 0) {
      //选中大圆
      final selectedBigCirclePaint = new Paint()
        ..color = Colors.black26
        ..style = PaintingStyle.stroke
        ..strokeWidth = animateValue;
      //画到最高
      canvas.drawCircle(new Offset(size.width / 2, size.height / 2),
          size.height / 2, selectedBigCirclePaint);
    }
  }

  @override
  bool shouldRepaint(ProgressImageContent oldDelegate) {
    return animateValue != oldDelegate.animateValue;
  }
}

class ElasticityCircle extends CustomPainter {
  final double animateValue;

  ElasticityCircle(this.animateValue);

  @override
  void paint(Canvas canvas, Size size) {
    if (animateValue > 0) {
      //选中大圆
      final selectedBigCirclePaint = new Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = animateValue;
      //画到最高
      canvas.drawCircle(new Offset(size.width / 2, size.height / 2), 20.0,
          selectedBigCirclePaint);
    }
  }

  @override
  bool shouldRepaint(ElasticityCircle oldDelegate) {
    return animateValue != oldDelegate.animateValue;
  }
}
