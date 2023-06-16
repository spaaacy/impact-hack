import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'business_detail_state.dart';

class BusinessDetail extends StatelessWidget {
  const BusinessDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final businessDetailState = Provider.of<BusinessDetailState>(context);
    final descriptionFuture = businessDetailState.fetchBusinessDescription();

    return SelectionArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: FutureBuilder<String>(
              future: descriptionFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Failed to fetch description');
                } else {
                  final description = snapshot.data ?? '';
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Business Name',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 12.0),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: const BoxDecoration(
                            color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12.0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Analysis", style: Theme.of(context).textTheme.titleLarge),
                            const SizedBox(height: 8.0),
                            Text(description, style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
