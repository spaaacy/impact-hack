import 'package:flutter/material.dart';
import 'package:impact_hack/ui/business_detail/business_detail.dart';
import 'package:impact_hack/ui/business_detail/business_detail_state.dart';
import 'package:impact_hack/ui/search_page/search_page.dart';
import 'package:impact_hack/ui/search_page/search_page_state.dart';
import 'package:provider/provider.dart';

import '../model/chatgpt_request.dart';
import '../services/gpt_service.dart';

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
        scaffoldBackgroundColor: Color(0xFFFFA07A),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: ChangeNotifierProvider(create: (context) => SearchPageState(context), child: SearchPage(),),
      home: ChangeNotifierProvider(
        create: (context) => BusinessDetailState(context),
        child: const BusinessDetail(),
      ),
    );
  }
}
