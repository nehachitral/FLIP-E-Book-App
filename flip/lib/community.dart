import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Chat.dart';
import 'mainhome.dart';
import 'bookmark.dart';
import 'Profile.dart';
import 'dictionary.dart'; // Import the new dictionary page

class CommunityPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Community',
          style: TextStyle(color: Color.fromARGB(4, 51, 51, 52)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.create),
            onPressed: () {
              // Implement create new group functionality
            },
          ),
        ],
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search, color: Colors.blue),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
              ),
            ),
          ),
          // Adding the Dictionary option with the updated design
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: ListTile(
                leading: Icon(Icons.book, color: Colors.blue),
                title: Text('Dictionary'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DictionaryPage(), // Navigate to the new dictionary page
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildChatTile(
                  context,
                  'Technically yours',
                  'You: What\'s man!',
                  '9:40 AM',
                  'assets/startpage/technically_yours.png',
                ),
                _buildChatTile(
                  context,
                  'Night of terror',
                  'You: Ok, thanks!',
                  '9:25 AM',
                  'assets/startpage/night_of_terror.png',
                ),
                _buildChatTile(
                  context,
                  'The lost world',
                  'You: Ok, See you in To...',
                  'Fri',
                  'assets/startpage/the_lost_world.png',
                ),
                _buildChatTile(
                  context,
                  'Harry Potter',
                  'Have a good day, Maisy!',
                  'Fri',
                  'assets/startpage/harry_potter.png',
                ),
                _buildChatTile(
                  context,
                  'A new way food',
                  'The business plan loo...',
                  'Thu',
                  'assets/startpage/a_new_way_food.png',
                ),
                _buildChatTile(
                  context,
                  'The tales of Thames',
                  'The business plan loo...',
                  'Thu',
                  'assets/startpage/the_tales_of_thames.png',
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainHomePage()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookmarkPage()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CommunityPage()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Books',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  void _saveChatTileToFirebase(
      String title, String subtitle, String time, String avatar) async {
    await _firestore.collection('chat_tiles').add({
      'title': title,
      'subtitle': subtitle,
      'time': time,
      'avatar': avatar,
      'timestamp': DateTime.now(),
    });
  }

  Widget _buildChatTile(
    BuildContext context,
    String title,
    String subtitle,
    String time,
    String avatar,
  ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(avatar),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text(time),
      onTap: () {
        _saveChatTileToFirebase(title, subtitle, time, avatar);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatPage(title: title)),
        );
      },
    );
  }
}
