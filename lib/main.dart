import 'package:flutter/material.dart';
import 'package:ecoquest/pages/list_challenges_page.dart';
import 'package:ecoquest/pages/main_page.dart';
import 'package:ecoquest/pages/previous_challenges.dart';
import 'package:ecoquest/pages/welcome_page.dart';
import 'package:ecoquest/utils/app_routes.dart';
import 'package:ecoquest/utils/challenge_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ChallengePreferences.init();

  ChallengePreferences.printChallengeList();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleTheme(bool isDarkMode) {
    setState(() {
      _isDarkMode = isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor:
            _isDarkMode ? Colors.blue[900] : Colors.blue[100],
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      ),
      initialRoute: ChallengePreferences.isFirstLaunch()
          ? AppRoutes.welcome
          : AppRoutes.mainPage,
      routes: {
        AppRoutes.mainPage: (context) => MainPage(
            toggleTheme: () => _toggleTheme(!_isDarkMode),
            isDarkMode: _isDarkMode),
        AppRoutes.challengeList: (context) => ListChallengesPage(
              isDarkMode: _isDarkMode,
              onThemeChanged: _toggleTheme,
            ),
        AppRoutes.previousChallenges: (context) => PreviousChallenges(),
        AppRoutes.welcome: (context) => WelcomePage(),
      },
    );
  }
}
