import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_api_practice/model/weather.dart';
import 'package:http/http.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeatherFromSearch) {
      yield WeatherSearch();

      try {
        final weather = await _fetchWeatherApi(event.cityName);
        yield WeatherLoaded(weather);
      } catch (exception) {
        yield WeatherSearchError();
        print(exception);
      }
    } else if (event is ResetWeather) {
      yield WeatherInitial();
    }
  }

  Future<Weather> _fetchWeatherApi(String cityName) async {
    final String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=223c5b87825825338bbf3eb6cc4b5d93';
    final response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception();
    }
  }
}
