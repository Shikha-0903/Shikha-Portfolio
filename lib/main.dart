import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';
import 'project_item.dart';
import 'video_align.dart';
import 'skills.dart';

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
      home: const Shikha(),
    );
  }
}

class Shikha extends StatefulWidget {
  const Shikha({super.key});

  @override
  State<Shikha> createState() => _ShikhaState();
}

class _ShikhaState extends State<Shikha> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _videosKey = GlobalKey();
  final GlobalKey _resumeKey = GlobalKey();
  final GlobalKey _skillKey = GlobalKey();

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.purpleAccent, Colors.deepPurple],
          ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: Text(
            'Shikha Prajapati',
            style: GoogleFonts.aboreto(
              fontSize: isSmallScreen ? 24 : 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      drawer: _buildDrawer(isSmallScreen),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
              _buildIntroText(isSmallScreen),
              const SizedBox(height: 60),
              _buildAboutSection(isSmallScreen),
              _buildProjectsSection(isSmallScreen),
              _buildVideosSection(isSmallScreen),
              const SizedBox(height: 30),
              KeyedSubtree(
                key: _skillKey,
                child:SkillsSection(),),
              SizedBox(height: 30,),
              _buildResumeButton(isSmallScreen),
              const SizedBox(height: 60),
              _buildSocialIcons(),
              const SizedBox(height: 10),
              _buildFooter(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Drawer _buildDrawer(bool isSmallScreen) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurpleAccent, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            accountName: Text("Shikha Prajapati", style: GoogleFonts.poppins(fontWeight: FontWeight.bold,)),
            accountEmail: Text("Flutter & Python Developer", style: GoogleFonts.poppins(fontSize: 12)),
          ),
          _buildDrawerItem(Icons.home, 'Home', () {
            _scrollController.animateTo(0,
                duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
            Navigator.pop(context);
          }),
          _buildDrawerItem(Icons.work_outline, 'Projects', () => _scrollToSection(_projectsKey)),
          _buildDrawerItem(Icons.video_library_outlined, 'Videos', () => _scrollToSection(_videosKey)),
          _buildDrawerItem(Icons.description_outlined, 'Download Resume', () => _scrollToSection(_resumeKey)),
          _buildDrawerItem(Icons.lightbulb, 'Skills', () => _scrollToSection(_skillKey)),

          const Divider(color: Colors.white54, indent: 16, endIndent: 16, height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text("Connect", style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14)),
          ),

          _buildDrawerItem(Bootstrap.github, 'GitHub',
                  () => _launchURL("https://github.com/Shikha-0903")),
          _buildDrawerItem(Bootstrap.linkedin, 'LinkedIn',
                  () => _launchURL("https://www.linkedin.com/in/shikha-prajapati-06603a245/")),
        ],
      ),
    );
  }


  ListTile _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: GoogleFonts.poppins(color: Colors.white)),
      onTap: onTap,
    );
  }

  Widget _buildIntroText(bool isSmallScreen) {
    final texts = [
      "\u{1F44B} Hello! I am Shikha Prajapati",
      "\u{1F393} A Computer Science Graduate from Mumbai University",
      "\u{1F4BB} Passionate about Flutter and Python Development",
      "\u{1F4CA} Exploring Data Science and ML",
    ];
    return AnimatedTextKit(
      repeatForever: true,
      animatedTexts: texts
          .map((text) => TyperAnimatedText(text,
          textStyle: GoogleFonts.anton(
            fontSize: isSmallScreen ? 22 : 30,
            color: Colors.white,
          ),
          textAlign: TextAlign.center))
          .toList(),
    );
  }

  Widget _buildAboutSection(bool isSmallScreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        color: Colors.white.withOpacity(0.05),
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: isSmallScreen
              ? Column(
            children: [
              Center(child: Lottie.asset("assets/animation/port.json", height: 180)),
              const SizedBox(height: 20),
              Text("About Me",
                  style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 10),
              Text(
                "I'm a creative and detail-oriented Software Developer focused on delivering high-quality mobile apps using Flutter. Beyond coding, I love exploring Data Science and AI trends.",
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            ],
          )
              : Row(
            children: [
              Lottie.asset("assets/animation/port.json", height: 250),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("About Me",
                        style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    const SizedBox(height: 10),
                    Text(
                      "I'm a creative and detail-oriented Software Developer focused on delivering high-quality mobile apps using Flutter. Beyond coding, I love exploring Data Science and AI trends.",
                      style:
                      GoogleFonts.poppins(fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectsSection(bool isSmallScreen) {
    return KeyedSubtree(
      key: _projectsKey,
      child: Column(
        children: [
          const SizedBox(height: 60),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 20.0 : 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child:
              Text("Projects", style: GoogleFonts.poppins(fontSize: 26, color: Colors.white)),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 320,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 15 : 20),
              child: Row(
                children: const [
                  ProjectItem(
                    title: "CrowdLift",
                    description: "Bridges the gap between investors and entrepreneurs.",
                    url: "https://drive.google.com/file/d/1JCYaq8GV8Uh4HEYmiXD19Q1Q3bUnj5l2/view?usp=drive_link",
                    code_url: "https://github.com/Shikha-0903/CrowdLift",
                  ),
                  SizedBox(width: 20),
                  ProjectItem(
                    title: "DIY Making App",
                    description: "Creative platform for DIY tutorials and uploads using Youtube API.",
                    url: "https://drive.google.com/file/d/1s1VPBnrQkHzxNzqx1Ub_mUzLQ2C5Jk_R/view?usp=drive_link",
                    code_url: "https://github.com/Shikha-0903/diy-app",
                  ),
                  SizedBox(width: 20),
                  ProjectItem(
                    title: "PhoneBook",
                    description: "CRUD app using Flutter and Hive database.",
                    url: "https://drive.google.com/file/d/10_DxHrk_dsfiF0MxjauDbnPfWPhj7gA9Q/view?usp=drive_link",
                    code_url: "https://github.com/Shikha-0903/PhoneBook",
                  ),
                  SizedBox(width: 20),
                  ProjectItem(
                    title: "Tic Tac Toe",
                    description: "Fun Flutter-based game.",
                    url: "https://drive.google.com/file/d/1b6vvMoYnYLnzU0QJmol6WnINfqK8H-aq/view?usp=drive_link",
                    code_url: "https://github.com/Shikha-0903/tic-tac-toe",
                  ),
                  SizedBox(width: 20),
                  ProjectItem(
                    title: "ArtGallery",
                    description: "App that showcase the art and artworks of artists using artsy API.",
                    code_url: "https://github.com/Shikha-0903/ArtGallery",
                    isArt: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideosSection(bool isSmallScreen) {
    return KeyedSubtree(
      key: _videosKey,
      child: Column(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 20.0 : 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("See insights",
                  style: GoogleFonts.poppins(fontSize: 26, color: Colors.white)),
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 40),
                VideoAlign(videopath: "assets/videos/crowd.mp4", data: "CrowdLift App"),
                const SizedBox(width: 20),
                VideoAlign(videopath: "assets/videos/diy.mp4", data: "DIY making App"),
                const SizedBox(width: 40),
              ],
            ),
          ),
          const SizedBox(height: 10),
          if (isSmallScreen)
            const Text("Scroll to see more->", style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildResumeButton(bool isSmallScreen) {
    return KeyedSubtree(
      key: _resumeKey,
      child: ElevatedButton(
        onPressed: () => _launchURL(
            "https://drive.google.com/file/d/1zjkCkZfDn5OxXoXuupNRX10VPhj7gA9Q/view?usp=drive_link"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurpleAccent,
          padding: EdgeInsets.symmetric(
            vertical: isSmallScreen ? 12 : 15,
            horizontal: isSmallScreen ? 20 : 30,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: Text(
          "Download My Resume",
          style: GoogleFonts.poppins(
              fontSize: isSmallScreen ? 16 : 18, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Bootstrap.github, color: Colors.white, size: 30),
          onPressed: () => _launchURL("https://github.com/Shikha-0903"),
        ),
        IconButton(
          icon: const Icon(Bootstrap.linkedin, color: Colors.white, size: 30),
          onPressed: () => _launchURL("https://www.linkedin.com/in/shikha-prajapati-06603a245/"),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Text("© 2025 Shikha Prajapati. All rights reserved.",
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.white60)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Made with ",
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.white60)),
            const Icon(Icons.favorite,
                size: 16, color: Colors.red),
            Text(" Flutter",
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.white60)),
          ],
        ),
      ],
    );
  }
}