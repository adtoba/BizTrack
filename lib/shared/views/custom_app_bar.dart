import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return AppBar(
      centerTitle: true,
      iconTheme: Theme.of(context).appBarTheme.iconTheme,
      automaticallyImplyLeading: true,
      elevation: Theme.of(context).appBarTheme.elevation,
      title: Text(
        "$title",
        style: GoogleFonts.rubik(),
      ),
      titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
        fontSize: config.sp(20)
      )
    );
  }

  @override
  Size get preferredSize => Size(AppBar().preferredSize.width, AppBar().preferredSize.height);
}