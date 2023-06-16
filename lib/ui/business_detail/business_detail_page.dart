import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:impact_hack/ui/home_page/home_page.dart';
import 'package:impact_hack/ui/home_page/home_page_state.dart';
import 'package:provider/provider.dart';

import '../../data/model/chatgpt_response.dart';
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
      appBar: AppBar(title: const SelectableText('Analysis')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: state.gptResponse == null
              ? const CircularProgressIndicator()
              : FutureBuilder<ChatCompletionResponse?>(
                  future: state.gptResponse,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const SelectableText(
                          'Failed to fetch description');
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SelectableText(
                                '${state.businessDetails!.name}',
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                              const Spacer(),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          final businessService =
                                              BusinessService();
                                          String lang =
                                              Localizations.localeOf(context)
                                                  .languageCode;

                                          return Dialog(
                                            child: TypeAheadField(
                                              keepSuggestionsOnLoading: true,
                                              hideOnEmpty: true,
                                              hideOnLoading: true,
                                              hideOnError: true,
                                              suggestionsBoxDecoration:
                                                  const SuggestionsBoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.0)),
                                                elevation: 4.0,
                                              ),
                                              suggestionsCallback:
                                                  (input) async {
                                                final results =
                                                    await businessService
                                                        .fetchSuggestions(
                                                            input: input,
                                                            lang: lang);
                                                return results.take(8);
                                              },
                                              itemBuilder:
                                                  (context, suggestion) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    trimDescription(suggestion
                                                            .description)
                                                        .capitalize(),
                                                    style: const TextStyle(
                                                        fontSize: 16.0),
                                                  ),
                                                );
                                              },
                                              onSuggestionSelected:
                                                  (suggestion) async {
                                                Navigator.of(state.context).pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChangeNotifierProvider(
                                                                create:
                                                                    (context) {
                                                                  return ComparisonPageState(
                                                                    context,
                                                                    suggestion
                                                                        .googleId,
                                                                    state
                                                                        .businessAnalysis!,
                                                                    state
                                                                        .businessDetails!,
                                                                    state
                                                                        .businessReviews!,
                                                                  );
                                                                },
                                                                child:
                                                                    const ComparisonPage())));
                                              },
                                              textFieldConfiguration:
                                                  TextFieldConfiguration(
                                                controller:
                                                    state.searchController,
                                                decoration: InputDecoration(
                                                  suffixIcon: state
                                                          .searchController
                                                          .text
                                                          .isNotEmpty
                                                      ? IconButton(
                                                          icon: const Icon(
                                                              Icons.close),
                                                          color: Colors.black,
                                                          onPressed: () {
                                                            state
                                                                .searchController
                                                                .clear();
                                                          })
                                                      : null,
                                                  border:
                                                      const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none),
                                                  hintText:
                                                      "Where do you wish to go?",
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(
                                            "Compare with another business",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium),
                                      )),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 12.0),
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText("Analysis",
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                                const SizedBox(height: 8.0),
                                SelectableText(state.businessAnalysis!,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
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
