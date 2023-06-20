import 'package:biz_track/features/cashier/views/cashier_products_view.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class CashierDashboardView extends ConsumerStatefulWidget {
  const CashierDashboardView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CashierDashboardViewState();
}

class _CashierDashboardViewState extends ConsumerState<CashierDashboardView> {

  int currentIdx = 0;

  void onPageChanged(int index) {
    setState(() {
      currentIdx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    GlobalKey<ScaffoldState> key = GlobalKey();

    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),
      key: key,
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () => key.currentState!.openDrawer(), 
          icon: SvgPicture.asset(
            "menu_icon".svg,
            height: config.sh(50),
            width: config.sw(50),
          )
        ),
        centerTitle: true,
        title: const Text(
          "Cashier"
        ),
        titleTextStyle: TextStyle(
          fontSize: config.sp(20),
          color: ColorPalette.primary,
          fontWeight: FontWeight.w700
        ),
      ),
      body: PageView(
        onPageChanged: onPageChanged,
        children: [
          const CashierProductsView(),
          Container()
        ],
      ),
      drawer: SafeArea(
        bottom: false,
        child: Drawer(
          backgroundColor: ColorPalette.primary,
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24)
        ),
        child: BottomAppBar(
          child: SizedBox(
            height: config.sh(50),
            width: double.infinity,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BottomNavItem(
                    icon: "cashier_products",
                    label: "Products",
                    isSelected: currentIdx == 0,
                    onTap: () => onPageChanged(0),
                  ),
                  BottomNavItem(
                    icon: "cashier_favorites",
                    label: "Favorites",
                    isSelected: currentIdx == 1,
                    onTap: () => onPageChanged(1),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}


class BottomNavItem extends ConsumerWidget {
  const BottomNavItem({super.key, this.icon, this.label, this.onTap, this.isSelected = false});
  final String? icon;
  final String? label;
  final VoidCallback? onTap;
  final bool? isSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = SizeConfig();

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon!.svg,
            color: isSelected!
              ? ColorPalette.primary 
              : ColorPalette.textColor.withOpacity(.5),
          ),
          // const YMargin(5),
          // Text(
          //   label!,
          //   style: TextStyle(
          //     fontSize: config.sp(13),
          //     color: isSelected!
          //       ? ColorPalette.primary 
          //       : ColorPalette.textColor.withOpacity(.5),
          //   ),
          // )
        ],
      ),
    );
  }
}