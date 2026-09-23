import 'package:flutter/material.dart';
import 'package:liquid_tabbar_minimize/liquid_tabbar_minimize.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../favorites/ui/screens/favorites_screen.dart';
import '../../../home/ui/screens/home_screen.dart';
import '../../../info/ui/screens/info_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    FavoritesScreen(),
    InfoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: LiquidBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        labelVisibility: LabelVisibility.always,
        items: const [
          LiquidTabItem(
            widget: Icon(Icons.home_outlined),
            selectedWidget: Icon(Icons.home_rounded),
            sfSymbol: 'house',
            selectedSfSymbol: 'house.fill',
            label: 'Inicio',
          ),
          LiquidTabItem(
            widget: Icon(Icons.favorite_border_rounded),
            selectedWidget: Icon(Icons.favorite_rounded),
            sfSymbol: 'heart',
            selectedSfSymbol: 'heart.fill',
            label: 'Favoritos',
          ),
          LiquidTabItem(
            widget: Icon(Icons.info_outline_rounded),
            selectedWidget: Icon(Icons.info_rounded),
            sfSymbol: 'info.circle',
            selectedSfSymbol: 'info.circle.fill',
            label: 'Información',
          ),
        ],
        forceCustomBar: true,
      ),
    );
  }
}
