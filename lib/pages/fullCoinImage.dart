import 'package:flutter/material.dart';
import 'home_page.dart';

class CoinImage extends StatefulWidget {
  final String picLink;
  const CoinImage({Key? key, required this.picLink}) : super(key: key);
  @override
  State<CoinImage> createState() => _CoinImageState();
}

class _CoinImageState extends State<CoinImage> {
  double? _deviceHeight, _deviceWidth;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.cancel),
              iconSize: 32,
              color: Colors.red,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: _deviceHeight! * 0.12,
                  vertical: _deviceHeight! * 0.25),
              child: Image(
                image: NetworkImage(widget.picLink),
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
