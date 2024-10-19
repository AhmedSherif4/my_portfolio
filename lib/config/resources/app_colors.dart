import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color black = Color(0xFF000000);
  ///primary color
  static const Color primaryColor = Color(0xFF1B3D6F);
  static const Color primaryColor2 = Color(0xFFF47827);
  static const Color primary2 = Color(0xFF67BBE2);
  static const Color primary3 = Color(0xFF248CE0);
  static const Color quranColor = Color(0xffDFBA41);

  ///secondary color
  static const Color secondaryColor =  Color(0xFF382673);
  static const Color secondaryColor2 = Color(0xFF5C701B);
  static const Color secondaryColor3 = Color(0xFF7193C5);
  static const Color secondaryColor4 = Color(0xFF58340D);

  ///background color
  static const Color backgroundColor = Color(0xFFFAFAFA);

  ///fields color
  static const Color white = Color(0xFFFFFFFF);

  ///text color
  static const Color textColor = Color(0xFF262626);
  static const Color textColor2 = Color(0xFF323131);
  static const Color textColor3 = Color(0xFF515152);
  static const Color textColor4 = Color(0xFF797676);
  static const Color textColor5 = Color(0xFFACACAC);
  static const Color textColor6 = Color(0xFFEEEEEE);

  ///situation color
  static const Color failColor = Color(0xFFB3261E);
  static const Color successColor = Color(0xFF02542D);
  static const Color warningColor = Color(0xFFE8B931);


}

abstract class AppGradientColors {
  // any Gradient Colors
    static const LinearGradient blueGradient2 = LinearGradient(
    begin: Alignment(-0.95, -0.31),
    end: Alignment(0.95, 0.31),
    colors: [
      Color(0xFF1B3D6F),
      Color(0xE51B3D6F),
    ],
  );

  static const LinearGradient skillsGradient = LinearGradient(
    begin: Alignment(-0.95, -0.31),
    end: Alignment(0.95, 0.31),
    colors: [
      Color(0xFFFFD7AB),
      Color(0xFFFAF1E7),
    ],
  );

  static const LinearGradient adviceGradient =  LinearGradient(
    colors: [Color(0xFF3DB8EF), Color(0xFFE7E0BE)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient pointsGradient =  LinearGradient(
    colors: [
      Color(0xFF3E238A),
      Color(0xFF3A2C1D),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient guestDialogGradient =  LinearGradient(
    colors: [
      Color(0xFFF9A144),
      Color(0xFFD0781B),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const LinearGradient nafeesGradient =  LinearGradient(
    colors: [
      Color(0xFFFF9C4B),
      Color(0xFFF47827),
    ],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );
}
