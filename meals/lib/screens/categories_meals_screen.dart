import 'package:flutter/material.dart';
import '../components/meal_item.dart';
import '../models/category.dart';
import '../models/meal.dart';

class CategoriesMealsScreen extends StatelessWidget {
  final List<Meal> meals;

  // Construtor que recebe a lista de refeições relacionadas à categoria.
  const CategoriesMealsScreen(this.meals, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtém a categoria selecionada passada como argumento da rota.
    final category = ModalRoute.of(context)!.settings.arguments as Category;

    // Filtra as refeições que pertencem à categoria selecionada.
    final categoryMeals = meals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();

    return Scaffold(
      appBar: AppBar(
          title: Text(category
              .title) // Define o título da AppBar com o nome da categoria.,
          ),
      /* Um widget ListView em Flutter cria uma lista rolável de widgets filhos em uma direção única (vertical ou horizontal). É amplamente usado para exibir uma lista de itens que podem ser rolados para cima ou para baixo (ou para a esquerda ou direita em um ListView horizontal),npermitindo que o usuário visualize os itens que não cabem na tela simultaneamente. O ListView é eficiente, reciclando widgets fora da tela e criando novos widgets à medida que o usuário rola, economizando recursos. Pode ser personalizado com diferentes tipos de ListView, como ListView.builder, ListView.separated, entre outros, para atender às necessidades de layout específicas.*/
      body: ListView.builder(
        itemCount: categoryMeals.length,
        itemBuilder: (ctx, index) {
          // Constrói uma lista de itens de refeição para a categoria selecionada.
          return MealItem(categoryMeals[index]);
        },
      ),
    );
  }
}
