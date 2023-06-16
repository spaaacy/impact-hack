import 'package:flutter/cupertino.dart';

class ComparisonPageState extends ChangeNotifier {
  final BuildContext context;
  final String googleId;
  String previousBusinessAnalysis;

  ComparisonPageState(this.context, this.googleId, this.previousBusinessAnalysis);
}
