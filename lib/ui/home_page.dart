import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_api_practice/bloc/weather_bloc.dart';
import 'package:weather_api_practice/model/weather.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherInitial) {
              return searchState(context, state);
            } else if (state is WeatherSearch) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WeatherLoaded) {
              return weatherState(state.weather, context);
            } else if (state is WeatherSearchError) {
              return searchState(context, state);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget searchState(BuildContext context, state) {
    searchController.text = '';
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Search City Weather',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          width: MediaQuery.of(context).size.width / 2,
          child: TextFormField(
            controller: searchController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Search City",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        ),
        (state is WeatherSearchError) ? Text('City not found!') : Container(),
        SizedBox(
          height: 24,
        ),
        GestureDetector(
          onTap: () {
            context.read<WeatherBloc>().add(
                  GetWeatherFromSearch(cityName: searchController.text),
                );
          },
          child: Container(
            padding: EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width / 3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.black),
            child: Center(
              child: Text(
                'Search',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget weatherState(Weather weather, BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          color: Colors.yellow,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${weather.temperature.round()}\u00B0C',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '${weather.city}',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                  onTap: () {
                    context.read<WeatherBloc>().add(ResetWeather());
                  },
                  child: Text('Back'))
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.thermostat_rounded),
                  title: Text('Temperature'),
                  trailing: Text('${weather.temperature.round()}\u00B0C'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.cloud),
                  title: Text('Weather'),
                  trailing: Text('${weather.weather}'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.ac_unit),
                  title: Text('Humidity'),
                  trailing: Text('${weather.humidity}%'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.assistant_photo_sharp),
                  title: Text('Wind'),
                  trailing: Text('${weather.wind}km/hr'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
