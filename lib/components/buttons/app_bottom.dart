import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shortly/components/data_display/app_text.dart';

class AppButton extends StatefulWidget {
  const AppButton(
      {Key? key,
      this.title = "",
      this.icon,
      required this.onTap,
      this.loading = false,
      this.error = '',
      this.color,
      this.textColor})
      : super(key: key);

  final String title;
  final Widget? icon;
  final VoidCallback onTap;
  final bool loading;
  final String error;
  final Color? color;
  final Color? textColor;

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> with TickerProviderStateMixin {
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

  Widget _buildIcon() {
    if (widget.icon != null && (widget.title != "")) {
      return Container(
          margin: const EdgeInsets.only(right: 12.0),
          height: 24.0,
          child: widget.icon);
    } else if (widget.icon != null) {
      return SizedBox(
        height: 18.0,
        width: 18.0,
        child: widget.icon,
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IgnorePointer(
          ignoring: (widget.error ?? "").isEmpty,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            opacity: (widget.error ?? "").isEmpty ? 0 : 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    border: Border.all(
                        color: Theme.of(context).disabledColor, width: 1.0),
                    borderRadius: BorderRadius.circular(6)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0,left: 6.0),
                      child: Icon(EvaIcons.alertTriangle,
                          color: Theme.of(context).errorColor, size: 14),
                    ),
                    const SizedBox(width: 16),
                    if((widget.error ?? "").isNotEmpty)
                    Flexible(
                      child: AppText(
                        (widget.error ?? ""),
                        style: TextStyles.bodyMedium,
                        regular: true,
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
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
              height: 56,
              width: double.infinity,
              duration: const Duration(milliseconds: 75),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    8,
                  ),
                ),
                color: (widget.color ?? Theme.of(context).primaryColor),
              ),
              child: widget.loading
                  ? SpinKitThreeBounce(
                      color: Theme.of(context).backgroundColor,
                      size: 15,
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        _buildIcon(),
                        AppText(
                          widget.title,
                          style: TextStyles.displayMedium,
                          color: widget.textColor ?? Colors.white,
                        ),
                      ],
                    ),
            ),
          ),
        )
      ],
    );
  }
}
