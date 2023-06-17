import 'package:flutter/material.dart';
import 'package:impact_hack/util/helpers.dart';
import 'package:provider/provider.dart';

import '../../util/constants.dart';
import 'monthly_comparison_state.dart';

class MonthlyComparison extends StatelessWidget {
  const MonthlyComparison({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MonthlyComparisonState>();

    return Scaffold(
        appBar: AppBar(),
        body: state.secondLoaded == false
            ? const Center(child: CircularProgressIndicator())
            : ListView(padding: const EdgeInsets.all(24.0), children: [
                SelectableText(
                  '${state.businessDetails!.name} ${state.lastMonthString} vs. ${state.thisMonthString}',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: const BoxDecoration(
                            color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12.0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SelectableText(state.lastMonthString,
                                style: Theme.of(context).textTheme.titleLarge),
                            const SizedBox(height: 8.0),
                            SelectableText(state.businessAnalysisLastMonth!,
                                style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: const BoxDecoration(
                            color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12.0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SelectableText(state.thisMonthString,
                                style: Theme.of(context).textTheme.titleLarge),
                            const SizedBox(height: 8.0),
                            SelectableText(state.businessAnalysisThisMonth!,
                                style: Theme.of(context).textTheme.bodyLarge),
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
