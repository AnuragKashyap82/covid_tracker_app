import 'dart:async';
import 'package:covid_tracker/View/worls_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      const Duration(seconds: 5),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WorldStats(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                  animation: _controller,
                  child: Container(
                    height: 200,
                    width: 200,
                    child: Center(
                        child: const Image(
                      image: AssetImage("images/virus.png"),
                    )),
                  ),
                  builder: (BuildContext context, Widget? child) {
                    return Transform.rotate(
                      angle: _controller.value * 2.0 * math.pi,
                      child: child,
                    );
                  }),
              SizedBox(
                height: MediaQuery.of(context).size.height * .08,
              ),
              Text(
                "Covid-19\nTracker App",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
