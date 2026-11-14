import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'config/app_config.dart';
import 'screens/home_screen.dart';
import 'config/dependency_injector.dart';
import 'config/dependency_provider.dart';
import '../utils/logger.dart';

/// Entry point aplikasi.
///
/// Memuat konfigurasi dari file `.env` sebelum menjalankan aplikasi.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Muat file .env
  await dotenv.load(fileName: ".env");
  // Periksa konfigurasi
  if (!AppConfig.isConfigured()) {
    Logger.info('Aplikasi dimulai');
  }
  runApp(
    DependencyProvider(
      userRepository: DependencyInjector.userRepository,
      postRepository: DependencyInjector.postRepository,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPL & Keamanan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
