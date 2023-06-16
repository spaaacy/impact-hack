import 'package:flutter/material.dart';
import 'package:impact_hack/util/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 60,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("PLACEHOLDER-NAME"),
              Spacer(),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      // Navigate to Home page
                    },
                    child: const Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  TextButton(
                    onPressed: () {
                      // Navigate to About Us page
                    },
                    child: const Text(
                      "About Us",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  TextButton(
                    onPressed: () {
                      // Navigate to Search page
                    },
                    child: const Text(
                      "Search",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  TextButton(
                    onPressed: () {
                      // Navigate to Pricing page
                    },
                    child: const Text(
                      "Pricing",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(), // Add a spacer to occupy the available space
              TextButton(
                onPressed: () {
                  // Navigate to Sign In page
                },
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  // Perform "Try for free" action
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  backgroundColor: Color.fromARGB(255, 0, 172, 252),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  foregroundColor: Colors.white,
                ),
                child: Text("Try for free"),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 191, 202, 207),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
                child: Text(loremImpsum,
                    style: Theme.of(context).textTheme.bodyLarge),
              )
            ],
          ),
        ));
  }
}
