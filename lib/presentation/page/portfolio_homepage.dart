import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:port/presentation/widget/custom_text.dart';
import '../widget/build_footer.dart';
import '../widget/build_social_icons.dart';
import '../widget/launch_url.dart';
import '../widget/project_item.dart';
import '../widget/skills.dart';
import '../widget/video_align.dart';

class PortfolioHomepage extends StatefulWidget {
  const PortfolioHomepage({super.key});

  @override
  State<PortfolioHomepage> createState() => _PortfolioHomepageState();
}

class _PortfolioHomepageState extends State<PortfolioHomepage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _videosKey = GlobalKey();
  final GlobalKey _resumeKey = GlobalKey();
  final GlobalKey _skillKey = GlobalKey();

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
            style: TextStyle(
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
              buildSocialIcons(context),
              const SizedBox(height: 10),
              buildFooter(),
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
            accountName: CustomText(text: "Shikha Prajapati", fontSize: 15, color: Colors.white,fontWeight: FontWeight.bold,),
            accountEmail: CustomText(text: "Flutter Application Developer", fontSize: 12, color: Colors.white),
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
            child: CustomText(text: "Connect", fontSize: 14, color: Colors.white70,textAlign: TextAlign.start,),
          ),

          _buildDrawerItem(Bootstrap.github, 'GitHub',
                  () => launchURL(context,"https://github.com/Shikha-0903")),
          _buildDrawerItem(Bootstrap.linkedin, 'LinkedIn',
                  () => launchURL(context,"https://www.linkedin.com/in/shikha-prajapati-06603a245/")),
        ],
      ),
    );
  }


  ListTile _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: CustomText(text: title, fontSize: 16, color: Colors.white,textAlign: TextAlign.start,),
      onTap: onTap,
    );
  }

  Widget _buildIntroText(bool isSmallScreen) {
    final texts = [
      "\u{1F44B} Hello! I am Shikha Prajapati",
      "\u{1F393} A Computer Science Graduate from Mumbai University",
      "\u{1F4BB} Passionate about Flutter application Development",
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
              CustomText(text: "About Me", fontSize: 24, color: Colors.white,fontWeight: FontWeight.bold),
              const SizedBox(height: 10),
              CustomText(
                  text: "I'm a creative and detail-oriented Software Developer focused on delivering high-quality mobile apps using Flutter. Beyond coding, I love exploring Data Science and AI trends.",
                  fontSize: 14,
                  color: Colors.white70,
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
                    CustomText(text: "About Me", fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white,textAlign: TextAlign.start),
                    const SizedBox(height: 10),
                    CustomText(
                        text: "I'm a creative and detail-oriented Software Developer focused on delivering high-quality mobile apps using Flutter. Beyond coding, I love exploring Data Science and AI trends.",
                        fontSize: 14,
                        color: Colors.white70,textAlign: TextAlign.start
                    )
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
              child:CustomText(text: "Projects", fontSize: 26, color: Colors.white),
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
              child: CustomText(text: "See insights", fontSize: 26, color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 40),
                VideoAlign(
                  videopath: "https://firebasestorage.googleapis.com/v0/b/artgallery-1e47c.appspot.com/o/video%2Fcrowd.mp4?alt=media&token=912d9351-eb99-4c43-9013-9f4d066a2825",
                  data: "CrowdLift App",
                ),

                const SizedBox(width: 20),
                VideoAlign(
                  videopath: "https://firebasestorage.googleapis.com/v0/b/artgallery-1e47c.appspot.com/o/video%2Fdiy.mp4?alt=media&token=ab9a3f35-23d0-41f5-8945-33bd6dd2508e",
                  data: "DIY making App",
                ),

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
        onPressed: () => launchURL(context,
            "https://drive.google.com/file/d/1zjkCkZfDn5OxXoXuupNRX10VPhj7gA9Q/view?usp=drive_link"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurpleAccent,
          padding: EdgeInsets.symmetric(
            vertical: isSmallScreen ? 12 : 15,
            horizontal: isSmallScreen ? 20 : 30,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: CustomText(text: "Download My Resume", fontSize: isSmallScreen ? 16 : 18,color: Colors.white) ,
      ),
    );
  }
}