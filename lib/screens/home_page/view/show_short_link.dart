import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortly/screens/home_page/home_components/short_link_widget.dart';
import 'package:shortly/services/short_link_service.dart';

class ShowShortLinkPage extends StatelessWidget {
  const ShowShortLinkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShortLinkService shortLinkService = Provider.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...shortLinkService.shortLinks.map((link) => Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 24.0, vertical: 8),
          child: ShortLinkWidget(shortLink: link),
        )),
        const SizedBox(
          height: 220,
        )
      ],
    );
  }
}
