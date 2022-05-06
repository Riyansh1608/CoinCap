import 'package:coincap/pages/details_page.dart';
import 'package:flutter/material.dart';

class Country extends StatelessWidget {
  final Map llist;
  final String selectedCoin;
  const Country({required this.llist, required this.selectedCoin});

  @override
  Widget build(BuildContext context) {
    List curCon = llist.keys.toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 23, 7, 82),
        title: const Text(
          "Country",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: curCon.length,
          itemBuilder: (context, index) {
            String s = curCon[index];
            return ListTile(
              leading: Icon(Icons.no_drinks),
              title: Text(
                "${s.toUpperCase()} : ${llist[s]}",
                style: const TextStyle(color: Colors.black, fontSize: 22),
              ),
              subtitle: const Text("subtitle"),
              trailing: const Icon(Icons.flag),
              iconColor: Colors.pink,
              tileColor: Color.fromARGB(255, 180, 178, 169),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext _context) {
                      return Details(list: llist, coin: selectedCoin);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
