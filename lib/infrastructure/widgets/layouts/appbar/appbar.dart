import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:sizer/sizer.dart';

class SGAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SGAppBar(
      {this.pageTitle,
      this.actions,
      super.key,
      this.widgetTitle,
      this.hideBackButton = false,
      this.bottom});

  final String? pageTitle;
  final Widget? widgetTitle;
  final PreferredSizeWidget? bottom;
  final List<SGAppBarItemAction>? actions;
  final bool hideBackButton;

  static const height = kToolbarHeight + (kToolbarHeight * .15);

  static Widget? _buildTitle(String? pageTitle, BuildContext context) {
    if (pageTitle == null) return null;
    return Text(pageTitle,
        style:
            context.text.titleLarge?.copyWith(color: context.color.onSurface));
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: widgetTitle ?? _buildTitle(pageTitle, context),
      backgroundColor: context.color.background,
      foregroundColor: context.color.onBackground,
      toolbarHeight: height,
      titleSpacing: 7.w,
      bottom: bottom,
      elevation: 0,
      shape:
          Border(bottom: BorderSide(color: context.color.outline, width: .25)),
      automaticallyImplyLeading: !hideBackButton,
      actions: actions
          ?.map((e) => GestureDetector(
                onTap: e.onTap,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: e.child,
                    ),
                  ],
                ),
              ))
          .toList(),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: context.color.surface,
          statusBarIconBrightness: Brightness.dark),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(height + (bottom?.preferredSize.height ?? 0));
}

class SGAppBarItemAction {
  final VoidCallback? onTap;
  final Widget child;

  SGAppBarItemAction({this.onTap, required this.child});

  factory SGAppBarItemAction.icon(
          {required IconData icon, EdgeInsets? padding, VoidCallback? onTap}) =>
      SGAppBarItemAction(
          child: padding != null
              ? Padding(
                  padding: padding,
                  child: Icon(icon),
                )
              : Icon(icon),
          onTap: onTap);
}
