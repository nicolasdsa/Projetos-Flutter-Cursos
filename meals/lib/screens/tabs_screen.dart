import 'package:flutter/material.dart';
import 'categories_screen.dart';
import 'favorite_screen.dart';
import '../components/main_drawer.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  const TabsScreen(this.favoriteMeals, {Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;

  List<Map<String, Object>>? _screens;

  @override
  void initState() {
    // Define as guias disponíveis com títulos e as telas correspondentes.
    super.initState();
    _screens = [
      {
        'title': 'Lista de Categorias',
        'screen': const CategoriesScreen(),
      },
      {
        'title': 'Meus Favoritos',
        'screen': FavoriteScreen(widget.favoriteMeals),
      },
    ];
  }

  // Função para selecionar uma guia.
  _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _screens![_selectedScreenIndex]['title'] as String,
        ),
      ),
      drawer: const MainDrawer(), // Menu de navegação lateral
      body: _screens![_selectedScreenIndex]['screen']
          as Widget, // Exibe a tela selecionada

      /*É um widget em Flutter que é usado para criar uma barra de navegação na parte inferior de uma tela. Ele é frequentemente usado em aplicativos móveis para permitir a navegação entre diferentes telas ou seções do aplicativo. A barra de navegação inferior geralmente contém ícones ou rótulos que representam as diferentes opções de navegação disponíveis.*/
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen, // Função chamada quando uma guia é tocada
        backgroundColor: Theme.of(context)
            .colorScheme
            .primary, // Cor de fundo da barra de navegação
        unselectedItemColor: Colors.white, // Cor dos ícones não selecionados
        selectedItemColor:
            Theme.of(context).colorScheme.secondary, // Cor do ícone selecionado
        currentIndex: _selectedScreenIndex, // Índice da guia selecionada
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }
}
