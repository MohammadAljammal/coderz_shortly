import 'package:flutter/material.dart';

class OnboardingDotWidget extends StatelessWidget {
  OnboardingDotWidget({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...[0, 1, 2].map((int e) => Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: index == e
                      ? Theme.of(context).disabledColor
                      : Theme.of(context).scaffoldBackgroundColor,
                  border: Border.all(
                    color: Theme.of(context).disabledColor,
                    width: 1.5,
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
