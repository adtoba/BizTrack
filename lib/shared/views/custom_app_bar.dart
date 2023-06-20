import 'package:biz_track/shared/style/color_palette.dart';
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
      iconTheme: IconThemeData(
        color: ColorPalette.primary
      ),
      automaticallyImplyLeading: true,
      elevation: .5,
      title: Text(
        "$title",
        style: GoogleFonts.rubik(),
      ),
      titleTextStyle: TextStyle(
        fontSize: config.sp(20),
        color: ColorPalette.primary,
        fontWeight: FontWeight.w700
      ),
    );
  }

  @override
  Size get preferredSize => Size(AppBar().preferredSize.width, AppBar().preferredSize.height);
}