import 'dart:async';
import 'package:coincap/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _animatedLine(),
      ),
    );
  }

  startTime() async {
    return Timer(const Duration(seconds: 8), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    });
  }

  Widget animatedTexts(String _text, String _cursor) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          _text,
          cursor: _cursor,
          textStyle: const TextStyle(
            fontSize: 48.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          speed: const Duration(milliseconds: 400),
        ),
      ],
      totalRepeatCount: 1,
      //pause: Duration(milliseconds: 100),
      displayFullTextOnTap: true,
      stopPauseOnTap: true,
    );
  }

  Widget _animatedLine() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        animatedTexts("C", ""),
        _circularPI(),
        animatedTexts("INCAP", ""),
      ],
    );
  }

  Widget _circularPI() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: const CircularProgressIndicator(
        color: Colors.red,
        strokeWidth: 6.0,
      ),
    );
  }
}
