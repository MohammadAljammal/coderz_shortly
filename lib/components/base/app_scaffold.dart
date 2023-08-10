import 'package:flutter/material.dart';
import 'package:shortly/components/base/app_bar.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomSheet;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final String? appBarTitle;
  final Function? arrowBackFunction;
  final bool isShowArrowBack;
  final bool isShowAppBar;

  const AppScaffold(
      {Key? key,
      required this.body,
      this.bottomSheet,
      this.backgroundColor,
      this.appBar,
      this.appBarTitle = "",
      this.arrowBackFunction,
      this.isShowArrowBack = false,
      this.isShowAppBar = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      appBar: isShowAppBar
          ? appBar ??
              AppAppBar(
                  appBarTitle: appBarTitle!,
                  arrowBackFunction: arrowBackFunction,
                  isShowArrowBack: isShowArrowBack,
              )
          : null,
      body: body,
      bottomSheet: bottomSheet,
    );
  }
}
