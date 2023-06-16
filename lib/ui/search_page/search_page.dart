import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:impact_hack/ui/search_page/search_page_state.dart';
import 'package:provider/provider.dart';

import '../../services/business_service.dart';
import '../../util/helpers.dart';
import '../business_detail/business_detail.dart';
import '../business_detail/business_detail_state.dart';

class SearchPage extends StatelessWidget {
  final _placeService = BusinessService();

  SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String lang = Localizations.localeOf(context).languageCode;
    final state = context.read<SearchPageState>();

    return Scaffold(
        appBar: AppBar(
          title: Text("Search", style: Theme.of(context).textTheme.titleMedium),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TypeAheadField(
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
                  final results = await _placeService.fetchSuggestions(
                      input: input, lang: lang);
                  return results.take(8);
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
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>
                        ChangeNotifierProvider(create: (context) => BusinessDetailState(context, suggestion.googleId), child: const BusinessDetail())
                    )
                  );
                },
                textFieldConfiguration: TextFieldConfiguration(
                  controller: state.searchController,
                  decoration: InputDecoration(
                    suffixIcon: state.searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close),
                            color: Colors.black,
                            onPressed: () {
                              state.searchController.clear();
                            })
                        : null,
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: "Where do you wish to go?",
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
