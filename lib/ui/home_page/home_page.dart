import 'package:flutter/material.dart';
import 'package:impact_hack/util/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12.0))
              ),
              child: Text(sampleDescription, style: Theme.of(context).textTheme.bodyLarge),
            )
          ],
        ),
      )
    );
  }
}
