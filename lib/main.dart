import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper/core/theme_mode_cubit/theme_mode_cubit.dart';
import 'package:minesweeper/presentation/home/home_screen.dart';
import 'package:minesweeper/presentation/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    BlocProvider(
      create: (context) => ThemeModeCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeModeCubit>().state;
    return MaterialApp(
      title: 'Minesweeper',
      theme: const AppTheme().light(),
      darkTheme: const AppTheme().dark(),
      themeMode: themeMode,
      home: const HomeScreen(),
    );
  }
}
