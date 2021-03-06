part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  WeatherLoaded(this.weather);
}

class WeatherSearch extends WeatherState {}

class WeatherSearchError extends WeatherState {}
