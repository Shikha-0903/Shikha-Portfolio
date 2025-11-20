import "package:flutter/material.dart";
import "package:icons_plus/icons_plus.dart";

import "launch_url.dart";

Widget buildSocialIcons(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(
        icon: const Icon(Bootstrap.github, color: Colors.white, size: 30),
        onPressed: () => launchURL(context, "https://github.com/Shikha-0903"),
      ),
      IconButton(
        icon: const Icon(Bootstrap.linkedin, color: Colors.white, size: 30),
        onPressed: () => launchURL(
            context, "https://www.linkedin.com/in/shikha-prajapati-06603a245/"),
      ),
    ],
  );
}
