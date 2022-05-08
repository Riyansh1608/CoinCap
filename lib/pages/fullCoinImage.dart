import 'dart:math';

import 'package:flutter/material.dart';
import 'home_page.dart';

class CoinImage extends StatefulWidget {
  final String picLink;
  final String selectedcoin;
  const CoinImage({
    Key? key,
    required this.picLink,
    required this.selectedcoin,
  }) : super(key: key);
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
      backgroundColor: _imageBgColor(),
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
                color: Colors.black87),
            _coinAnimation,
          ],
        ),
      ),
    );
  }

  Widget get _coinAnimation {
    return AnimatedBuilder(
      animation: _coinAnimationController!.view,
      builder: (_context, _child) {
        return Transform.rotate(
          angle: _coinAnimationController!.value * pi * 2,
          child: _child,
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.1),
        child: Center(
          child: Image(
            height: _deviceHeight! * 0.6,
            width: _deviceWidth! * 0.8,
            image: NetworkImage(widget.picLink),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Color _imageBgColor() {
    Color k;
    if (widget.selectedcoin == "bitcoin") {
      k = const Color.fromARGB(255, 244, 148, 28);
    } else if (widget.selectedcoin == "ethereum") {
      k = Colors.black45;
    } else if (widget.selectedcoin == "tether") {
      k = Color.fromARGB(255, 60, 171, 133);
    } else if (widget.selectedcoin == "cardano") {
      k = Color.fromARGB(255, 194, 217, 236);
    } else {
      k = Colors.white;
    }

    return k;
  }
}
