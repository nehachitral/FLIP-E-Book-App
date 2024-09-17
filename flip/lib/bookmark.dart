import 'package:flutter/material.dart';

class BookmarkPage extends StatefulWidget {
  static Set<Map<String, dynamic>> items = {};

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
        backgroundColor: Color.fromARGB(255, 114, 114, 114),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: BookmarkPage.items.isEmpty
          ? Center(child: Text('No bookmarks available'))
          : ListView.builder(
              itemCount: BookmarkPage.items.length,
              itemBuilder: (context, index) {
                final item = BookmarkPage.items.elementAt(index);
                return BookCard(
                  imagePath: item['imagePath'],
                  title: item['title'],
                  author: item['author'],
                );
              },
            ),
    );
  }
}

class BookCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String author;

  const BookCard({
    required this.imagePath,
    required this.title,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200], // Set background color to light grey
      elevation: 4,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              width: 100,
              height: 150,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Author: $author',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
