class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final String description;
  final String iconUrl;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.description,
    required this.iconUrl,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      iconUrl:
          'https://openweathermap.org/img/wn/${json['weather'][0]['icon']}@2x.png',
    );
  }
}
