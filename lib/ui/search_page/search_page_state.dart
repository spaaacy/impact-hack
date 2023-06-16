import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SearchPageState extends ChangeNotifier {

  BuildContext context;
  String _sessionToken = const Uuid().v4();
  final searchController = TextEditingController();

  SearchPageState(this.context);

  String get sessionToken => _sessionToken;

  set sessionToken(String value) {
    _sessionToken = value;
    notifyListeners();
  }
}