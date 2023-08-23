import 'package:biz_track/features/cashier/views/cashier_drawer_view.dart';
import 'package:biz_track/features/cashier/views/cashier_products_view.dart';
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class CashierDashboardView extends ConsumerStatefulWidget {
  const CashierDashboardView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CashierDashboardViewState();
}

class _CashierDashboardViewState extends ConsumerState<CashierDashboardView> {

  int currentIdx = 0;
  
  GlobalKey<ScaffoldState> key = GlobalKey();

  final PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true
  );

  void onPageChanged(int index) {
    setState(() {
      _pageController.jumpToPage(index);
      currentIdx = index;
    });
  }

  bool? isConnected = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(printerViewModel).listenForPrinterState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var printerProvider = ref.watch(printerViewModel);
    
    return Scaffold(
      key: key,
      appBar: AppBar(
        elevation: Theme.of(context).appBarTheme.elevation,
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        leading: IconButton(
          onPressed: () => key.currentState!.openDrawer(), 
          icon: SvgPicture.asset(
            "menu_icon".svg,
            height: config.sh(15),
            width: config.sw(15),
            color: Theme.of(context).appBarTheme.iconTheme?.color,
          )
        ),
        centerTitle: true,
        title: Text(
          "Cashier",
          style: GoogleFonts.rubik(),
        ),
        titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
          fontSize: config.sp(20)
        ),
        actions: [
          Row(
            children: [
              Image.asset(
                "printer".png,
                height: config.sh(20),
                width: config.sw(20),
                color: ColorPalette.primary,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: config.sw(10), vertical: config.sh(10)),
                child: Text(
                  printerProvider.isConnected ? "CONNECTED" : "DISCONNECTED",
                  style: TextStyle(
                    color: printerProvider.isConnected ? Colors.green : Colors.red,
                    fontSize: config.sp(12)
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      body: const CashierProductsView(),
      // PageView(
        
      //   controller: _pageController,
      //   onPageChanged: onPageChanged,
      //   scrollDirection: Axis.horizontal,
      //   children: [
      //     const CashierProductsView(),
      //     Container(
      //       color: Colors.red,
      //     )
      //   ],
      // ),
      drawer: SafeArea(
        top: false,
        bottom: false,
        child: Drawer(
          width: config.sw(250),
          backgroundColor: ColorPalette.primary,
          child: const CashierDrawerView(),
        ),
      ),
      // bottomNavigationBar: ClipRRect(
      //   borderRadius: const BorderRadius.only(
      //     topLeft: Radius.circular(24),
      //     topRight: Radius.circular(24)
      //   ),
      //   child: BottomAppBar(
      //     child: SizedBox(
      //       height: config.sh(50),
      //       width: double.infinity,
      //       child: Center(
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //             BottomNavItem(
      //               icon: "cashier_products",
      //               label: "Products",
      //               isSelected: currentIdx == 0,
      //               onTap: () => onPageChanged(0),
      //             ),
      //             BottomNavItem(
      //               icon: "cashier_favorites",
      //               label: "Favorites",
      //               isSelected: currentIdx == 1,
      //               onTap: () => onPageChanged(1),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // )
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