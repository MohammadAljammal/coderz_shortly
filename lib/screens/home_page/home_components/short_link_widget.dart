import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shortly/components/buttons/app_bottom.dart';
import 'package:shortly/components/data_display/app_text.dart';
import 'package:shortly/models/short_link/short_link.dart';
import 'package:shortly/screens/home_page/home_components/dialog_item.dart';

class ShortLinkWidget extends StatefulWidget {
  const ShortLinkWidget({Key? key, required this.shortLink}) : super(key: key);
  final ShortLink shortLink;

  @override
  State<ShortLinkWidget> createState() => _ShortLinkWidgetState();
}

class _ShortLinkWidgetState extends State<ShortLinkWidget> {
  bool copy = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(top: 16.0, bottom: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              children: [
                AppText(
                  widget.shortLink.originalLink ?? '',
                  maxLength: 25,
                  style: TextStyles.bodyMedium,
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DialogItem(
                          shortLink: widget.shortLink,
                        );
                      },
                    );
                  },
                  child: SvgPicture.asset(
                    "assets/images/del.svg",
                    width: 22,
                    height: 22,
                  ),
                )
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              children: [
                AppText(
                  widget.shortLink.shortLink ?? '',
                  maxLength: 25,
                  style: TextStyles.bodyMedium,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: AppButton(
                onTap: () async {
                  await Clipboard.setData(
                      ClipboardData(text: widget.shortLink.shortLink ?? ''));
                  setState(() {
                    copy = true;
                  });
                  Timer timer = Timer.periodic(const Duration(seconds: 2),
                      (Timer timer) async {
                    if(mounted) {
                      setState(() {
                      copy = false;
                    });
                      timer.cancel();
                    }
                  });
                },
                title: copy ? 'Copied!' : 'Copy',
                color: copy
                    ? Theme.of(context).primaryColorDark
                    : Theme.of(context).primaryColor,
              )),
        ],
      ),
    );
  }
}
