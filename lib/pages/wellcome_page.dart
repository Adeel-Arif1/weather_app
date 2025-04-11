import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'weather_page.dart';

class WeatherWelcomePage extends StatelessWidget {
  const WeatherWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7758D1), Color.fromARGB(255, 219, 164, 233)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie animation
            Center(
              child: Lottie.asset('assets/Animation.json', height: 300, width: 300),
            ),
            SizedBox(height: 30),
            Text(
              'WEATHER',
              style: TextStyle(
                fontSize: 48,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(blurRadius: 5, color: Colors.black.withOpacity(0.5))],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Fore Casts',
              style: TextStyle(
                fontSize: 36,
                color: Color(0xFFEED202), 
                fontWeight: FontWeight.w600,
                shadows: [Shadow(blurRadius: 3, color: Colors.black.withOpacity(0.3))],
              ),
            ),
            SizedBox(height: 150),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFDDB130),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
              ),
              onPressed: () {
                // Add your navigation logic here
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherPage()));
              },
              child: Text(
                'Get Started',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
