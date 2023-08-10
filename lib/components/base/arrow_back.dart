import 'package:flutter/material.dart';

class ArrowBack extends StatelessWidget {
  final Function? onTap;
  final Color? color;

  const ArrowBack({Key? key, this.onTap, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: Feedback.wrapForTap(() {
        onTap != null ? onTap!() : Navigator.pop(context);
      }, context),
      child: Icon(
        Icons.arrow_back_ios,
        color: color ?? Colors.white,
      ),
    );
  }
}
