import 'package:flutter/material.dart';
import 'package:weather_app/service/weather_service.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService =
      WeatherService(apiKey: '97ca88dce10a469d2823873de2c8ed3f');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherIcon(String mainCondition) {
    switch (mainCondition) {
      case 'Thunderstorm':
        return 'assets/thunderStorm.json';
      case 'Drizzle':
        return 'assets/lightShowers.json';
      case 'Rain':
        return 'assets/lightShowers.json';
      case 'Snow':
        return 'assets/snow.json';
      case 'Clear':
        return 'assets/sunny.json';
      case 'Clouds':
        return 'assets/cloud.json';
      case 'Mist':
        return 'assets/windy.json';
      case 'Fog':
        return 'assets/windy.json';
      case 'Windy':
        return 'assets/windy.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
                const SizedBox(width: 8.0),
                Text(
                  _weather?.cityName ?? "Loading...",
                  style: GoogleFonts.notoSans(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            Lottie.asset(getWeatherIcon(_weather?.mainCondition ?? "")),
            Text(
              _weather?.mainCondition ?? "Loading...",
              style: GoogleFonts.montserrat(
                color: Colors.grey,
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                '${_weather?.temperature.round()}°C',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
