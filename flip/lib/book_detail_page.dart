import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String author;

  BookDetailPage({
    required this.imagePath,
    required this.title,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: 300,
              ),
            ),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'by $author',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Book Description',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'This is where the book description goes. You can add more details about the book, the storyline, the characters, and any other relevant information that might be interesting to the readers.',
              style: TextStyle(fontSize: 16),
            ),
            // Add more details and sections as needed
          ],
        ),
      ),
    );
  }
}
