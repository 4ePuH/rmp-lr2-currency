import 'package:flutter/material.dart';

import 'data/api_client.dart';
import 'data/currency_repository.dart';
import 'screens/converter_screen.dart';
import 'state/converter_state.dart';

void main() {
  final state = ConverterState(repository: CurrencyRepository(ApiClient()));
  runApp(ConverterApp(state: state));
}

class ConverterApp extends StatelessWidget {
  final ConverterState state;

  const ConverterApp({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    const background = Color(0xFF1C1C1E);
    const panel = Color(0xFF2C2C2E);
    const control = Color(0xFF4A4A4F);
    const orange = Color(0xFFFF9F0A);
    const corner = Radius.circular(6);
    const radius = BorderRadius.all(corner);
    final shape = RoundedRectangleBorder(borderRadius: radius);
    final fieldBorder = OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide.none,
    );

    return MaterialApp(
      title: 'Конвертер валют',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: orange,
          onPrimary: Colors.black,
          surface: background,
          onSurface: Colors.white,
          onSurfaceVariant: Color(0xFFD4D4D8),
        ),
        scaffoldBackgroundColor: background,
        appBarTheme: const AppBarTheme(backgroundColor: background),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            shape: shape,
            minimumSize: const Size(0, 48),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            backgroundColor: control,
            foregroundColor: Colors.white,
            side: BorderSide.none,
            shape: shape,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            alignment: Alignment.centerLeft,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: panel,
          enabledBorder: fieldBorder,
          focusedBorder: fieldBorder.copyWith(
            borderSide: const BorderSide(color: orange, width: 2),
          ),
        ),
        cardTheme: CardThemeData(
          color: panel,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: shape,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: panel,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: corner),
          ),
        ),
      ),
      home: ColoredBox(
        color: background,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: ConverterScreen(state: state),
          ),
        ),
      ),
    );
  }
}
