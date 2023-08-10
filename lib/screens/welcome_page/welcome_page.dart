import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shortly/components/base/app_scaffold.dart';
import 'package:shortly/components/buttons/app_bottom.dart';
import 'package:shortly/components/data_display/app_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shortly/shared/constants.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SvgPicture.asset(
              "assets/images/logo.svg",
            ),
          ),

          /// We have Some issue on SVG Image, I didn't change it to png because the image will lose quality.
          SvgPicture.asset(
            "assets/images/illustration.svg",
            fit: BoxFit.fitWidth,
            width: MediaQuery.of(context).size.width,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: AppText(
              'More than just shorter links',
              style: TextStyles.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 38.0, vertical: 4),
            child: AppText(
              "Build your brand's recognition and get detailed insights on how your links are performing.",
              style: TextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 48.0,
            ),
            child: AppButton(
              onTap: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String ? checkNext =  prefs.getString('next_onboarding');
                if((checkNext??'').isNotEmpty && (checkNext??'') == 'true'){
                  Navigator.pushNamed(context, home);
                }else{
                  Navigator.pushNamed(context, onboarding);
                }

              },
              title: 'start',
            ),
          )
        ],
      ),
    );
  }
}
