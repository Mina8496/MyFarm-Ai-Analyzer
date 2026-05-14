import 'package:flutter/material.dart';
import 'package:myfarm/features/Home/presentation/view/widget/show_data_weater_card.dart';

class WeatherSuccessCard extends StatelessWidget {
  const WeatherSuccessCard({super.key, 
    required this.data,
    required this.icon,
    required this.description,
  });

  final Map<String, dynamic> data;
  final String icon;
  final String description;

  Map<String, dynamic> get _current => data['current'];
  double get _temp        => _current['temperature_2m'];
  double get _feelsLike   => _current['apparent_temperature'];
  int    get _humidity    => _current['relative_humidity_2m'];
  double get _windSpeed   => _current['wind_speed_10m'];

  @override
  Widget build(BuildContext context) {
    return ShowDataWeaterCard(
      temp: _temp,
      description: description,
      icon: icon,
      feelsLike: _feelsLike,
      humidity: _humidity,
      windSpeed: _windSpeed,
    );
  }
}