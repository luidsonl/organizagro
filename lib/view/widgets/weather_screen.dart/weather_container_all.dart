import 'package:flutter/material.dart';

class WeatherContainerAll extends StatelessWidget {
  final Widget child;
  const WeatherContainerAll({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, 0.5),
              borderRadius: BorderRadius.circular(20)),
          child: child,
        ),
      ),
    );
  }
}
