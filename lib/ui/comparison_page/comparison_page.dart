import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../util/constants.dart';
import 'comparison_page_state.dart';

class ComparisonPage extends StatelessWidget {
  const ComparisonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ComparisonPageState>();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 70, // Remove the shadow
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Row(
            children: [
              Text("Back to Business Analysis",
                  style: Theme.of(context).textTheme.titleMedium),
              Spacer(),
              Center(
                  child: Text("Competitor Analysis Page",
                      style: Theme.of(context).textTheme.titleMedium)),
              Spacer(
                flex: 2,
              )
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 214, 184, 191),
        body: Center(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(40, 0, 40, 40),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: Image.asset(
                    'assets/images/cp-bg-2.png',
                  ).image,
                ),
                // color: Color.fromARGB(255, 179, 152, 158),
                // borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: state.gptResponse == null
                    ? Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Conducting competitor analysis",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.white,
                              size: 50,
                            ),
                          ],
                        ),
                      )
                    : FutureBuilder(
                        future: state.gptResponse,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Creating your competitor report",
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  LoadingAnimationWidget.staggeredDotsWave(
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ],
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return const SelectableText(
                                'Failed to fetch description');
                          } else {
                            return ListView(
                                padding: const EdgeInsets.all(24.0),
                                children: [
                                  SelectableText(
                                    '${state.previousBusinessDetails.name} vs. ${state.currentBusinessDetails!.name}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  ),
                                  const SizedBox(height: 12.0),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(16.0),
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12.0))),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SelectableText(
                                                  "${state.previousBusinessDetails.name}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge),
                                              const SizedBox(height: 8.0),
                                              SelectableText(
                                                  state
                                                      .previousBusinessAnalysis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8.0),
                                      Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(16.0),
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12.0))),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SelectableText(
                                                  "${state.currentBusinessDetails!.name}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge),
                                              const SizedBox(height: 8.0),
                                              SelectableText(
                                                  state
                                                      .currentBusinessAnalysis!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 12.0),
                                  Container(
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.0))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SelectableText("Final Comparison",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge),
                                        const SizedBox(height: 8.0),
                                        SelectableText(loremImpsum,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge),
                                      ],
                                    ),
                                  ),
                                ]);
                          }
                        }),
              ),
            ),
          ),
        ));
  }
}
