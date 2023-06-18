import 'package:flutter/material.dart';
import 'package:impact_hack/util/helpers.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../util/constants.dart';
import 'monthly_comparison_state.dart';

class MonthlyComparison extends StatelessWidget {
  const MonthlyComparison({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MonthlyComparisonState>();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, // Remove the shadow
          toolbarHeight: 70,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 60,
                child: Image.asset(
                  'assets/images/lemons-logo.png',
                  fit: BoxFit.fill,
                ),
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
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.darken),
                  fit: BoxFit.fill,
                  image: Image.asset(
                    'assets/images/night-sky.jpg',
                  ).image,
                ),
                // color: Color.fromARGB(255, 179, 152, 158),
                // borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: state.comparisonLoaded == false
                    ? Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Generating your month report",
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
                    : ListView(padding: const EdgeInsets.all(24.0), children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                          child: Center(
                            child: Column(
                              children: [
                                SelectableText(
                                  '${state.businessDetails!.name} ${state.lastMonthString} vs. ${state.thisMonthString}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 54,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SelectableText(
                                  "A comprehensive evaluation of monthly business progress",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 218, 218, 218),
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SelectableText(
                                      state.lastMonthString,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 38,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 12.0),
                                    SelectableText(
                                        state.businessAnalysisLastMonth!,
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SelectableText(
                                      state.thisMonthString,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 38,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 12.0),
                                    SelectableText(
                                        state.businessAnalysisThisMonth!,
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SelectableText(
                                "Final comparison between the previous and current months",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12.0),
                              SelectableText(state.comparisonAnalysis!,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  )),
                            ],
                          ),
                        ),
                      ]),
              ),
            ),
          ),
        ));
  }
}
