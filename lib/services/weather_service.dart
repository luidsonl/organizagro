import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:organizagro/data/models/coordinates_model.dart';
import 'package:organizagro/data/models/forecast_model.dart';
import 'package:organizagro/data/models/weather_model.dart';

class WeatherService {
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getCurrentWeather(double lat, double lon) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric&lang=pt_br'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar dados');
    }
  }

  Future<Forecast> getWeatherForecast(double lat, double lon) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric&lang=pt_br'));
    if (response.statusCode == 200) {
      return Forecast.fromJsonList(jsonDecode(response.body)['list']);
    } else {
      throw Exception('Falha ao carregar dados');
    }
  }

  Future<Position> getCurrentPosition() async {
    //checa permissão e pede a permissão para o usuário
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    //fetch da posição atual
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }

  Future<Coordinates> getCityBySearch(
      {required cityName, required apiKey}) async {
    final response = await http.get(Uri.parse(
        'http://api.openweathermap.org/geo/1.0/direct?q=$cityName,br&appid=$apiKey'));
    if (response.statusCode == 200) {
      final Coordinates location = Coordinates(
          lat: jsonDecode(response.body)[0]['lat'],
          lon: jsonDecode(response.body)[0]['lon']);

      return location;
    } else {
      throw Exception('Falha ao carregar dados');
    }
  }
}
