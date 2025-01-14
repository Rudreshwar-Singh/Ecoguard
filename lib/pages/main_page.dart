import 'package:ecoquest/components/app_button.dart';
import 'package:ecoquest/model/challenge.dart';
import 'package:ecoquest/utils/app_routes.dart';
import 'package:ecoquest/utils/challenge_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'dart:math';

class MainPage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const MainPage(
      {super.key, required this.toggleTheme, required this.isDarkMode});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Challenge? currentActiveChallenge;

  @override
  void initState() {
    super.initState();
    currentActiveChallenge = ChallengePreferences.getCurrentActiveChallenge() ??
        Challenge(title: "NA", description: "NA", active: false, image: "assets/images/51.png");
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: widget.isDarkMode ? Colors.white : Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );

    final descriptionStyle = TextStyle(
      color: widget.isDarkMode ? Colors.white70 : Colors.black87,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    );

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: widget.isDarkMode
          ? const Color.fromARGB(255, 15, 28, 48)
          : const Color.fromARGB(255, 148, 186, 218),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    // Text(
                    //   'Light Mode',
                    //   style: TextStyle(
                    //     color: widget.isDarkMode ? Colors.white : Colors.black,
                    //   ),
                    // ),
                    FlutterSwitch(
                      value: widget.isDarkMode,
                      onToggle: (val) {
                        widget.toggleTheme();
                      },
                      activeColor: Colors.black,
                      inactiveColor: Colors.blue,
                      activeToggleColor: Colors.white,
                      inactiveToggleColor: Colors.orange,
                      activeSwitchBorder: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      inactiveSwitchBorder: Border.all(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                      activeIcon: Image.asset(
                        'assets/images/moon.png',
                        height: 20,
                        width: 20,
                      ),
                      inactiveIcon: Image.asset(
                        'assets/images/sun.png',
                        height: 20,
                        width: 20,
                      ),
                      activeText: "Night",
                      inactiveText: "Day",
                      activeTextColor: Colors.white,
                      inactiveTextColor: Colors.black,
                    ),
                    // Text(
                    //   'Dark Mode',
                    //   style: TextStyle(
                    //     color: widget.isDarkMode ? Colors.white : Colors.black,
                    //   ),
                    // ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      color: Colors.black,
                      child: const Text(
                        "Day",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      color: Colors.white,
                      child: const Text(
                        "Hour",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              height: min(screenW * 0.6, screenH * 0.3),
              width: min(screenW * 0.6, screenH * 0.3),
              child: Center(
                  child: Image.asset(
                currentActiveChallenge!.image ?? "assets/images/51.png",
                fit: BoxFit.cover,
              )),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 40),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const Text(
                      "Your Challenge This Week:",
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      currentActiveChallenge!.title,
                      style: TextStyle(
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      currentActiveChallenge!.description,
                      style: descriptionStyle,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 40),
              child: Column(
                children: [
                  AppButton(
                    buttonText: "Roll Challenges",
                    onPressed: () {
                      setState(() {
                        currentActiveChallenge =
                            ChallengePreferences.rollRandomChallenge(
                                currentActiveChallenge!.id!);
                      });
                    },
                    textColor: widget.isDarkMode ? Colors.white : Colors.black,
                  ),
                  AppButton(
                    buttonText: "List Of Challenges",
                    onPressed: () => Navigator.of(context)
                        .pushNamed(AppRoutes.challengeList),
                    textColor: widget.isDarkMode ? Colors.white : Colors.black,
                  ),
                  AppButton(
                    buttonText: "Leaderboard",
                    onPressed: () => Navigator.of(context)
                        .pushNamed(AppRoutes.previousChallenges),
                    textColor: widget.isDarkMode ? Colors.white : Colors.black,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
