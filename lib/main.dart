import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/intro_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFF0F0E0D),
  ));
  runApp(const FirstDateApp());
}

// ─── Design tokens (anti-AI rules applied) ───────────────────────────────────
class AppColors {
  // Warm dark — not neutral black
  static const background      = Color(0xFF0F0E0D);
  static const surface         = Color(0xFF1B1916);
  static const surfaceElevated = Color(0xFF252220);

  // Text — off-white, not pure white
  static const textPrimary     = Color(0xFFEEECE8);
  static const textSecondary   = Color(0xFF9E9490); // warm grey
  static const textDisabled    = Color(0xFF524E4A);

  // Accent — one color, used sparingly (80/20 rule)
  static const accent          = Color(0xFFE8265A); // deep rose, not hot pink
  static const accentSoft      = Color(0xFF4FC3F7); // person B — cool contrast

  // Borders — almost invisible
  static const borderSubtle    = Color(0x14FFFFFF); // 8% white
  static const borderActive    = Color(0x59FFFFFF); // 35% white
}

class AppRadius {
  // Intentionally different — not all the same
  static const card     = 22.0;
  static const button   = 15.0;
  static const chip     = 10.0;
  static const small    =  8.0;
}

class AppSpacing {
  // Emotional spacing — varies by context
  static const xs  =  8.0;
  static const sm  = 12.0;
  static const md  = 20.0;
  static const lg  = 32.0;
  static const xl  = 48.0;
  static const xxl = 64.0;
}

class FirstDateApp extends StatelessWidget {
  const FirstDateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'First Date',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: AppColors.accent,
          secondary: AppColors.accentSoft,
          surface: AppColors.surface,
          onSurface: AppColors.textPrimary,
          onSurfaceVariant: AppColors.textSecondary,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        // Typography: mix of weights, not default Regular
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
          displayLarge: GoogleFonts.playfairDisplay(
            fontSize: 36, fontWeight: FontWeight.w700,
            color: AppColors.textPrimary, letterSpacing: -0.5, height: 1.1,
          ),
          headlineMedium: GoogleFonts.playfairDisplay(
            fontSize: 26, fontWeight: FontWeight.w600,
            color: AppColors.textPrimary, height: 1.2,
          ),
          titleLarge: GoogleFonts.inter(
            fontSize: 18, fontWeight: FontWeight.w600,
            color: AppColors.textPrimary, height: 1.3,
          ),
          bodyLarge: GoogleFonts.inter(
            fontSize: 16, fontWeight: FontWeight.w400,
            color: AppColors.textPrimary, height: 1.5,
          ),
          bodyMedium: GoogleFonts.inter(
            fontSize: 14, fontWeight: FontWeight.w400,
            color: AppColors.textSecondary, height: 1.5,
          ),
          labelMedium: GoogleFonts.inter(
            fontSize: 13, fontWeight: FontWeight.w500,
            color: AppColors.textSecondary, letterSpacing: 0.1,
          ),
        ),
        cardTheme: CardThemeData(
          color: AppColors.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.card),
            side: const BorderSide(color: AppColors.borderSubtle, width: 1),
          ),
          margin: EdgeInsets.zero,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.button),
            ),
            textStyle: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600,
            ),
            elevation: 0,
          ),
        ),
      ),
      home: const IntroScreen(),
    );
  }
}
