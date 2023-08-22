
import 'package:biz_track/shared/registry/provider_registry.dart';
import 'package:biz_track/shared/style/color_palette.dart';
import 'package:biz_track/shared/views/custom_app_bar.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrinterBluetoothView extends ConsumerStatefulWidget {
  const PrinterBluetoothView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PrinterBluetoothViewState();
}

class _PrinterBluetoothViewState extends ConsumerState<PrinterBluetoothView> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(printerViewModel).bluetoothPrint.startScan(timeout: const Duration(seconds: 5));
    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var printerProvider = ref.watch(printerViewModel);

    return Scaffold(
      backgroundColor: ColorPalette.scaffoldBg,
      appBar: const CustomAppBar(
        title: "Printers",
      ),
      body: StreamBuilder<List<BluetoothDevice>>(
        stream: printerProvider.bluetoothPrint.scanResults,
        initialData: const [],
        builder: (context, snapshot) {
          return Column(
            children: snapshot.data!.map((d) => ListTile(
              title: Text(d.name ?? ''),
              subtitle: Text(d.address ?? ''),
              onTap: () async {
                printerProvider.initDevice(d);
                await printerProvider.connectDevice(d);
              },
              trailing: printerProvider.device !=null && printerProvider.device!.address == d.address ? const Icon(
                Icons.check,
                color: Colors.green,
              ) : null
            )).toList(),
          );
        },
      )
    );
  }
}