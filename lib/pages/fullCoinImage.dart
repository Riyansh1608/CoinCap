import 'dart:math';

import 'package:flutter/material.dart';
import 'home_page.dart';

class CoinImage extends StatefulWidget {
  final String picLink;
  const CoinImage({Key? key, required this.picLink}) : super(key: key);
  @override
  State<CoinImage> createState() => _CoinImageState();
}

class _CoinImageState extends State<CoinImage> with TickerProviderStateMixin {
  double? _deviceHeight, _deviceWidth;
  AnimationController? _coinAnimationController;
  @override
  void initState() {
    super.initState();

    _coinAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _coinAnimationController!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                _coinAnimationController!.dispose();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.cancel),
              iconSize: 32,
              color: Colors.red,
            ),
            _coinAnimation(),
          ],
        ),
      ),
    );
  }

  Widget _coinAnimation() {
    return AnimatedBuilder(
      animation: _coinAnimationController!.view,
      builder: (_context, _child) {
        return Transform.rotate(
          angle: _coinAnimationController!.value * pi * 2,
          child: _child,
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: _deviceHeight! * 0.12, vertical: _deviceHeight! * 0.25),
        child: Image(
          image: NetworkImage(widget.picLink),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
