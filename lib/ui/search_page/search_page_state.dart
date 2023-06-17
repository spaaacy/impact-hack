import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SearchPageState extends ChangeNotifier {

  BuildContext context;
  String _sessionToken = const Uuid().v4();
  final searchController = TextEditingController();
  bool _monthly = false;

  SearchPageState(this.context);

  String get sessionToken => _sessionToken;

  set sessionToken(String value) {
    _sessionToken = value;
    notifyListeners();
  }

  bool get monthly => _monthly;

  set monthly(bool value) {
    _monthly = value;
    notifyListeners();
  }
}