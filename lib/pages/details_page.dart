import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final Map list;
  final String coin;
  const Details({required this.list, required this.coin});

  @override
  Widget build(BuildContext context) {
    List _currencies = list.keys.toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 23, 7, 82),
        title: Text(coin),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: _currencies.length,
            itemBuilder: (_context, _index) {
              String _currency = _currencies[_index];
              return ListTile(
                leading: Icon(
                  Icons.currency_bitcoin,
                  color: Colors.white,
                ),
                title: Text(
                  "${_currency.toUpperCase()} : ${list[_currency]}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
              );
            }),
      ),
    );
  }
}
