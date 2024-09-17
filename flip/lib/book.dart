import 'package:flutter/material.dart';

class Book {
  final String imagePath;
  final String title;
  final String author;
  final String category;
  final Widget page;

  Book({
    required this.imagePath,
    required this.title,
    required this.author,
    required this.category,
    required this.page,
  });
}
