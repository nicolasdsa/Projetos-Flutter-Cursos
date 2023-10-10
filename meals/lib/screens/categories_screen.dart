import 'package:flutter/material.dart';
import '../components/category_item.dart';
import '../data/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*é um widget em Flutter que permite criar uma grade de itens dispostos em linhas e colunas. Ele é usado para exibir uma coleção de itens de forma organizada e flexível, onde cada item pode ser personalizado e posicionado em células da grade*/
    return GridView(
      padding: const EdgeInsets.all(25),
      /* É uma classe em Flutter que define a estrutura de layout para um GridView quando você deseja especificar o tamanho máximo do eixo transversal (cross-axis) dos itens da grade*/
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200, // Tamanho máximo no eixo transversal
        childAspectRatio: 3 / 2, // Proporção largura/altura dos itens
        crossAxisSpacing: 20, // Espaçamento entre os itens no eixo transversal
        mainAxisSpacing: 20, // Espaçamento entre os itens no eixo principal
      ),
      children: dummyCategories.map((cat) {
        // Cria um widget de CategoryItem para cada categoria no dummyCategories.
        return CategoryItem(cat);
      }).toList(),
    );
  }
}
