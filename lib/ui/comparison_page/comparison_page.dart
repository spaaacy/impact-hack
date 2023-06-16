import 'package:flutter/material.dart';
import 'package:impact_hack/util/constants.dart';
import 'package:provider/provider.dart';

import 'comparison_page_state.dart';

class ComparisonPage extends StatelessWidget {
  const ComparisonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<ComparisonPageState>();

    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          padding: const EdgeInsets.all(24.0),
            children: [
          SelectableText(
            '${state.previousBusinessDetails.name} vs. ${state.currentBusinessDetails!.name}',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration:
                      const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText("${state.previousBusinessDetails.name}", style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8.0),
                      SelectableText(state.previousBusinessAnalysis, style: Theme.of(context).textTheme.bodyLarge),
                      SelectableText(loremImpsum, style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration:
                      const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText("${state.currentBusinessDetails!.name}", style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8.0),
                      SelectableText(loremImpsum, style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 12.0),

          Container(
            padding: const EdgeInsets.all(16.0),
            decoration:
            const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText("Final Comparison", style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8.0),
                SelectableText(loremImpsum, style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),


        ]));
  }
}
