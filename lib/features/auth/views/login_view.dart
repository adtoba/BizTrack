import 'package:biz_track/features/auth/views/login_employee_view.dart';
import 'package:biz_track/features/auth/views/login_owner_view.dart';
import 'package:biz_track/features/auth/views/signup_view.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/style/custom_text_styles.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/extensions.dart';
import 'package:biz_track/shared/utils/navigator.dart';
import 'package:biz_track/shared/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Scaffold(
      // appBar: const CustomAppBar(
      //   title: "Clock In",
      // ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(22)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const YMargin(70),
            Text(
              "Welcome to BizTrack!",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: config.sp(24),
                color: ColorPalette.textColor
              ),
            ),
            const YMargin(10),
            Text(
              "Login as the Business Owner or Employee",
              textAlign: TextAlign.center,
              style: CustomTextStyle.regular16,
            ),
            const YMargin(50),
            Center(
              child: SvgPicture.asset(
                "login_in_book".svg,
                alignment: Alignment.center,
              ),
            ),
            const YMargin(20),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: LoginWidget(
                    title: "Clock in as \nOwner",
                    backgroundColor: ColorPalette.primary,
                    onTap: () => push(const LoginOwnerView()),
                    child: Icon(
                      Icons.person, 
                      size: config.sh(60), 
                      color: ColorPalette.white
                    )
                  ),
                ),
                const XMargin(20),
                Expanded(
                  child: LoginWidget(
                    title: "Clock in as \nEmployee",
                    onTap: () => push(const LoginEmployeeView()),
                    child: Icon(
                      Icons.people, 
                      size: config.sh(60), 
                      color: ColorPalette.primary
                    )
                  ),
                ),
              ],
            ),
            // CustomAuthButton(
            //   icon: const Icon(Icons.person, color: Colors.white),
            //   text: "Log in as Owner",
            //   onTap: () {
            //     push(const LoginOwnerView());
            //   },
            // ),
            // const YMargin(20),
            // // const YMargin(20),
            // // Center(
            // //   child: Text("Or", style: CustomTextStyle.regular16,)
            // // ),
            // // const YMargin(20),
            // CustomAuthButton(
            //   icon: const Icon(Icons.people, color: Colors.white),
            //   text: "Log in as Employee",
            //   onTap: () {
            //     push(const LoginEmployeeView());
            //   },
            // ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: CustomTextStyle.regular16,
                ),
                TextButton(
                  onPressed: () {
                    push(const SignUpView());
                  }, 
                  child: Text(
                    "Sign Up",
                    style: CustomTextStyle.regular16.copyWith(
                      color: ColorPalette.primary
                    ),
                  )
                )
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}


class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key, this.child, this.title, this.backgroundColor, this.textColor, this.onTap});

  final Widget? child;
  final String? title;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              height: config.sh(100),
              // width: config.sw(100),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: backgroundColor ?? Colors.white,
                border: Border.all(
                  color: Colors.grey,
                  width: 1
                ),
                borderRadius: BorderRadius.circular(8)
              ),
              child: child,
            ),
          ),
          const YMargin(5),
          Text(
            title!,
            textAlign: TextAlign.center,
            style: CustomTextStyle.regular16.copyWith(
              color: textColor ?? ColorPalette.textColor
            ),
          )
        ],
      ),
    );
  }
}