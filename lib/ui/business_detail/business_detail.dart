import 'package:flutter/material.dart';
import 'package:impact_hack/util/constants.dart';
import 'package:provider/provider.dart';

import '../comparison_page/comparison_page.dart';
import '../comparison_page/comparison_page_state.dart';
import 'business_detail_state.dart';

class BusinessDetail extends StatelessWidget {
  const BusinessDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<BusinessDetailState>();
    final businessDetailState = Provider.of<BusinessDetailState>(context);
    final descriptionFuture = businessDetailState.fetchBusinessDescription();

    return Scaffold(
      appBar: AppBar(title: const  SelectableText('Analysis')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: FutureBuilder<String>(
            future: descriptionFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const SelectableText('Failed to fetch description');
              } else {
                final description = snapshot.data ?? '';
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SelectableText(
                          'Business Name - ${state.googleId}',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const Spacer(),

                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ChangeNotifierProvider(create: (context) => ComparisonPageState(context), child: ComparisonPage());
                                  }
                                )
                              );
                            },
                            child: Container(decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(4.0))
                            ), child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text("Compare with another business", style: Theme.of(context).textTheme.titleMedium),
                            )),
                          ),
                        )

                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: const BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText("Analysis", style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 8.0),
                          SelectableText(loremImpsum, style: Theme.of(context).textTheme.bodyLarge),
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
    );
  }
}
