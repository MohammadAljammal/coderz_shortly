import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shortly/components/data_display/app_text.dart';

class EmptyDataPage extends StatelessWidget {
  const EmptyDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Center(
            child: SvgPicture.asset(
              "assets/images/logo.svg",
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/illustration.svg",
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width,
                ),
                const SizedBox(
                  height: 20,
                ),
                const AppText(
                  "Let's get started!",
                  style: TextStyles.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                const AppText(
                  "Paste your first link into\nthe field to shorten it",
                  style: TextStyles.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            )),
      ],
    );
  }
}
