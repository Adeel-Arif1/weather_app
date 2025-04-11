import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:intl/intl.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // API key
  final _weatherService = WeatherService('655052bd7338b3736153fc00c30da287');
  Weather? _weather;
  bool _isLoading = true;

  // Fetch Weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    }
    // Catch any error if there is.
    catch (e) {
      // ignore: avoid_print
      print(e);

      setState(() {
        _isLoading = false; // Show error state if data fetch fails
      });
    }
  }

  String quote = "";
  String getQuoteBasedonWeather(int? id) {
    if (id == null) {
      return "";
    }
    switch (id) {
      case > 200 && <= 300:
        return "There is beauty in the way lightning dances across the sky.";
      case >= 300 && < 400:
        return '"The mountain remains unmoved at its seeming defeat by the mist."';
      case >= 500 && < 600:
        return '"Life\'s not about waiting for the storm to pass…It\'s about learning to dance in the rain."';
      case >= 600 && < 700:
        return '"Even the strongest blizzards start with a single snowflake."';
      case >= 700 && < 800:
        return '"It is the dim haze of mystery that adds enchantment to pursuit."';
      case == 800:
        return '"Whenever you want to see me, always look at the sunset; I will be there."';
      case > 800 && <= 804:
        return '"There\'s no such thing as bad weather,just soft people"';
      default:
        return '"Think I\'d rather be asleep right now \n Dream about some mistake I made"';
    }
  }

  String getWelcomeNote(Weather? weather) {
    if (weather == null) {
      return 'Loading..';
    }
    if (weather.time.hour.toInt() >= 5 && weather.time.hour.toInt() < 12) {
      return 'Good Morning!';
    } else if (weather.time.hour.toInt() >= 12 &&
        weather.time.hour.toInt() < 18) {
      return "Good Afternoon!";
    } else if (weather.time.hour.toInt() >= 18 &&
        weather.time.hour.toInt() <= 22) {
      return "Good Evening!";
    } else {
      return 'Have a Good Night!';
    }
  }

  // Get weather animation on behalf of the current weather
  String getWeatherAnimation(int? id) {
    if (id == null) {
      return 'assets/sunny.json';
    }
    switch (id) {
      case > 200 && <= 300:
        if (_weather!.time.hour.toInt() <= 18) {
          return 'assets/thunderrainy.json';
        } else {
          return 'assets/thunderrainynight.json';
        }
      case >= 300 && < 400:
        if ((_weather!.time.hour.toInt() <= 18)) {
          return 'assets/drizzle.json';
        } else {
          return 'assets/drizzlenight.json';
        }
      case >= 500 && < 600:
        if ((_weather!.time.hour.toInt() <= 18)) {
          return 'assets/rainy.json';
        } else {
          return 'assets/rainynight.json';
        }
      case >= 600 && < 700:
        if ((_weather!.time.hour.toInt() <= 18)) {
          return 'assets/snowy.json';
        } else {
          return 'assets/snowynight.json';
        }
      case >= 700 && < 800:
        if ((_weather!.time.hour.toInt() <= 18)) {
          return 'assets/mist.json';
        } else {
          return 'assets/mistnight.json';
        }
      case == 800:
        if ((_weather!.time.hour.toInt() <= 18)) {
          return 'assets/sunny.json';
        } else {
          return 'assets/night.json';
        }
      case > 800 && <= 804:
        return 'assets/cloudy.json';
      default:
        if ((_weather!.time.hour.toInt() <= 18)) {
          return 'assets/sunny.json';
        } else {
          return 'assets/night.json';
        }
    }
  }

  String date = DateFormat('EEEE d •  hh:mm a').format(DateTime.now());
  Future<void> _refresh() async {
    await _fetchWeather();
    getWelcomeNote(_weather);
    getWeatherAnimation(_weather?.id);
    date;
  }

  @override
  void initState() {
    super.initState();
    // fetch weather on startup
    _fetchWeather();
    getWelcomeNote(_weather);
    date;
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFF7758D1),
    body: _isLoading
       
    ? Stack(
        children: [
        
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF7758D1),
                  const Color(0xFF4A3C96),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/loading.json',
                  height: 200,
                  width: 200,
                  repeat: true,
                ),
                const SizedBox(height: 20),
              
                Text(
                  "Fetching the latest weather updates... 🌤️",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                // Current Date/Time
                Text(
                  DateFormat('EEEE, MMM d • hh:mm a').format(DateTime.now()),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    
        // Rest of the page content
      

        : Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 70.0,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  // Background Circles and Box
                  Align(
                    alignment: const AlignmentDirectional(3, -0.2),
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 219, 164, 233),
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-3, -0.2),
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 219, 164, 233),
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0, -1.2),
                    child: Container(
                      height: 400,
                      width: 600,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromARGB(255, 215, 128, 255),
                      ),
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),      // Refresh Indicator
              RefreshIndicator(
                onRefresh: _refresh,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      // Content
                      Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  if (_isLoading)
                                    Center(
                                      child: Lottie.asset('assets/loading.json',
                                          height: 200,
                                          width: 200,
                                          repeat: true),
                                    )
                                  else if (_weather != null)
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          color: Colors.redAccent,
                                          size: 20, // Icon size
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          _weather?.cityName ?? "Loading city...",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    )
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                getWelcomeNote(_weather),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Center(
                                child: Lottie.asset(
                                  getWeatherAnimation(_weather?.id),
                                  repeat: true,
                                  height: 200,
                                  width: 200,
                                ),
                              ),
                              Center(
                                child: Text(
                                  '${_weather?.temperature.round()}°C',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),


                              
                              Center(
                                child: Text(
                                  'Feels like ${_weather?.feelslike.round()}°C',
                                  // \n Humidity ${_weather?.humidity}
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),

                              Center(
                                child: Text(
                                  (_weather?.mainCondition ?? "").toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Center(
                                child: Text(
                                  DateFormat('EEEE d MMM •  hh:mm a').format(
                                    _weather?.time ?? DateTime.now(),
                                  ),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/11.png',
                                          scale: 8,
                                        ),
                                        const SizedBox(width: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Sunrise',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            Text(
                                              DateFormat('hh:mm a').format(
                                                _weather?.sunrise ??
                                                    DateTime.now(),
                                              ),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(width: 50),
                                        Image.asset(
                                          'assets/12.png',
                                          scale: 8,
                                        ),
                                        const SizedBox(width: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Sunset',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            const SizedBox(height: 3),
                                            Text(
                                              DateFormat('hh:mm a').format(
                                                _weather?.sunset ??
                                                    DateTime.now(),
                                              ),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                              SingleChildScrollView(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/13.png',
                                          scale: 8,
                                        ),
                                        const SizedBox(width: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Temp Max',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            const SizedBox(height: 3),
                                            Text(
                                              '${_weather?.temperaturemax} °C',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(width: 50),
                                        Image.asset(
                                          'assets/14.png',
                                          scale: 8,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Temp Min',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            const SizedBox(height: 3),
                                            Text(
                                              '${_weather?.temperaturemin} °C',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: SizedBox(
                                  child: Text(
                                    getQuoteBasedonWeather(_weather?.id),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }
}
