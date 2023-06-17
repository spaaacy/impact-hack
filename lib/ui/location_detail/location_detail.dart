import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:impact_hack/ui/home_page/home_page.dart';
import 'package:impact_hack/ui/home_page/home_page_state.dart';
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
                                SelectableText(state.locationAnalysis!,
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
