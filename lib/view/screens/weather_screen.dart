import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:organizagro/constants/api_key.dart';
import 'package:organizagro/data/models/coordinates_model.dart';
import 'package:organizagro/data/models/forecast_model.dart';
import 'package:organizagro/data/models/weather_model.dart';
import 'package:organizagro/services/weather_service.dart';
import 'package:organizagro/view/widgets/organizagro_drawer.dart';
import 'package:organizagro/view/widgets/weather_screen.dart/city_name.dart';
import 'package:organizagro/view/widgets/weather_screen.dart/city_search_form.dart';
import 'package:organizagro/view/widgets/weather_screen.dart/current_weather_widget.dart';
import 'package:organizagro/view/widgets/weather_screen.dart/forecast_list_widget.dart';
import 'package:organizagro/view/widgets/weather_screen.dart/weather_container_all.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});
  static const name = '/weather_screen';

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService(Env().apiKey);

  Weather? _currentWeather;
  Forecast? _weatherForecast;
  bool _showWeather = false;
  Coordinates? location;

  _updateCurrentLocation() async {
    final Position currentPosition = await _weatherService.getCurrentPosition();

    setState(() {
      location = Coordinates(
          lat: currentPosition.latitude, lon: currentPosition.longitude);
    });
    _fecthWeather();
  }

  _updateCityLocation(city) async {
    final Coordinates cityLocation = await _weatherService.getCityBySearch(
        cityName: city, apiKey: Env().apiKey);

    setState(() {
      location = cityLocation;
    });

    _fecthWeather();
  }

  _fecthWeather() async {
    try {
      final Weather currentWeather =
          await _weatherService.getCurrentWeather(location!.lat, location!.lon);

      setState(() {
        _currentWeather = currentWeather;
      });
    } catch (e) {
      throw Exception(e);
    }
    try {
      final Forecast weatherForecast = await _weatherService.getWeatherForecast(
          location!.lat, location!.lon);

      setState(() {
        _weatherForecast = weatherForecast;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  //inicia o estado
  @override
  void initState() {
    super.initState();
    _initLocalWeather();
  }

  //Atualiza o clima do local atual
  void _initLocalWeather() {
    setState(() {
      _showWeather = true;
    });
    _updateCurrentLocation();
  }

  //Atualiza o clima do local atual
  void _searchCityWeather(city) {
    setState(() {
      _showWeather = true;
    });
    _updateCityLocation(city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const OrganizagroDrawer(),
      appBar: AppBar(
        title: const Text('Previsão do tempo'),
      ),
      body: WeatherContainerAll(
        child: Column(
          children: [
            _showWeather
                ? Column(
                    children: [
                      CitySearchForm(
                        onSearch: (String value) {
                          _searchCityWeather(value);
                        },
                      ),
                      CityName(
                        cityName: _currentWeather?.cityName,
                      ),
                      CurrentWeatherWidget(
                        temperature: _currentWeather?.temperature,
                        description: _currentWeather?.description,
                        iconUrl: _currentWeather?.iconUrl,
                      ),
                      ForecastListWidget(forecast: _weatherForecast)
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
