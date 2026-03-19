import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:port/src/core/widgets/custom_text.dart';

class SkillData {
  final String name;
  final Widget icon;

  SkillData({required this.name, required this.icon});
}

class SkillsSection extends StatelessWidget {
  final List<SkillData> allSkills = [
    SkillData(name: 'Flutter', icon: Brand(Brands.flutter)),
    SkillData(name: 'Dart', icon: Brand(Brands.dart)),
    SkillData(name: 'Firebase', icon: Brand(Brands.firebase)),
    SkillData(name: 'Supabase', icon: const Icon(Bootstrap.lightning_fill, color: Colors.greenAccent)),
    SkillData(name: 'PostgreSQL', icon: Brand(Brands.postgresql)),
    SkillData(name: 'MongoDB', icon: Brand(Brands.mongodb)),
    SkillData(name: 'MySQL', icon: const Icon(Bootstrap.database, color: Colors.orange)),
    SkillData(name: 'Python', icon: Brand(Brands.python)),
    SkillData(name: 'GitHub', icon: Brand(Brands.github)),
    SkillData(name: 'Android Studio', icon: Icon(Icons.android,color: Colors.green,)),
    SkillData(name: 'VS Code', icon: const Icon(Bootstrap.terminal, color: Colors.blue)),
    SkillData(name: 'Postman', icon: const Icon(Bootstrap.rocket, color: Colors.orangeAccent)),
    SkillData(name: 'REST API', icon: const Icon(Bootstrap.hdd_network, color: Colors.greenAccent)),
    SkillData(name: 'Deployment', icon: const Icon(Bootstrap.rocket_takeoff, color: Colors.lightBlueAccent)),
    SkillData(name: 'Bloc', icon: const Icon(Bootstrap.box, color: Colors.blueAccent)),
    SkillData(name: 'Provider', icon: const Icon(Bootstrap.layers, color: Colors.blue)),
    SkillData(name: 'State Management', icon: const Icon(Bootstrap.cpu, color: Colors.purpleAccent)),
    SkillData(name: 'Analytics', icon: const Icon(Bootstrap.bar_chart, color: Colors.orange)),
  ];

  SkillsSection({super.key});

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
              child: CustomText(text: "Technical Skills", fontSize: 26, color: Colors.white),
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: allSkills.map((skill) => SkillTile(skill: skill)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class SkillTile extends StatefulWidget {
  final SkillData skill;

  const SkillTile({required this.skill, super.key});

  @override
  State<SkillTile> createState() => _SkillTileState();
}

class _SkillTileState extends State<SkillTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: _isHovered 
            ? Colors.deepPurpleAccent.withAlpha(40) 
            : Colors.white.withAlpha(15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered 
              ? Colors.deepPurpleAccent 
              : Colors.deepPurpleAccent.withAlpha(80),
            width: 1.5,
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: Colors.deepPurpleAccent.withAlpha(50),
                blurRadius: 15,
                spreadRadius: 2,
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: widget.skill.icon,
            ),
            const SizedBox(width: 12),
            Text(
              widget.skill.name,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

