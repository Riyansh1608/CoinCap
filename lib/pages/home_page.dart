import 'dart:convert';
import 'package:coincap/pages/country_list.dart';
import 'package:coincap/pages/details_page.dart';
import 'package:coincap/pages/fullCoinImage.dart';
import 'package:coincap/services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double? _deviceHeight, _deviceWidth;
  String _selectedCoin = "bitcoin";
  HTTPService? _http;
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
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _selectedCoinDropDown(),
              _dataWidgets(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectedCoinDropDown() {
    List<String> _coins = [
      "bitcoin",
      "ethereum",
      "tether",
      "cardano",
      "ripple",
    ];

    List<DropdownMenuItem<String>> _items = _coins
        .map(
          (e) => DropdownMenuItem(
            value: e,
            child: Text(
              e.toUpperCase(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w600),
            ),
          ),
        )
        .toList();
    return DropdownButton(
      value: _selectedCoin,
      items: _items,
      onChanged: (dynamic _value) {
        setState(() {
          _selectedCoin = _value;
        });
      },
      dropdownColor: const Color.fromRGBO(83, 88, 206, 1.0),
      iconSize: 30,
      icon: const Icon(
        Icons.arrow_drop_down_sharp,
        color: Colors.white,
      ),
      underline: Container(),
    );
  }

  Widget _dataWidgets() {
    return FutureBuilder(
      future: _http!.get("/coins/$_selectedCoin"),
      builder: (BuildContext _context, AsyncSnapshot _snapshot) {
        if (_snapshot.hasData) {
          Map _data = jsonDecode(_snapshot.data.toString());
          num price = _data["market_data"]["current_price"]["inr"];
          num _percentChange24h = _data["market_data"]
              ["price_change_percentage_24h_in_currency"]["inr"];
          String _imageLink = _data["image"]["large"];
          Map _list = _data["market_data"]["current_price"];

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _coinImage(_imageLink),
              _price(price, _list, _selectedCoin),
              _changeInPercent24h(_percentChange24h),
              _description(_data["description"]["en"]),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
      },
    );
  }

  Widget _coinImage(String _imageLink) {
    return GestureDetector(
      onDoubleTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext _context) {
            return CoinImage(picLink: _imageLink);
          }),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.02),
        margin: EdgeInsets.symmetric(
            vertical: _deviceHeight! * 0.02, horizontal: _deviceHeight! * 0.02),
        height: _deviceHeight! * 0.15,
        width: _deviceWidth! * 0.15,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(_imageLink),
          ),
        ),
      ),
    );
  }

  Widget _price(num _rate, Map list, String slcoin) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) {
            return Details(list: list, coin: slcoin);
          }),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Icon(
            Icons.currency_rupee_sharp,
            color: Colors.white,
            size: 30,
          ),
          Text(
            "${_rate.toString()} ",
            style: const TextStyle(
                fontSize: 34, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _changeInPercent24h(num _percentChange) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          "${_percentChange.toString()} ",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: _percentChange < 0 ? Colors.red : Colors.green),
        ),
        const Icon(
          Icons.percent_outlined,
          color: Colors.white,
          size: 20,
        ),
      ],
    );
  }

  Widget _description(String _info) {
    return Container(
      height: _deviceHeight! * 0.5,
      width: _deviceWidth! * 0.9,
      margin: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.01),
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
