import 'package:flutter/foundation.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothStore extends ChangeNotifier{
  bool _isScanning = false;
  FlutterBlue _flutterBlue;
  List<ScanResult> _scanResultList = [];

  BluetoothStore(){
    _flutterBlue = FlutterBlue.instance;
    _flutterBlue.scanResults.listen((results) {
      setScanResultList(results);
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
      }
    });
  }

  void startScan(bool flag){
    if(flag == true){
      _flutterBlue.startScan();
      setIsScanning(true);
    }else{
      _flutterBlue.stopScan();
      setIsScanning(false);
    }
  }

  void _connectDevice(BluetoothDevice device, bool flag) async {
    if(flag == true){
      await device.connect();
    }else{
      device.disconnect();
    }
  }

  // void startAdvertising(){
  //   _flutterBlue.
  // }

  void clearStore(){
    _isScanning = false;
    _scanResultList = [];
  }


  //setter
  void setIsScanning(bool isScan){
    _isScanning = isScan;
    notifyListeners();
  }
  void setScanResultList(List<ScanResult> list){
    _scanResultList = list;
    notifyListeners();
  }

  //getter
  bool getScanningState(){
    return _isScanning;
  }
  List<ScanResult> getScanResultList(){
    return _scanResultList;
  }
}