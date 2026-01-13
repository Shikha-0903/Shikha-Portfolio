import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:port/src/core/widgets/custom_text.dart';

class SkillsSection extends StatelessWidget {
  final List<String> allSkills = [
    // Mobile Development
    'Flutter',
    'Dart',

    // Backend, APIs & Databases
    'REST API Integration',
    'SEC API Integration',
    'Firebase',
    'Supabase',
    'MongoDB',
    'MySQL',

    // State Management
    'Bloc',
    'Provider',
    'State Management',

    // Analytics & Monitoring
    'Firebase Analytics',

    // Tools & Platforms
    'Android Studio',
    'VS Code',
    'GitHub',
    'Postman',
    'Deployment',

    // Programming Languages
    'Python',
  ];

  SkillsSection({super.key});

  Widget buildSkillTile(String skill) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: Colors.deepPurpleAccent.withAlpha(80), width: 1),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withAlpha(10),
              Colors.white.withAlpha(2),
            ],
          ),
        ),
        child: Text(
          skill,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child:
                  CustomText(text: "Skills", fontSize: 26, color: Colors.white),
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: allSkills.map(buildSkillTile).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
