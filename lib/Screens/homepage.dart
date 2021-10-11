import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  double opacityLevel = 1.0;
  late AnimationController controller;
  late Animation colorAnimation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    colorAnimation =
        ColorTween(begin: Colors.blue, end: Colors.red).animate(controller);

    controller.addListener(() {
      setState(() {});
    });

    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedOpacity(
              opacity: opacityLevel,
              duration: const Duration(seconds: 3),
              child: SizedBox(
                  width: 150,
                  height: 150,
                  child: FlutterLogo(
                    textColor: colorAnimation.value,
                  )),
            ),
            ElevatedButton(
              child: Text(
                'Fade Logo',
                style: TextStyle(color: colorAnimation.value),
              ),
              onPressed: _changeOpacity,
            ),
            Container(width: 150, height: 150, color: colorAnimation.value)
          ],
        ),
      ),
    );
  }
}
