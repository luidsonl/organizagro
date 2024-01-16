class ForecastTimestemp {
  final int dt;
  final double temperature;
  final String mainCondition;
  final String description;
  final String iconUrl;

  ForecastTimestemp({
    required this.dt,
    required this.temperature,
    required this.mainCondition,
    required this.description,
    required this.iconUrl,
  });

  factory ForecastTimestemp.fromJson(Map<String, dynamic> json) {
    return ForecastTimestemp(
      dt: json['dt'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      iconUrl:
          'https://openweathermap.org/img/wn/${json['weather'][0]['icon']}.png',
    );
  }
}

class Forecast {
  final List<ForecastTimestemp> weatherList;

  Forecast({
    required this.weatherList,
  });

  factory Forecast.fromJsonList(List<dynamic> list) {
    List<ForecastTimestemp> weatherList =
        list.map((item) => ForecastTimestemp.fromJson(item)).toList();

    return Forecast(
      weatherList: weatherList,
    );
  }
}
