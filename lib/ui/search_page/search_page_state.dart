import 'package:flutter/material.dart';

class SearchPageState extends ChangeNotifier {

  BuildContext context;
  final searchController = TextEditingController();
  bool _monthly = false;

  SearchPageState(this.context);
  bool get monthly => _monthly;

  set monthly(bool value) {
    _monthly = value;
    notifyListeners();
  }
}