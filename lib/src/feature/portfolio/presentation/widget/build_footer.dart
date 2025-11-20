import "package:flutter/material.dart";
import "package:port/src/core/widgets/custom_text.dart";

Widget buildFooter() {
  return Column(
    children: [
      CustomText(
          text: "© 2025 Shikha Prajapati. All rights reserved.",
          fontSize: 12,
          color: Colors.white60),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(text: "Made with ", fontSize: 12, color: Colors.white60),
          const Icon(Icons.favorite, size: 16, color: Colors.red),
          CustomText(text: " Flutter", fontSize: 12, color: Colors.white60),
        ],
      ),
    ],
  );
}
