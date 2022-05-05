import 'package:flutter/material.dart';
import 'package:coincap/pages/home_page.dart';

class CoinImage extends StatelessWidget {
  final String picLink;

  CoinImage({required this.picLink});
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
                image: NetworkImage(picLink),
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
