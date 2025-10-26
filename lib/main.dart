import 'package:flutter/material.dart';

// Data Layer Imports
import 'data/repositories/conversion_repository_impl.dart';

// Presentation Layer Imports
import 'presentation/state/conversion_state.dart';
import 'presentation/pages/conversion_page.dart';

void main() {
  runApp(const ConversionApp());
}

/// Main application widget with dependency injection
class ConversionApp extends StatelessWidget {
  const ConversionApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ConversionRepositoryImpl repository = ConversionRepositoryImpl();
    final ConversionState state = ConversionState(
      repository: repository,
    );

    return MaterialApp(
      title: 'Measures Converter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        cardTheme: CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: ConversionPage(state: state),
    );
  }
}
