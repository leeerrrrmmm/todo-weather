
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/weather.dart';

class Responses {
  final key = 'a72802eb757a9ba8a284fe8e40730964';


  Future<Weather> fetchData() async {
    try{
      final response = await http.get(
        Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=49.9935&lon=36.2304&appid=$key')
      );

      if(response.statusCode == 500){
        throw Exception('Internal Server Error');
      }else if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        return Weather.fromJson(data);
      }else{
        throw Exception('Fail fetch data');
      }
    }
    catch(e) {
      throw Exception('Error: $e');
    }
  }
}