import 'package:flutter/material.dart';
import 'package:impact_hack/ui/comparison_page/comparison_page.dart';
import 'package:impact_hack/ui/comparison_page/comparison_page_state.dart';
import 'package:impact_hack/ui/home_page/home_page.dart';
import 'package:impact_hack/ui/home_page/home_page_state.dart';
import 'package:impact_hack/ui/location_search/location_search.dart';
import 'package:impact_hack/ui/location_search/location_search_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFA07A),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
          create: (context) => HomePageState(context), child: const HomePage()),
    );
  }
}
