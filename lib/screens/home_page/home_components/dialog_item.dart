import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shortly/components/data_display/app_text.dart';
import 'package:shortly/models/short_link/short_link.dart';
import 'package:shortly/services/short_link_service.dart';

class DialogItem extends StatelessWidget {
  final ShortLink shortLink;

  const DialogItem({Key? key, required this.shortLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShortLinkService shortLinkService = Provider.of(context);
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 35.0,
        vertical: 20.0,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: [
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              )
            ],
          ),
          const AppText(
            'Delete Short Link',
            style: TextStyles.titleMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          const AppText(
            'Are you shor you want to delete the short link?',
            style: TextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DialogButton(
                color: Theme.of(context).dividerColor,
                textColor: Theme.of(context).colorScheme.secondary,
                title: "Cancel",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                width: 15,
              ),
              DialogButton(
                title: 'Delete',
                onTap: () async {
                  await shortLinkService.deleteShortLink(link: shortLink);
                  Navigator.pop(context);
                },
                textColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DialogButton extends StatefulWidget {
  const DialogButton({
    super.key,
    this.title = "",
    required this.onTap,
    this.color,
    this.textColor,
  });

  final String title;

  final VoidCallback onTap;
  final Color? color;
  final Color? textColor;

  @override
  _DialogButtonState createState() => _DialogButtonState();
}

class _DialogButtonState extends State<DialogButton>
    with TickerProviderStateMixin {
  double _buttonSize = 1.0;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        lowerBound: 0.7,
        upperBound: 1.0,
        duration: const Duration(milliseconds: 120));
    _animation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutQuad,
        reverseCurve: Curves.easeOutQuad);
    _animation.addListener(() {
      setState(() {
        _buttonSize = _animation.value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails tap) {
        _animationController.reverse(from: 1.0);
      },
      onTapUp: (TapUpDetails tap) {
        _animationController.forward();
      },
      onTapCancel: () {
        _animationController.forward();
      },
      onTap: Feedback.wrapForTap(widget.onTap, context),
      behavior: HitTestBehavior.opaque,
      child: Transform.scale(
        scale: _buttonSize,
        child: AnimatedContainer(
          height: 35,
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
            color: widget.color ??
                Theme.of(context).primaryColor.withOpacity(0.75),
          ),
          child: Center(
            child: AppText(
              widget.title,
              style: TextStyles.bodyMedium,
              color: widget.textColor ?? Colors.black,
              bold: true,
            ),
          ),
        ),
      ),
    );
  }
}
