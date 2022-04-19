import 'package:bunsep/screens/home_screen.dart';
import 'package:bunsep/templates/colour_template.dart';
import 'package:bunsep/templates/text_style_template.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String route = '/splash_screen';

  void initial(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(HomeScreen.route);
    });
  }

  @override
  Widget build(BuildContext context) {
    initial(context);
    return Container(
      alignment: Alignment.center,
      color: ColourTemplate.light,
      child: Text(
        'BUN\nSEP',
        style: TextStyleTemplate.boldTeal(
            size: 72, textDecoration: TextDecoration.none),
      ),
    );
  }
}
