import 'package:bunsep/screens/cakes_screen.dart';
import 'package:bunsep/screens/detail_cake_screen.dart';
import 'package:bunsep/screens/home_screen.dart';
import 'package:bunsep/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BunSep',
      theme: ThemeData(
        fontFamily: 'Rubik',
        primarySwatch: Colors.grey,
      ),
      initialRoute: SplashScreen.route,
      routes: {
        SplashScreen.route: (context) => const SplashScreen(),
        HomeScreen.route: (context) => const HomeScreen(),
        CakesScreen.route: (context) => const CakesScreen(),
        DetailCakeScreen.route: (context) => const DetailCakeScreen(),
      },
    );
  }
}