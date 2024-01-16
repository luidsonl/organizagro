import 'package:flutter/material.dart';
import 'package:organizagro/data/models/forecast_model.dart';
import 'package:organizagro/view/widgets/weather_screen.dart/forecast_widget.dart';

class ForecastListWidget extends StatelessWidget {
  final Forecast? forecast;

  const ForecastListWidget({Key? key, required this.forecast})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final forecastList = forecast?.weatherList;

    return SingleChildScrollView(
      child: Column(
        children: forecastList?.map((weather) {
              return ForecastWidget(
                dateTime: weather.dt,
                description: weather.description,
                temperature: weather.temperature,
                iconUrl: weather.iconUrl,
              );
            }).toList() ??
            [],
      ),
    );
  }
}
