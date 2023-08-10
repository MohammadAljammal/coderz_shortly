import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:shortly/components/base/arrow_back.dart';
import 'package:shortly/components/data_display/app_text.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;
  final Function? arrowBackFunction;
  final bool isShowArrowBack;

  const AppAppBar(
      {Key? key,
      required this.appBarTitle,
      this.arrowBackFunction,
      this.isShowArrowBack = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          leading: isShowArrowBack
              ? ArrowBack(
                  color: Colors.black,
                  onTap: arrowBackFunction,
                )
              : null,
          title: AppText(
            appBarTitle,
            style: TextStyles.bodyMedium,
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 60);
}
