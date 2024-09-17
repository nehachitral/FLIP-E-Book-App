import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Catcher in the Rye',
      theme: isDarkMode
          ? ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Colors.black,
            )
          : ThemeData.light().copyWith(
              scaffoldBackgroundColor: Colors.white,
            ),
      debugShowCheckedModeBanner: false,
      home: Book1Page(
        toggleTheme: () {
          setState(() {
            isDarkMode = !isDarkMode;
          });
        },
        isDarkMode: isDarkMode,
      ),
    );
  }
}

class Book1Page extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  Book1Page({required this.toggleTheme, required this.isDarkMode});

  @override
  _Book1PageState createState() => _Book1PageState();
}

class _Book1PageState extends State<Book1Page> {
  final FlutterTts flutterTts = FlutterTts();

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    final String textToRead = """
      
      
      CHAPTER-1 :



      If you really want to hear about it, the first thing you'll probably want to know is where I was
      born, an what my lousy childhood was like, and how my parents were occupied and all before
      they had me, and all that David Copperfield kind of crap, but I don't feel like going into it, if you
      want to know the truth. In the first place, that stuff bores me, and in the second place, my parents
      would have about two hemorrhages apiece if I told anything pretty personal about them. They're
      quite touchy about anything like that, especially my father. They're nice and all--I'm not saying
      that--but they're also touchy as hell. Besides, I'm not going to tell you my whole goddam
      autobiography or anything. I'll just tell you about this madman stuff that happened to me around
      last Christmas just before I got pretty run-down and had to come out here and take it easy. I mean
      that's all I told D.B. about, and he's my brother and all. He's in Hollywood. That isn't too far from
      this crumby place, and he comes over and visits me practically every week end. He's going to
      drive me home when I go home next month maybe. He just got a Jaguar. One of those little
      English jobs that can do around two hundred miles an hour. It cost him damn near four thousand
      bucks. He's got a lot of dough, now. He didn't use to. He used to be just a regular writer, when he
      was home. He wrote this terrific book of short stories, The Secret Goldfish, in case you never
      heard of him. The best one in it was "The Secret Goldfish." It was about this little kid that
      wouldn't let anybody look at his goldfish because he'd bought it with his own money. It killed me.
      Now he's out in Hollywood, D.B., being a prostitute. If there's one thing I hate, it's the movies.
      Don't even mention them to me.
      
    """;

    return Scaffold(
      appBar: AppBar(
        title: Text('The Catcher in the Rye'),
        actions: [
          IconButton(
            icon: Icon(
                widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: widget.toggleTheme,
          ),
          IconButton(
            icon: Icon(Icons.volume_up),
            onPressed: () {
              _speak(textToRead);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          textToRead,
          style: TextStyle(
            fontSize: 16.0,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
