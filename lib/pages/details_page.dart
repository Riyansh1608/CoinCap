import 'package:flutter/gestures.dart';
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
        backgroundColor: const Color.fromARGB(230, 241, 92, 6),
        title: Text(coin.toUpperCase()),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            dragStartBehavior: DragStartBehavior.start,
            itemCount: _currencies.length,
            itemBuilder: (_context, _index) {
              String _currency = _currencies[_index];
              return ListTile(
                horizontalTitleGap: 20,
                minVerticalPadding: 20,
                onLongPress: () => Navigator.pop(context, _currency),
                leading: const Icon(
                  Icons.money,
                  color: Colors.yellow,
                ),
                title: Text(
                  "${_currency.toUpperCase()} : ${list[_currency]}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w400),
                ),
              );
            }),
      ),
    );
  }
}
