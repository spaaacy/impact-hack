import 'package:flutter/material.dart';
import 'package:impact_hack/ui/search_page/search_page.dart';
import 'package:impact_hack/ui/search_page/search_page_state.dart';
import 'package:provider/provider.dart';

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
              Row(
                children: [
                  const Text("PLACEHOLDER-NAME"),
                  const SizedBox(width: 16.0),
                  TextButton(
                    onPressed: () {
                      // Navigate to Search page
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                              create: (context) => SearchPageState(context),
                              child: SearchPage(),
                            ),
                          ));
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Search",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
              // Add a spacer to occupy the available space
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
              IconButton(
                onPressed: () {
                  // Perform avatar icon action
                },
                icon: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/39c.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 199, 184, 214),
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
              padding: EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(40, 0, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Visualise Your Prospects",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Empowering SMEs to take charge of monitoring business processes \nand predicting market strategies, with the help of cutting edge AI.",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Handle "Get Started" button press
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 66, 44, 146),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    26, 30, 34, 30),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                textStyle: TextStyle(fontSize: 18),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.play_arrow_rounded),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Get Started",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () {
                                // Handle "Try Demo" button press
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor:
                                    Color.fromARGB(255, 66, 44, 146),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 30),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                textStyle: TextStyle(fontSize: 18),
                              ),
                              child: Text("Try Demo"),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 75,
                        ),
                        const Text(
                          "Proudly powered by lots and lemons... and OpenAI API:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 200,
                              height: 200,
                              child:
                                  Image.asset('assets/images/chatgpt-logo.png'),
                            ),
                            SizedBox(width: 16),
                            Container(
                              width: 200,
                              height: 200,
                              child:
                                  Image.asset('assets/images/lemons-logo.png'),
                            ),
                            SizedBox(width: 16),
                            Container(
                              width: 200,
                              height: 200,
                              child:
                                  Image.asset('assets/images/juicer-logo.png'),
                            ),
                          ],
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
