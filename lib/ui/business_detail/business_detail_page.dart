import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../data/model/chatgpt_response.dart';
import '../../data/model/suggestion.dart';
import '../../services/business_service.dart';
import '../../util/helpers.dart';
import '../comparison_page/comparison_page.dart';
import '../comparison_page/comparison_page_state.dart';
import 'business_detail_page_state.dart';

class BusinessDetailPage extends StatelessWidget {
  const BusinessDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BusinessDetailPageState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        // Remove the shadow
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
            Spacer(),

            ElevatedButton.icon(
              onPressed: () {
                // Perform search action
                showDialog(
                    context: context,
                    builder: (context) {
                      final businessService = BusinessService();
                      String lang =
                          Localizations.localeOf(context).languageCode;

                      return Dialog(
                        child: Container(
                          width: 600,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: Offset(7, 7),
                              ),
                            ],
                          ),
                          child: TypeAheadField(
                            keepSuggestionsOnLoading: true,
                            hideOnEmpty: true,
                            hideOnLoading: true,
                            hideOnError: true,
                            suggestionsBoxDecoration:
                                const SuggestionsBoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              elevation: 4.0,
                            ),
                            suggestionsCallback: (input) async {
                              if (input.toLowerCase() == 'mid valley') {
                                final results = <Suggestion>[];
                                results.add(Suggestion(
                                    googleId:
                                        '0x31cc498ea887c2d7:0x90dfd956df69d7ba',
                                    description:
                                        'Cititel Mid Valley, Lingkaran Syed Putra, Mid Valley City'));
                                final suggestions = await businessService
                                    .fetchSuggestions(input: input, lang: lang);
                                for (var element in suggestions) {
                                  results.add(element);
                                }
                                return results.take(8);
                              } else if (input.toLowerCase() == 'pudu') {
                                final results = <Suggestion>[];
                                results.add(Suggestion(
                                    googleId:
                                        '0x31cc362411d7ed65:0x991cf8b34b238fd4',
                                    description:
                                        'Hotel Pudu Plaza, Jalan 1/77C, Pudu'));
                                final suggestions = await businessService
                                    .fetchSuggestions(input: input, lang: lang);
                                for (var element in suggestions) {
                                  results.add(element);
                                }
                                return results.take(8);
                              } else {
                                final results = await businessService
                                    .fetchSuggestions(input: input, lang: lang);
                                return results.take(8);
                              }
                            },
                            itemBuilder: (context, suggestion) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  trimDescription(suggestion.description)
                                      .capitalize(),
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                              );
                            },
                            onSuggestionSelected: (suggestion) async {
                              Navigator.of(state.context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChangeNotifierProvider(
                                              create: (context) {
                                                return ComparisonPageState(
                                                  context,
                                                  suggestion.googleId,
                                                  state.businessAnalysis!,
                                                  state.businessDetails!,
                                                  state.businessReviews!,
                                                );
                                              },
                                              child: const ComparisonPage())));
                            },
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: state.searchController,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.search),
                                suffixIcon:
                                    state.searchController.text.isNotEmpty
                                        ? IconButton(
                                            icon: const Icon(Icons.close),
                                            color: Colors.black,
                                            onPressed: () {
                                              state.searchController.clear();
                                            })
                                        : null,
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                    borderSide: BorderSide.none),
                                hintText: "Who do you have in mind?",
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              },
              icon: Icon(Icons.search),
              label: Text("Compare with other businesses"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsetsDirectional.fromSTEB(10, 20, 20, 20),
                backgroundColor: Color.fromARGB(255, 45, 68, 145),
                foregroundColor: Colors.white,
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
            //sSizedBox(width: 30.0)
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
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${state.businessDetails!.name}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 48,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        "A comprehensive business analysis",
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
                                          state.businessAnalysis!,
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
