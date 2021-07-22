class Weather {
  final String city;
  final double temperature;
  final String weather;
  final int humidity;
  final double wind;

  Weather({
    this.city,
    this.temperature,
    this.weather,
    this.humidity,
    this.wind,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['main']['temp'].toDouble(),
      weather: json['weather'][0]['main'],
      humidity: json['main']['humidity'].toInt(),
      wind: json['wind']['speed'].toDouble(),
      city: json['name'],
    );
  }
}
