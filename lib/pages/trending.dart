import 'dart:convert';
import 'dart:ui';

import 'package:coincap/pages/trendcoin_description.dart';
import 'package:flutter/material.dart';
import 'package:coincap/services/http_services.dart';
import 'package:get_it/get_it.dart';

class Trending extends StatefulWidget {
  const Trending({Key? key}) : super(key: key);

  @override
  State<Trending> createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  int _index = 7;
  HTTPService? _http;
  @override
  void initState() {
    super.initState();
    _http = GetIt.instance.get<HTTPService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.orangeAccent,
        backgroundColor: const Color.fromARGB(230, 241, 92, 6),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Text(
              "Trending",
              style: const TextStyle(color: Colors.white, fontSize: 28),
            ),
            Icon(
              Icons.trending_up,
              color: Color.fromARGB(255, 72, 255, 0),
              size: 40,
            )
          ],
        ),
        centerTitle: true,
      ),
      body: futureTrending(),
    );
  }

  Widget futureTrending() {
    return FutureBuilder(
        future: _http!.get("/search/trending"),
        builder: (BuildContext _context, AsyncSnapshot _snapshot) {
          if (_snapshot.hasData) {
            Map data = jsonDecode(_snapshot.data.toString());

            return _listView(data);
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
        });
  }

  Widget _listView(Map _data) {
    return ListView.builder(
      itemBuilder: (BuildContext _context, _index) {
        String a = _data["coins"][_index]["item"]["name"];
        String b = _data["coins"][_index]["item"]["thumb"];
        String c = _data["coins"][_index]["item"]["id"];
        return ListTile(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return CoinDescription(coin: c, img: b);
            }));
          },
          horizontalTitleGap: 20,
          minVerticalPadding: 20,
          dense: false,
          title: Text(
            a,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
            ),
          ),
          trailing: Image(image: NetworkImage(b)),
        );
      },
      itemCount: _index,
    );
  }
}
