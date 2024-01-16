import 'package:flutter/material.dart';
import 'package:organizagro/view/screens/about_screen.dart';
import 'package:organizagro/view/screens/cash_transaction_screen.dart';
import 'package:organizagro/view/screens/inventory_category_screen.dart';
import 'package:organizagro/view/screens/main_inventory_screen.dart';
import 'package:organizagro/view/screens/weather_screen.dart';

void main() {
  runApp(const Organizagro());
}

class Organizagro extends StatelessWidget {
  const Organizagro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Organizagro',
      initialRoute: MainInventoryScreen.name,
      routes: {
        MainInventoryScreen.name: (_) => const MainInventoryScreen(),
        InventoryCategoryScreen.name: (_) => const InventoryCategoryScreen(),
        CashTransactionScreen.name: (_) => const CashTransactionScreen(),
        WeatherScreen.name: (_) => const WeatherScreen(),
        AboutScreen.name: (_) => const AboutScreen(),
      },
    );
  }
}
