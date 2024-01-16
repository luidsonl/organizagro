import 'package:flutter/material.dart';

class CityName extends StatelessWidget {
  final dynamic cityName;

  const CityName({super.key, this.cityName});

  @override
  Widget build(BuildContext context) {
    return Text(
      cityName ?? "Carregando ...",
      style: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }
}
