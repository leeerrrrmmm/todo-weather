import 'package:flutter/material.dart';
import '../WEATHER/api/weather_api.dart';
import '../WEATHER/model/weather.dart';


class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  bool _isLoading = false;
  final Responses _responses = Responses();
  Weather? _weather;

  Future<void> fetchDataFromApi() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await _responses.fetchData();
      setState(() {
        _weather = response;
        _isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _weather == null
          ? const Center(child: Text('No data available'))
          : Center(
            child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(15)
                    ),
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Місто: ${_weather!.name}, ${_weather!.country}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text('Погода: ${_weather!.main}',style:TextStyle(color:Colors.white,fontSize: 16)),
                            Text('Опис: ${_weather!.description}',style:TextStyle(color:Colors.white,fontSize: 16)),
                            Text('Температура: ${_weather!.temperature}°C',style:TextStyle(color:Colors.white,fontSize: 16)),
                            Text('Вологість: ${_weather!.humidity}%',style:TextStyle(color:Colors.white,fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
                    ),
                  ),
          ),
    );
  }
}
