import 'package:flutter/material.dart';
import '../models/category.dart';
import '../utils/app_routes.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem(this.category, {Key? key}) : super(key: key);

  // Função chamada quando uma categoria é selecionada.
  void _selectCategory(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.categoriesMeals, // Navega para a tela de refeições da categoria
      arguments:
          category, // Passa a categoria como argumento para a próxima tela
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectCategory(
          context), // Ao tocar na categoria, chama a função _selectCategory
      splashColor:
          Theme.of(context).colorScheme.primary, // Cor do efeito de toque
      borderRadius: BorderRadius.circular(15), // Borda arredondada do contêiner
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.5), // Cor de gradiente (mais clara)
              category.color, // Cor de gradiente (mais escura)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context)
              .textTheme
              .titleLarge, // Estilo de texto com base no tema
        ),
      ),
    );
  }
}
