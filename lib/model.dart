class WeatherModel {
  final String cityName;
  final double temperature;
  final int humidity;
  final double windSpeed;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] ?? "",
      temperature: json['main']['temp'] ?? "",
      humidity: json['main']['humidity'] ?? "",
      windSpeed: json['wind']['speed'] ?? "",
    );
  }
}
