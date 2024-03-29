
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final bool isToShowBackButton;

  const AppBarWidget(this.title, {super.key, this.isToShowBackButton = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      automaticallyImplyLeading: isToShowBackButton,
      title: title,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}