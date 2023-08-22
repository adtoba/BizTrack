import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';

class PrinterViewModel extends ChangeNotifier {

  final BluetoothPrint _bluetoothPrint = BluetoothPrint.instance;
  BluetoothDevice? _device;

  BluetoothPrint get bluetoothPrint => _bluetoothPrint;
  BluetoothDevice? get device => _device;

  bool _isConnected = false;
  bool get isConnected => _isConnected;

  listenForPrinterState() {
    _bluetoothPrint.state.listen((state) {
      switch(state) {
        case BluetoothPrint.CONNECTED:
            _isConnected = true;
            print("IS CONNECTED: $_isConnected");
            notifyListeners();
          break;
        case BluetoothPrint.DISCONNECTED:
            _isConnected = false;
            print("IS CONNECTED: $_isConnected");
            notifyListeners();
          break;
        default:
        break;
      }
    });
  }

  void disconnectPrinter() async {
    await _bluetoothPrint.disconnect();
    notifyListeners();
  }

  initDevice(BluetoothDevice d) {
    _device = d;
    listenForPrinterState();
    notifyListeners();
  }

  connectDevice(BluetoothDevice device) async {
    await _bluetoothPrint.connect(device);
    notifyListeners();
  }

  void printReceipt() async {
    Map<String, dynamic> config = {};
    List<LineText> list = [];
    list.add(LineText(type: LineText.TYPE_TEXT, content: 'A Title', weight: 1, align: LineText.ALIGN_CENTER,linefeed: 1));
    list.add(LineText(type: LineText.TYPE_TEXT, content: 'this is conent left', weight: 0, align: LineText.ALIGN_LEFT,linefeed: 1));
    list.add(LineText(type: LineText.TYPE_TEXT, content: 'this is conent right', align: LineText.ALIGN_RIGHT,linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(type: LineText.TYPE_BARCODE, content: 'A12312112', size:10, align: LineText.ALIGN_CENTER, linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(type: LineText.TYPE_QRCODE, content: 'qrcode i', size:10, align: LineText.ALIGN_CENTER, linefeed: 1));
    list.add(LineText(linefeed: 1));

    await bluetoothPrint.printReceipt(config, list);
  }

}