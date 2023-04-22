import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Grocery store app',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.teal),
            ),
            const SizedBox(height: 20),
            Image.asset('images/store.jpg'),
            const SizedBox(height: 10),
            const CircularProgressIndicator(
              backgroundColor: Colors.teal,
              color: Colors.cyan,
            ),
          ],
        ),
      ),
    );
  }
}
