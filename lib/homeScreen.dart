import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:weatherapp/service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Service service = Get.put(Service());

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 210, 219),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const SizedBox(height: 50),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Color.fromARGB(255, 225, 237, 230),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: service.text,
                            style: const TextStyle(fontSize: 20),
                            decoration: const InputDecoration(
                              hintText: "Search",
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          service.fetchWeatherData(city: service.text.text);
                          service.text.clear();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Color.fromARGB(255, 230, 195, 68),
                          ),
                          child: const Icon(Icons.search),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Obx(() {
                if (service.isLoading.value) {
                  return const CircularProgressIndicator();
                } else if (service.errorMessage.value.isNotEmpty) {
                  return Text(
                    service.errorMessage.value,
                    style: const TextStyle(fontSize: 24, color: Colors.red),
                  );
                } else if (service.weatherData.isEmpty) {
                  return const Text('No data available');
                } else {
                  return Column(
                    children: [
                      Text(
                        service.weatherData[0].cityName,
                        style: const TextStyle(fontSize: 24),
                      ),
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.asset("assets/weatherIcon.webp"),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildWeatherInfoBox(
                              "Temperature",
                              "${service.weatherData[0].temperature}°C",
                            ),
                            _buildWeatherInfoBox(
                              "Humidity",
                              "${service.weatherData[0].humidity}%",
                            ),
                            _buildWeatherInfoBox(
                              "Wind Speed",
                              "${service.weatherData[0].windSpeed} m/s",
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherInfoBox(String title, String value) {
    return Container(
      width: 120,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 168, 207, 237),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
