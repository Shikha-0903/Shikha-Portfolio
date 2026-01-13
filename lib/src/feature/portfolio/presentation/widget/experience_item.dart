import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ExperienceItem extends StatefulWidget {
  final String company;
  final String period;
  final String role;
  final List<String> responsibilities;
  final String? playStoreUrl;
  final String? webUrl;
  final DateTime startDate;
  final DateTime? endDate;

  const ExperienceItem({
    super.key,
    required this.company,
    required this.period,
    required this.role,
    required this.responsibilities,
    required this.startDate,
    this.endDate,
    this.playStoreUrl,
    this.webUrl,
  });

  @override
  State<ExperienceItem> createState() => _ExperienceItemState();
}

class _ExperienceItemState extends State<ExperienceItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: isSmallScreen ? 20 : 40,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(8),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.deepPurpleAccent.withAlpha(40),
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Padding(
                padding: EdgeInsets.all(isSmallScreen ? 20 : 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildHeader(isSmallScreen),
                    const SizedBox(height: 20),
                    _buildResponsibilities(isSmallScreen),
                    if (widget.playStoreUrl != null ||
                        widget.webUrl != null) ...[
                      const SizedBox(height: 20),
                      _buildActionButtons(isSmallScreen),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _calculateDuration(DateTime startDate, DateTime? endDate) {
    final end = endDate ?? DateTime.now();

    // Calculate years, months, and days accurately
    int years = end.year - startDate.year;
    int months = end.month - startDate.month;
    int days = end.day - startDate.day;

    // Adjust for negative days
    if (days < 0) {
      months--;
      // Get days in the previous month
      final prevMonth = DateTime(end.year, end.month, 0);
      days += prevMonth.day;
    }

    // Adjust for negative months
    if (months < 0) {
      years--;
      months += 12;
    }

    // Build duration string (show months and days, or just days if less than a month)
    List<String> parts = [];
    if (years > 0) {
      parts.add('$years ${years == 1 ? 'year' : 'years'}');
    }
    if (months > 0) {
      parts.add('$months ${months == 1 ? 'month' : 'months'}');
    }
    if (days > 0) {
      parts.add('$days ${days == 1 ? 'day' : 'days'}');
    }

    // If no parts (shouldn't happen), return "0 days"
    if (parts.isEmpty) {
      return '0 days';
    }

    return parts.join(' ');
  }

  Widget _buildHeader(bool isSmallScreen) {
    final duration = _calculateDuration(widget.startDate, widget.endDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.company,
          style: GoogleFonts.poppins(
            fontSize: isSmallScreen ? 22 : 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.3,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent.withAlpha(30),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.deepPurpleAccent.withAlpha(80),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: 16,
                    color: Colors.white.withAlpha(200),
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      widget.period,
                      style: GoogleFonts.poppins(
                        fontSize: isSmallScreen ? 12 : 13,
                        color: Colors.white.withAlpha(200),
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Divider(
                color: Colors.deepPurpleAccent.withAlpha(100),
                thickness: 1,
              ),
            ),
            SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent.withAlpha(40),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.deepPurpleAccent.withAlpha(100),
                  width: 1,
                ),
              ),
              child: Text(
                duration,
                style: GoogleFonts.poppins(
                  fontSize: isSmallScreen ? 11 : 12,
                  color: Colors.deepPurpleAccent[200],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          widget.role,
          style: GoogleFonts.poppins(
            fontSize: isSmallScreen ? 15 : 17,
            fontWeight: FontWeight.w500,
            color: Colors.deepPurpleAccent[200],
            letterSpacing: 0.2,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildResponsibilities(bool isSmallScreen) {
    final displayCount = _isExpanded ? widget.responsibilities.length : 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Responsibilities",
          style: GoogleFonts.poppins(
            fontSize: isSmallScreen ? 16 : 18,
            fontWeight: FontWeight.w600,
            color: Colors.white.withAlpha(240),
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 16),
        ...widget.responsibilities.take(displayCount).map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 14.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    item,
                    style: GoogleFonts.poppins(
                      fontSize: isSmallScreen ? 14 : 15,
                      color: Colors.white.withAlpha(200),
                      height: 1.6,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        if (widget.responsibilities.length > 3)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextButton(
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _isExpanded
                        ? "Show less"
                        : "Show ${widget.responsibilities.length - 3} more",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.deepPurpleAccent[200],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.deepPurpleAccent[200],
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildActionButtons(bool isSmallScreen) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        if (widget.playStoreUrl != null)
          _buildActionButton(
            "Play Store",
            Icons.play_arrow_rounded,
            widget.playStoreUrl!,
            const Color(0xFF00C853),
            isSmallScreen,
          ),
        if (widget.webUrl != null)
          _buildActionButton(
            "Website",
            Icons.language_rounded,
            widget.webUrl!,
            const Color(0xFF2196F3),
            isSmallScreen,
          ),
      ],
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    String url,
    Color color,
    bool isSmallScreen,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => launchUrl(Uri.parse(url)),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 18 : 22,
            vertical: isSmallScreen ? 10 : 12,
          ),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: isSmallScreen ? 13 : 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
