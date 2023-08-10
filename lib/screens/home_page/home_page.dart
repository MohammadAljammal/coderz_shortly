import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shortly/components/Input/app_text_fields.dart';
import 'package:shortly/components/base/app_scaffold.dart';
import 'package:shortly/components/buttons/app_bottom.dart';
import 'package:shortly/screens/home_page/view/empty_data.dart';
import 'package:shortly/screens/home_page/view/show_short_link.dart';
import 'package:shortly/services/short_link_service.dart';
import 'package:shortly/utils/toast_utils.dart';
import 'package:shortly/utils/validators_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ShortLinkService shortLinkService;
  TextEditingController shortEditingController =
      TextEditingController(text: '');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      shortLinkService = Provider.of<ShortLinkService>(context, listen: false);
      shortLinkService.fetchShortLinks();
    });
  }

  @override
  Widget build(BuildContext context) {
    shortLinkService = Provider.of(context);
    return AppScaffold(
      isShowAppBar: shortLinkService.shortLinks.isNotEmpty,
      appBarTitle:
          shortLinkService.shortLinks.isNotEmpty ? 'Your Link History' : '',
      body: shortLinkService.isLoadingLink
          ? SpinKitFadingCircle(
              color: Theme.of(context).primaryColorDark,
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: SingleChildScrollView(
                child: !shortLinkService.shortLinks.isNotEmpty
                    ? const EmptyDataPage()
                    : const ShowShortLinkPage()
              ),
            ),
      bottomSheet: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  "assets/images/shape.svg",
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppTextField(
                      controller: shortEditingController,
                      hintText: 'Shorten a link here...',
                      fontSize: 17,
                      validator: ValidatorUtils.validateURL,
                    ),
                    AppButton(
                      onTap: () async {
                        shortLinkService.reSetError();
                        final form = formKey.currentState;
                        if (form!.validate()) {
                          form.save();
                          FocusScope.of(context).unfocus();
                          await shortLinkService
                              .getShortLink(
                            link: shortEditingController.text,
                          )
                              .then((value) {
                            setState(() {
                              shortEditingController.text = '';
                            });
                            ToastUtils.showToast(msg: 'Add success');
                          }).catchError((onError) {});
                        }
                      },
                      error: shortLinkService.errorGetGetShortLink,
                      loading: shortLinkService.isLoadingGetShortLink,
                      title: 'Short it!',
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
