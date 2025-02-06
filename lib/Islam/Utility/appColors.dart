import 'dart:ui';

import 'package:flutter/cupertino.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF43AD66); // Primary color
  static final Color secondaryColor = primaryColor.withOpacity(0.5); // Secondary color
  static const LinearGradient linearGrad = LinearGradient(
    colors: [
      const Color(0xFF71D48F), // Slightly lighter shade
      const Color(0xFF2E8E4D), // Base color
      const Color(0xFF2E8E4D), // Darker shade for depth
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

