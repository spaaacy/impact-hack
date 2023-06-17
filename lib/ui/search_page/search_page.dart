import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:impact_hack/ui/search_page/search_page_state.dart';
import 'package:provider/provider.dart';

import '../../data/model/suggestion.dart';
import '../../services/business_service.dart';
import '../../util/helpers.dart';
import '../business_detail/business_detail_page.dart';
import '../business_detail/business_detail_page_state.dart';
import '../monthly_comparison/monthly_comparison.dart';
import '../monthly_comparison/monthly_comparison_state.dart';

class SearchPage extends StatelessWidget {
  final _businessService = BusinessService();

  SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String lang = Localizations.localeOf(context).languageCode;
    final state = context.watch<SearchPageState>();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, // Remove the shadow
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Search", style: Theme.of(context).textTheme.titleMedium),
        ),
        backgroundColor: Color.fromARGB(255, 214, 184, 191),
        body: Padding(
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
                  'assets/images/5.jpg',
                ).image,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Search for your business",
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 600,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(7, 7),
                        ),
                      ],
                    ),
                    child: TypeAheadField(
                      keepSuggestionsOnLoading: true,
                      hideOnEmpty: true,
                      hideOnLoading: true,
                      hideOnError: true,
                      suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        elevation: 4.0,
                      ),
                      suggestionsCallback: (input) async {
                        if (input.toLowerCase() == 'mid valley') {
                          final results = <Suggestion>[];
                          results.add(Suggestion(
                              googleId: '0x31cc498ea887c2d7:0x90dfd956df69d7ba',
                              description: 'Cititel Mid Valley, Lingkaran Syed Putra, Mid Valley City'));
                          final suggestions = await _businessService.fetchSuggestions(input: input, lang: lang);
                          for (var element in suggestions) {
                            results.add(element);
                          }
                          return results.take(8);
                        } else if (input.toLowerCase() == 'pudu') {
                          final results = <Suggestion>[];
                          results.add(Suggestion(
                              googleId: '0x31cc362411d7ed65:0x991cf8b34b238fd4',
                              description: 'Hotel Pudu Plaza, Jalan 1/77C, Pudu'));
                          final suggestions = await _businessService.fetchSuggestions(input: input, lang: lang);
                          for (var element in suggestions) {
                            results.add(element);
                          }
                          return results.take(8);
                        } else {
                          final results = await _businessService.fetchSuggestions(input: input, lang: lang);
                          return results.take(8);
                        }
                      },
                      itemBuilder: (context, suggestion) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            trimDescription(suggestion.description).capitalize(),
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        );
                      },
                      onSuggestionSelected: (suggestion) async {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          if (state.monthly) {
                            return ChangeNotifierProvider(
                                create: (context) => MonthlyComparisonState(
                                    context, suggestion.googleId),
                                child: const MonthlyComparison());
                          } else {
                            return ChangeNotifierProvider(
                                create: (context) => BusinessDetailPageState(
                                    context, suggestion.googleId),
                                child: const BusinessDetailPage());
                          }
                        }));
                      },
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: state.searchController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: state.searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.close),
                                  color: Colors.black,
                                  onPressed: () {
                                    state.searchController.clear();
                                  })
                              : null,
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12.0)), borderSide: BorderSide.none),
                          hintText: "Where is your location?",
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  SizedBox(
                    width: 600,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SelectableText("Monthly Analysis"),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Switch(
                          value: state.monthly,
                          onChanged: (value) => state.monthly = value,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
