import 'package:flip/signin.dart';
import 'package:flutter/material.dart';

import 'package:flip/mainhome.dart';

class GenreSelectionPage extends StatefulWidget {
  const GenreSelectionPage({Key? key}) : super(key: key);

  @override
  _GenreSelectionPageState createState() => _GenreSelectionPageState();
}

class _GenreSelectionPageState extends State<GenreSelectionPage> {
  final List<String> _genres = [
    'Travel',
    'Biography',
    'Novel',
    'Art & Photography',
    'Fantasy',
    'Horror',
    'Sci-Fi',
    'Comics',
    'Adventure',
    'Romance',
    'Guide/How-to',
    'Philosophy',
    'Business',
    'Food',
  ];
  final List<String> _additionalGenres = [
    'History',
    'Mystery',
    'Poetry',
    'Science',
    'Self-help',
    'Thriller',
  ];
  final Set<String> _selectedGenres = Set<String>();
  bool _showMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/startpage/Arrow.png', // Update with the correct path to your back arrow image
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpScreen(
                        verificationId: '',
                      )),
            );
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Image.asset('assets/startpage/range.png'), // Add your image here
            const SizedBox(height: 10),
            const Text(
              'Select Genres',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8.0,
              runSpacing: 8.0,
              children: _genres.map((genre) {
                final bool isSelected = _selectedGenres.contains(genre);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedGenres.remove(genre);
                      } else {
                        _selectedGenres.add(genre);
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 25.0,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF0D6EFD)
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Text(
                      genre,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            if (_showMore) ...[
              const SizedBox(height: 15), // Gap after "Show more"
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 10.0,
                runSpacing: 10.0,
                children: _additionalGenres.map((genre) {
                  final bool isSelected = _selectedGenres.contains(genre);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedGenres.remove(genre);
                        } else {
                          _selectedGenres.add(genre);
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF0D6EFD)
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(33.0),
                      ),
                      child: Text(
                        genre,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : const Color.fromARGB(255, 11, 11, 11),
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                setState(() {
                  _showMore = !_showMore;
                });
              },
              child: Text(
                _showMore ? 'Show less' : 'Show more',
                style: const TextStyle(
                  color: Color(0xFF0D6EFD),
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            const SizedBox(height: 20), // Increased gap after "Show more"
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainHomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D6EFD),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 150,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Next',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
