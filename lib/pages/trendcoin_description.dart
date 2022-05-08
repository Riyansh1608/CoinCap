// ignore_for_file: unnecessary_string_interpolations

import 'dart:convert';

import 'package:coincap/services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CoinDescription extends StatefulWidget {
  final String coin, img;
  const CoinDescription({Key? key, required this.coin, required this.img})
      : super(key: key);

  @override
  State<CoinDescription> createState() => _CoinDescriptionState();
}

class _CoinDescriptionState extends State<CoinDescription> {
  HTTPService? _http;
  double? _deviceHeight, _deviceWidth;

  @override
  void initState() {
    super.initState();
    _http = GetIt.instance.get<HTTPService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.orangeAccent,
        backgroundColor: const Color.fromARGB(230, 241, 92, 6),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "${widget.coin.toUpperCase()}",
              style: const TextStyle(color: Colors.white, fontSize: 28),
            ),
            Image(
              width: 40,
              height: 40,
              image: NetworkImage(widget.img),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [disp()],
      ),
    );
  }

  Widget disp() {
    return FutureBuilder(
        future: _http!.get("/coins/${widget.coin}"),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map data = jsonDecode(snapshot.data.toString());
            String desc = data["description"]["en"];
            return _description(desc);
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  Widget _description(String _info) {
    return Container(
      height: _deviceHeight! * 0.8,
      width: _deviceWidth! * 0.9,
      margin: EdgeInsets.symmetric(
          vertical: _deviceHeight! * 0.01, horizontal: _deviceWidth! * 0.05),
      padding: EdgeInsets.symmetric(
          vertical: _deviceHeight! * 0.02, horizontal: _deviceHeight! * 0.01),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.02),
        child: Text(
          _info,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
