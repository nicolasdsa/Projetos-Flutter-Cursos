import 'package:flutter/material.dart';
import '../components/meal_item.dart';
import '../models/meal.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

// A tela FavoriteScreen exibe uma lista de refeições marcadas como favoritas.
  const FavoriteScreen(this.favoriteMeals, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      // Se não houver refeições favoritas, exibe uma mensagem informativa.
      return const Center(
        child: Text('Nenhuma refeição foi marcada como favoritas'),
      );
    } else {
      return ListView.builder(
        // Constrói um widget MealItem para cada refeição favorita na lista.
        itemCount: favoriteMeals.length,
        itemBuilder: (ctx, index) {
          return MealItem(favoriteMeals[index]);
        },
      );
    }
  }
}
