import 'package:flutter/material.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/styles.dart';

class AppBarHeader extends StatefulWidget implements PreferredSizeWidget {
  const AppBarHeader({
    super.key,
    required this.title,
    this.titleSpacing = 0.0,
    this.leadingWidth = 56.0,
    this.leadingIconButton,
    this.trailingIconButtons,
    this.showDefaultBackButton = true,
    this.iconThemeColor = AppUIColors.green,
  });

  final String title;
  final double titleSpacing;
  final double leadingWidth;
  final Widget? leadingIconButton;
  final List<Widget>? trailingIconButtons;
  final bool showDefaultBackButton;
  final Color iconThemeColor;

  static double headerHeight = 56.0;

  @override
  State<StatefulWidget> createState() => AppBarHeaderState();

  @override
  Size get preferredSize => Size.fromHeight(headerHeight);
}

class AppBarHeaderState extends State<AppBarHeader> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: getPageTitle(widget.title, context),
      backgroundColor: AppUIColors.green,
      leading: widget.leadingIconButton,
      actions: widget.trailingIconButtons,
      automaticallyImplyLeading: widget.showDefaultBackButton,
      iconTheme: IconThemeData(color: widget.iconThemeColor),
      elevation: 0.5,
    );
  }

  Widget getPageTitle(String text, BuildContext context) {
    return Text(
      text,
      style: Styles.appBarTitleStyle(context),
    );
  }
}
