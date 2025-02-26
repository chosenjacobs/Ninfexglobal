import 'package:flutter/material.dart';
import 'package:nexglobal/routes/company_profile/company_profile.dart';
import 'package:nexglobal/routes/home_navigator.dart';
import 'package:nexglobal/routes/postsScreen/blog_detail_screen.dart';
import 'package:nexglobal/routes/postsScreen/posts_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ninfex Global',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeNavigator(),
    );
  }
}

