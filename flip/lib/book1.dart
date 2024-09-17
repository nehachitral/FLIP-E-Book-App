import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'cart.dart'; // Import CartPage
import 'bookmark.dart'; // Import BookmarkPage
import 'Bookpage1.dart'; // Import Book1ReadPage

class Book1 extends StatefulWidget {
  @override
  _Book1State createState() => _Book1State();
}

class _Book1State extends State<Book1> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    // Check initial bookmark status
    isBookmarked = BookmarkPage.items.any((item) =>
        item['title'] == 'Catcher in the Rye' &&
        item['author'] == 'J.D. Salinger');
  }

  void toggleBookmark() {
    setState(() {
      if (!isBookmarked) {
        BookmarkPage.items.add({
          'imagePath': 'assets/startpage/book1(2).png',
          'title': 'Catcher in the Rye',
          'author': 'J.D. Salinger',
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Book bookmarked!'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        BookmarkPage.items.removeWhere((item) =>
            item['title'] == 'Catcher in the Rye' &&
            item['author'] == 'J.D. Salinger');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Book removed from bookmarks.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
      isBookmarked = !isBookmarked;
    });
  }

  Future<void> addToCart() async {
    // Add item to local cart
    Cart.items.add({
      'image': 'assets/startpage/book1(2).png',
      'title': 'Catcher in the Rye',
      'author': 'J.D. Salinger',
      'price': 10.99, // Replace with actual price
      'quantity': 1,
    });

    // Update Firestore cart collection
    try {
      await _firestore.collection('cart_items').add({
        'image': 'assets/startpage/book1(2).png',
        'title': 'Catcher in the Rye',
        'author': 'J.D. Salinger',
        'price': 10.99,
        'quantity': 1,
      });

      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Added to Cart'),
            content: Text(
                'Catcher in the Rye has been successfully added to the cart!'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (error) {
      // Handle error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to add to cart: $error'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarked ? Colors.red : null,
            ),
            onPressed: toggleBookmark,
          ),
        ],
        title: Text('Book Detail'),
      ),
      body: Container(
        color: const Color.fromARGB(255, 243, 242, 242),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/startpage/book1(2).png',
                height: 140,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Catcher in the Rye',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'J.D. Salinger',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star_border),
                SizedBox(width: 8),
                Text('4.0', style: TextStyle(fontSize: 18)),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'About the author',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'J.D. Salinger was an American writer, best known for his 1951 novel The Catcher in the Rye. Before its publication, Salinger published several short stories in Story magazine.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'The Catcher in the Rye is a novel by J. D. Salinger, partially published in serial form in 1945-1946 and as a novel in 1951. It was originally intended for adults but is often read by adolescents for its theme of angst, alienation, and as a critique of superficiality in society.',
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to Book1ReadPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MyApp()), // Corrected navigation
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    child: Text('Read Preview'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: addToCart,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                    ),
                    child: Text(' + Add to Cart'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
