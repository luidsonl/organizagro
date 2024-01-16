import 'package:flutter/material.dart';
import 'package:organizagro/view/screens/about_screen.dart';
import 'package:organizagro/view/screens/cash_transaction_screen.dart';
import 'package:organizagro/view/screens/main_inventory_screen.dart';
import 'package:organizagro/view/screens/weather_screen.dart';

class OrganizagroDrawer extends StatelessWidget {
  const OrganizagroDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Row(
                children: [
                  Text(
                    'Organizagro',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.agriculture_outlined,
                    color: Colors.white,
                    size: 30,
                  )
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Estoque'),
            onTap: () {
              // Implemente a navegação para a página inicial aqui
              Navigator.pop(context);
              Navigator.popAndPushNamed(context, MainInventoryScreen.name);
            },
          ),
          ListTile(
            leading: const Icon(Icons.monetization_on),
            title: const Text('Financeiro'),
            onTap: () {
              // Implemente a navegação para a página de configurações aqui
              Navigator.pop(context);
              Navigator.popAndPushNamed(context, CashTransactionScreen.name);
            },
          ),
          ListTile(
            leading: const Icon(Icons.cloud),
            title: const Text('Tempo'),
            onTap: () {
              // Implemente a navegação para a página de configurações aqui
              Navigator.pop(context);
              Navigator.popAndPushNamed(context, WeatherScreen.name);
            },
          ),
          ListTile(
            leading: const Icon(Icons.error_outline_rounded),
            title: const Text('Sobre o App'),
            onTap: () {
              // Implemente a navegação para a página de configurações aqui
              Navigator.pop(context);
              Navigator.popAndPushNamed(context, AboutScreen.name);
            },
          ),
        ],
      ),
    );
  }
}
