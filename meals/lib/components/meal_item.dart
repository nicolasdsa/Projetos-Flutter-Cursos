import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../utils/app_routes.dart';

class MealItem extends StatelessWidget {
  final Meal meal;

  const MealItem(this.meal, {Key? key}) : super(key: key);

  // Função chamada quando um item de refeição é selecionado.
  void _selectMeal(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
      AppRoutes.mealDetail, // Navega para a tela de detalhes da refeição
      arguments: meal, // Passa a refeição como argumento para a próxima tela
    )
        .then((result) {
      if (result == null) {
        print('Sem resultado!');
      } else {
        print('O nome da refeição é $result.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    /* é um widget em Flutter que é frequentemente usado para tornar outros widgets interativos, permitindo que eles respondam a toques do usuário, como toques, pressões longas e arrastar. Ele é uma parte importante para adicionar feedback visual a elementos da interface do usuário e criar interações com o usuário.*/
    return InkWell(
      onTap: () => _selectMeal(
          context), // Ao tocar no item da refeição, chama a função _selectMeal
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Borda arredondada do card
        ),
        elevation: 4,
        margin: const EdgeInsets.all(10), // Margem ao redor do card
        child: Column(
          children: [
            Stack(
              children: [
                /* é um widget em Flutter usado para recortar seu filho (child) em uma forma retangular arredondada. Ele permite que você crie caixas com cantos arredondados ou arredonda as bordas de elementos como imagens, criando uma aparência visual agradável.*/
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    meal.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      meal.title,
                      style: const TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.schedule),
                      const SizedBox(width: 6),
                      Text('${meal.duration} min'),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.work),
                      const SizedBox(width: 6),
                      Text(meal.complexityText),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.attach_money),
                      const SizedBox(width: 6),
                      Text(meal.costText),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
