import 'package:biz_track/shared/utils/dimensions.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class ReportView extends ConsumerStatefulWidget {
  const ReportView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReportViewState();
}

class _ReportViewState extends ConsumerState<ReportView> {

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    
    return const Scaffold(
      appBar: CustomAppBar(
        title: "Report",
      )
    );
  }
}