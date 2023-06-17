import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class LocationSearchState extends ChangeNotifier {

  BuildContext context;
  final searchController = TextEditingController();

  LocationSearchState(this.context) {
    searchController.addListener(() => notifyListeners());
  }


}