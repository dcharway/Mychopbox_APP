import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/shs_cart_provider.dart';
import 'screens/shs/shs_home_screen.dart';

void main() {
  runApp(const MyChopBoxApp());
}

class MyChopBoxApp extends StatelessWidget {
  const MyChopBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ShsCartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyChopBox - SHS Supplies',
        theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: const Color(0xFF1B5E20),
          scaffoldBackgroundColor: Colors.grey[100],
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1B5E20),
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1B5E20),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1B5E20),
            primary: const Color(0xFF1B5E20),
          ),
        ),
        home: const ShsHomeScreen(),
      ),
    );
  }
}
