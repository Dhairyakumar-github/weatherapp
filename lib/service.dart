import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/model.dart';
import 'package:http/http.dart' as http;

class Service extends GetxController {
  var weatherData = <WeatherModel>[].obs;
  TextEditingController text = TextEditingController();
  var errorMessage = ''.obs;
  var isLoading = false.obs;
  final apiKey = "34aa2088397eb8d9e36e3fa088632f3c";
  @override
  void onInit() {
    fetchWeatherData(city: "ahmedabad");
    super.onInit();
  }

  Future<void> fetchWeatherData({String city = "ahmedabad"}) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final response = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        weatherData.clear();
        weatherData.add(WeatherModel.fromJson(data));
        // print(data);

        // print(weatherData);
      } else {
        errorMessage.value = "City not found";
      }
    } catch (e) {
      errorMessage.value = "Something went wrong";
    } finally {
      isLoading.value = false;
    }
  }
}
