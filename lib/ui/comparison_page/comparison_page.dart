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
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Row(
            children: [
              Text(
                "Back to Business Analysis",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 214, 184, 191),
        body: Center(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(40, 0, 40, 40),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
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
                child: state.comparisonGptResponse == null
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
                        future: state.comparisonGptResponse,
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
                                padding: const EdgeInsetsDirectional.all(20),
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 40),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          SelectableText(
                                            '${state.previousBusinessDetails.name} vs. ${state.currentBusinessDetails!.name}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 54,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SelectableText(
                                            "A comprehensive evaluation of both businesses",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 218, 218, 218),
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SelectableText(
                                                "${state.previousBusinessDetails.name}",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 38,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 12.0),
                                              SelectableText(
                                                  state
                                                      .previousBusinessAnalysis,
                                                  textAlign: TextAlign.justify,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16.0),
                                      Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SelectableText(
                                                "${state.currentBusinessDetails!.name}",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 38,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 12.0),
                                              SelectableText(
                                                  state
                                                      .currentBusinessAnalysis!,
                                                  textAlign: TextAlign.justify,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const SelectableText(
                                          "Final Comparison",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 38,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 12.0),
                                        SelectableText(
                                            state.comparisonAnalysis!,
                                            textAlign: TextAlign.justify,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            )),
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
