import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_api_practice/bloc/weather_bloc.dart';
import 'package:weather_api_practice/ui/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => WeatherBloc(),
        child: HomePage(),
      ),
    );
  }
}
