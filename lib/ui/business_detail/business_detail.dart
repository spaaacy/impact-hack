import 'package:flutter/material.dart';
import 'package:impact_hack/util/constants.dart';

class BusinessDetail extends StatelessWidget {
  const BusinessDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Business Name',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 12.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration:
                  const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Analysis", style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8.0),
                  Text(loremImpsum, style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
