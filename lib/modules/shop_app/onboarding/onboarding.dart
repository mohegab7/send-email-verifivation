import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/shop_app/login/login_shop.dart';
import 'package:flutter_application_1/shared/components/components.dart';
import 'package:flutter_application_1/shared/network/local/cache_helper.dart';
import 'package:flutter_application_1/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class boardingModel {
  late final String image;
  late final String title;
  late final String body;
  boardingModel({
    required this.image,
    required this.body,
    required this.title,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var boardController = PageController();

  List<boardingModel> boarding = [
    boardingModel(
      image:
          'https://storage.googleapis.com/profit-prod/wp-content/uploads/2022/05/cd0bb0f3-employee-onboarding.png',
      body: 'onbody 1',
      title: 'on title 1',
    ),
    boardingModel(
      image:
          'https://storage.googleapis.com/profit-prod/wp-content/uploads/2022/05/cd0bb0f3-employee-onboarding.png',
      body: 'onbody 2',
      title: 'on title 2',
    ),
    boardingModel(
      image:
          'https://storage.googleapis.com/profit-prod/wp-content/uploads/2022/05/cd0bb0f3-employee-onboarding.png',
      body: 'onbody 3',
      title: 'on title 3',
    ),
  ];

  bool islast = false;
  void sumbit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        NavigateAndFinish(
          context,
          LoginShop_Screen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: sumbit,
            child: Text(
              'skip',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: defaultColor),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                itemBuilder: (BuildContext context, int index) =>
                    buildboardingitem(boarding[index]),
                itemCount: boarding.length,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      islast = true;
                    });
                  } else {
                    setState(() {
                      islast = false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 12.0,
                    dotWidth: 12.0,
                    spacing: 5.0,
                    expansionFactor: 4,
                    activeDotColor: defaultColor,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (islast) {
                      sumbit();
                    } else {
                      boardController.nextPage(
                          duration: const Duration(
                            milliseconds: 950,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios_outlined),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildboardingitem(boardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: NetworkImage(model.image),
            ),
          ),
          Text(
            model.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            model.body,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      );
}
