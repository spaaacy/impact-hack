import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:impact_hack/ui/home_page/home_page.dart';
import 'package:impact_hack/ui/home_page/home_page_state.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../data/model/chatgpt_response.dart';
import '../../data/model/suggestion.dart';
import '../../services/business_service.dart';
import '../../util/helpers.dart';
import '../comparison_page/comparison_page.dart';
import '../comparison_page/comparison_page_state.dart';
import 'location_detail_state.dart';

class LocationDetail extends StatelessWidget {
  const LocationDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LocationDetailState>();

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
      backgroundColor: Color.fromARGB(255, 112, 139, 165),
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
              child: state.gptResponse == null
                  ? Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Retrieving business data",
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
                  : FutureBuilder<ChatCompletionResponse?>(
                      future: state.gptResponse,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Generating your curated response",
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
                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'LOCATION_NAME_PLACEHOLDER',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 48,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "A comprehensive locational analysis",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 26,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 32),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SelectableText(
                                          state.locationAnalysis!,
                                          textAlign: TextAlign.justify,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
