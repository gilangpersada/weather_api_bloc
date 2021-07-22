part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class GetWeatherFromSearch extends WeatherEvent {
  final String cityName;

  GetWeatherFromSearch({this.cityName});
}

class ResetWeather extends WeatherEvent {}
