import 'package:flutter/material.dart';
import 'package:panucci_ristorante/cardapio.dart';
import 'package:panucci_ristorante/components/highlight_item.dart';

class Highlights extends StatelessWidget {
  const Highlights({Key? key}) : super(key: key);
  final List items = destaques;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
        child: CustomScrollView(slivers: <Widget>[
          const SliverToBoxAdapter(
              child: Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              "Destaques",
              style: TextStyle(fontFamily: 'Caveat', fontSize: 32),
              textAlign: TextAlign.center,
            ),
          )),
          MediaQuery.of(context).orientation == Orientation.landscape
              ? const _landscapeList()
              : const _portraitList()
        ]));
  }
}

class _portraitList extends StatelessWidget {
  const _portraitList();
  final List items = destaques;

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return HighlightItem(
        imageURI: items[index]['image'],
        itemTitle: items[index]['name'],
        itemPrice: items[index]['price'],
        itemDescription: items[index]['description'],
      );
    }, childCount: items.length));
  }
}

class _landscapeList extends StatelessWidget {
  const _landscapeList({Key? key}) : super(key: key);

  final List items = destaques;
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          return HighlightItem(
              imageURI: items[index]['image'],
              itemTitle: items[index]['name'],
              itemPrice: items[index]['price'],
              itemDescription: items[index]['description']);
        }, childCount: items.length),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.9));
  }
}
