class Weather {
  final String country;
  final String name;
  final String main;
  final double temperature;
  final double humidity;
  final String description;

  Weather({
    required this.country,
    required this.name,
    required this.main,
    required this.temperature,
    required this.humidity,
    required this.description,
  });


  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      country: json['sys']['country'],
      name: json['name'],
      main: json['weather'][0]['main'],
      temperature: json['main']['temp'],
      humidity: json['main']['humidity'],
      description: json['weather'][0]['description'],
    );
  }
}
