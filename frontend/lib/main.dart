import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const RepairMyBikeApp());
}

class RepairMyBikeApp extends StatelessWidget {
  const RepairMyBikeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RepairMyBike',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF111217),
        // CardThemeData api changed; using default card theme for now
        //cardTheme: const CardThemeData(margin: EdgeInsets.zero, elevation: 0),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}