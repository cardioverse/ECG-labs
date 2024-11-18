import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_auth/firebase_auth.dart';  // Import Firebase Auth
import 'screens/home_screen.dart';
import 'screens/learn_screen.dart';
import 'screens/ecg_trainer_screen.dart';  // Import the ECG Trainer screen
import 'screens/settings_screen.dart';  // Import the Settings screen
import 'user_authentication/login_screen.dart';  // Import the Login screen
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ECGTrainerApp());
}

class ECGTrainerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ECG Trainer',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
        ),
        colorScheme: ColorScheme.dark(
          primary: Colors.white,
          onPrimary: Colors.black,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, // Button background
            foregroundColor: Colors.black, // Button text color
            minimumSize: Size(double.infinity, 50), // Full-width button
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.black,
          indicatorColor: Colors.deepPurple[900],
          labelTextStyle: MaterialStateProperty.resolveWith<TextStyle?>((states) {
            if (states.contains(MaterialState.selected)) {
              return TextStyle(color: Colors.white);
            } else {
              return TextStyle(color: Colors.white);
            }
          }),
          iconTheme: MaterialStateProperty.resolveWith<IconThemeData>((states) {
            if (states.contains(MaterialState.selected)) {
              return IconThemeData(color: Colors.white);
            } else {
              return IconThemeData(color: Colors.white);
            }
          }),
        ),
      ),
      home: SplashScreen(),  // Start with SplashScreen to check login status
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Check user's authentication state to determine which screen to show
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 2)), // Simulate splash delay
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            // User is logged in, go to HomeScreen
            return HomeScreen();
          } else {
            // No user is logged in, go to LoginScreen
            return LoginScreen();
          }
        }
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    HomeContent(),
    LearnScreen(),
    ECGTrainerScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.black,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.school),
            label: 'Learn',
          ),
          NavigationDestination(
            icon: Icon(Icons.library_books),
            label: 'Workshop',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
