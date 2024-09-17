import 'package:flutter/material.dart';
import 'package:flip/start.dart'; // Update with the correct path to start2.dart
import 'package:flip/signin.dart'; // Update with the correct path to signin.dart

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 40, // Adjust this value to control the space from the top
            left: 0,
            right: 0,
            child: Center(
              child: ClipRect(
                child: Container(
                  width: 340,
                  height: 350,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage("assets/startpage/Study.png"),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 7), // shadow only below the image
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top:
                23, // Adjust this value to place "skip" text at the right corner
            right: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInPage()),
                );
              },
              child: const Text(
                "Skip",
                style: TextStyle(
                  color: Color.fromARGB(255, 5, 5, 5),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
          Positioned(
            top:
                370, // Adjust this value to place the small image below the main image
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                "assets/startpage/slide.png", // Your small image asset
                width: 100, // Adjust size as needed
                height: 100, // Adjust size as needed
              ),
            ),
          ),
          Positioned(
            top: 440, // Adjust this value for descriptive text position
            left: 30,
            right: 30,
            child: Column(
              children: [
                const Text(
                  "Read your favourite books",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 20), // Space between the two texts
                const Text(
                  "All your favourites book in one place, read any book, staying at home, on travelling, or anywhere else",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom:
                30, // Adjust this value for the "Get Started" button position
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Start2Page()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      255, 136, 201, 231), // Background color
                  foregroundColor: Color(0xFF0D6EFD), // Text color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/startpage/Icon.png', // Your image asset for the icon
                      width: 24, // Adjust size as needed
                      height: 24, // Adjust size as needed
                    ),
                    const SizedBox(
                        width: 8), // Space between the icon and the text
                    const Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF0D6EFD),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor:
          const Color.fromARGB(255, 245, 243, 243), // Set background color
    );
  }
}
