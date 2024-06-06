import 'package:alt/about.dart';
import 'package:alt/authentication.dart';
import 'package:alt/booklet.dart';
import 'package:alt/findlawyer.dart';
import 'package:alt/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'chatbot.dart';
import 'contact.dart';
import 'firebase_options.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        // Use a FutureBuilder to handle asynchronous initialization
        future: Future.delayed(Duration(seconds: 2), () => Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        )),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen(); // Display the loading screen with company logo while initializing
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('Error initializing Firebase'), // Display an error message if initialization fails
              ),
            );
          } else {
            return HomePage(); // Once initialization is complete, switch to HomePage
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late YoutubePlayerController _youtubeController;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _youtubeController = YoutubePlayerController(
      initialVideoId: 'skUgnOB4cPM',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  void _showLoginPopup() {
    showDialog(
      context: context,
      builder: (context) => AuthenticationPage(),
    );
  }

  void _onFindLawyerPressed() {
    User? user = _auth.currentUser;
    if (user == null) {
      _showLoginPopup();
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FindLawyerPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: Center(
                child: Text(
                  'Project ALT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text('Login', style: TextStyle(color: Colors.brown)),
              onTap: () {
                Navigator.pop(context);
                _showLoginPopup();
              },
            ),
            ListTile(
              title: Text('Find Lawyer', style: TextStyle(color: Colors.brown)),
              onTap: () {
                Navigator.pop(context);
                _onFindLawyerPressed();
              },
            ),
            ListTile(
              title: Text('Legal Literacy Module', style: TextStyle(color: Colors.brown)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookletPage()),
                );
              },
            ),
            ListTile(
              title: Text('About Us', style: TextStyle(color: Colors.brown)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
            ),
            ListTile(
              title: Text('Contact Us', style: TextStyle(color: Colors.brown)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactUs()),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatbotPage()),
          );
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.chat),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 150.0,
            floating: false,
            pinned: true,
            leading: Container(),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.orange,
                  size: 40.0,
                ),
                onPressed: () {
                  _scaffoldKey.currentState!.openEndDrawer();
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                margin: EdgeInsets.only(top: 50.0),
                child: Image.asset(
                  'assets/PSC-LOGO.png',
                  fit: BoxFit.contain,
                  alignment: Alignment.topLeft,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.orange,
                    width: 7.0,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                color: Colors.red,
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    YoutubePlayer(
                      controller: _youtubeController,
                      showVideoProgressIndicator: false,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Struggling to find legal Aid ?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Our Non Profit Organisation provides free legal advice and assistance to underprivileged families and families in need. We are dedicated to ensuring that everyone has access to the legal aid they need, regardless of their financial situation. We provide legal representation, advice, and assistance to those who cannot afford legal representation and help them navigate the legal system.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Image.asset(
                        'assets/booklet.jpg',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    SizedBox(height: 8.0),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookletPage(),
                    ),
                  );
                },
              ),
            ]),
          ),
        ],
      ),
    );
  }
}



