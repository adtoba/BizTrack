import 'dart:io';

import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Container(
      height: config.sh(100),
      width: config.sw(120),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black.withOpacity(.3)
      ),
      child: Platform.isIOS 
        ? CupertinoActivityIndicator(
          color: Colors.white,
          radius: config.sh(20),
        ) 
        : const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        )
    );
  }
}