import 'package:flutter/material.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final dynamic temperature;
  final dynamic description;
  final dynamic iconUrl;

  const CurrentWeatherWidget(
      {super.key, this.temperature, this.description, this.iconUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Center(
        child: Column(children: [
          iconUrl != null
              ? Image.network(
                  iconUrl,
                  width: 200,
                  height: 200,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          Text(
            '${temperature?.round().toString()}°C',
            style: const TextStyle(fontSize: 30.0),
          ),
          Text(description ?? "Carregando ...",
              style: const TextStyle(fontSize: 20.0)),
        ]),
      ),
    );
  }
}
