import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shortly/components/base/app_scaffold.dart';
import 'package:shortly/screens/onboarding_page/onboarding_components/onboarding_dot_widget.dart';
import 'package:shortly/screens/onboarding_page/onboarding_components/onoarding_container.dart';
import 'package:shortly/shared/constants.dart';

import '../../components/data_display/app_text.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentIndex = 0;

  PageController? _controller;
  @override
  void initState() {

    super.initState();
    _controller = PageController(initialPage: 0);
  }
  @override
  void dispose(){
    _controller?.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/images/logo.svg",
                  ),
                ),
              ),

              const SizedBox(height: 140,),
              SizedBox(
                height: 400,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (value){
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  itemCount: 3,
                    itemBuilder: (context, index){

                      // contents of slider
                      return  Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 4),
                        child: OnoardingContainer(index: index,),
                      );
                    }
                ),
              ),

              OnboardingDotWidget(index: currentIndex,),

              const SizedBox(height: 80,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: ()async{
                      if(currentIndex == 2) {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setString('next_onboarding', 'true');
                      }
                      Navigator.pushNamedAndRemoveUntil(context, home, (route) => false);

                    },
                    child: AppText(
                      currentIndex != 2 ? 'Skip' : 'Next',
                      style: TextStyles.bodySmall,
                    ),
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}


