import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'src/feature/portfolio/presentation/page/portfolio_homepage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.deepPurpleAccent,
        scaffoldBackgroundColor: Colors.black,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const PortfolioHomepage(),
    );
  }
}
