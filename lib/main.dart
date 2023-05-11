import 'package:expense_tracker_app/expense_tracker_app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

ColorScheme kLightColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

ColorScheme kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 96, 59, 181),
  // seedColor: const Color.fromARGB(255, 5, 99, 125),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // light theme
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kLightColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kLightColorScheme.onPrimaryContainer,
          foregroundColor: kLightColorScheme.primaryContainer,
        ),
        // scaffoldBackgroundColor: kLightColorScheme.onSecondaryContainer,
        cardTheme: const CardTheme().copyWith(
            color: kLightColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            )),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kLightColorScheme.primaryContainer,
          ),
        ),
        // // custom text theme
        // textTheme: const TextTheme().copyWith(
        //   labelMedium: const TextStyle(
        //     color: Color.fromARGB(143, 0, 0, 0),
        //     fontWeight: FontWeight.w500,
        //     fontSize: 18,
        //   ),
        //   labelLarge: const TextStyle(
        //     color: Color.fromARGB(143, 0, 0, 0),
        //     fontWeight: FontWeight.w700,
        //     fontSize: 28,
        //   ),
        //   labelSmall: const TextStyle(
        //     color: Color.fromARGB(143, 0, 0, 0),
        //     fontWeight: FontWeight.w500,
        //     fontSize: 18,
        //   ),
        // ),
      ),

      // Dark theme
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kDarkColorScheme.onPrimaryContainer,
          foregroundColor: kDarkColorScheme.primaryContainer,
        ),
        // scaffoldBackgroundColor: kLightColorScheme.onSecondaryContainer,
        cardTheme: const CardTheme().copyWith(
            color: kDarkColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            )),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
        // custom text theme
        // custom text theme
        // textTheme: const TextTheme().copyWith(
        //   titleMedium: const TextStyle(
        //     color: Color.fromARGB(126, 211, 145, 235),
        //     fontWeight: FontWeight.w500,
        //     fontSize: 18,
        //   ),
        //   titleLarge: const TextStyle(
        //     color: Color.fromARGB(231, 241, 238, 238),
        //     fontWeight: FontWeight.w700,
        //     fontSize: 28,
        //   ),
        //   titleSmall: const TextStyle(
        //     color: Color.fromARGB(143, 0, 0, 0),
        //     fontWeight: FontWeight.w500,
        //     fontSize: 18,
        //   ),
        // ),
      ),
      debugShowCheckedModeBanner: false,
      home: const ExpenseTrackerApp(),
    );
  }
}
