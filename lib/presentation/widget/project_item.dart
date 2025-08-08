import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
class ProjectItem extends StatelessWidget {
  final String title;
  final String description;
  final String url;
  final String code_url;
  final bool isArt;

  const ProjectItem({
    required this.title,
    required this.description,
    this.url="",
    required this.code_url,
    this.isArt=false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Make project item responsive
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Container(
      width: isSmallScreen ? 260 : 280,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.deepPurpleAccent, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
                fontSize: isSmallScreen ? 18 : 20,
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            child: Text(
              description,
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 15),
          !isArt
              ? ElevatedButton(
            onPressed: () => launchUrl(Uri.parse(url)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text("Download App", style: TextStyle(color: Colors.white)),
          )
              : const SizedBox.shrink(),
          OutlinedButton(
            onPressed: () => launchUrl(Uri.parse(code_url)),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.deepPurpleAccent),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text("View Code"),
          ),
        ],
      ),
    );
  }
}