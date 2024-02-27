import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:expense_tracker/widgets/expenses.dart';
import 'package:google_fonts/google_fonts.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 240, 139, 139),
);

var kDarkCholorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 120, 120, 140),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //  .then((fn) {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkCholorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkCholorScheme.onPrimary,
          margin: const EdgeInsets.symmetric(
            horizontal: 11,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkCholorScheme.onInverseSurface,
          ),
        ),
        textTheme: GoogleFonts.cagliostroTextTheme(ThemeData.dark().textTheme),
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onSurfaceVariant,
          foregroundColor: Colors.white,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.onPrimary,
          margin: const EdgeInsets.symmetric(
            horizontal: 11,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.onInverseSurface,
          ),
        ),
        textTheme: GoogleFonts.acmeTextTheme(),
      ),
      home: const Expenses(),
    ),
  );
  //});
}
