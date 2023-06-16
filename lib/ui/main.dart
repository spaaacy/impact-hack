import 'package:flutter/material.dart';
import 'package:impact_hack/ui/search_page/search_page.dart';
import 'package:impact_hack/ui/search_page/search_page_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(create: (context) => SearchPageState(context), child: SearchPage(),),
    );
  }
}
