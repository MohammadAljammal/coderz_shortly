import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shortly/components/data_display/app_text.dart';
import 'package:shortly/screens/onboarding_page/onboarding_static_data/onboarding_static_data.dart';

class OnoardingContainer extends StatelessWidget {
  OnoardingContainer({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          width: MediaQuery.of(context).size.width,
          height: 350,
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(
                OnboardingStaticData.title[index],
                style: TextStyles.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              AppText(
                OnboardingStaticData.subTitle[index],
                style: TextStyles.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Align(
          alignment: const Alignment(0.1, -1.3),
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Theme.of(context).primaryColorDark,
            ),
            child: Center(
              child: SvgPicture.asset(
                "assets/images/${OnboardingStaticData.imageName[index]}.svg",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
