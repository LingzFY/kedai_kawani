import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pos_kawani/pos/pos_page.dart';
import 'package:pos_kawani/utils/app_bloc_observer.dart';

Future main() async {
  await dotenv.load(fileName: "assets/config/.env");
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POS - Kedai Kawani',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const PosPage(),
    );
  }
}
