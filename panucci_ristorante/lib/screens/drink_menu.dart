import 'package:flutter/material.dart';
import 'package:panucci_ristorante/cardapio.dart';
import 'package:panucci_ristorante/components/drink_item.dart';

class DrinkMenu extends StatelessWidget {
  DrinkMenu({super.key});
  final List items = drinks;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return DrinkItem(
          itemTitle: items[index]['name'],
          itemPrice: items[index]['price'],
          imageURI: items[index]['image'],
        );
      },
      itemCount: items.length,
    );
  }
}
