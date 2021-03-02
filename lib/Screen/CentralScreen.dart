import 'package:bluetooth_finder/Component/CentralListItem.dart';
import 'package:bluetooth_finder/Store/BluetoothStore.dart';
import 'package:bluetooth_finder/Store/ColorStore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_blue/flutter_blue.dart';


class CentralScreen extends StatefulWidget {
  @override
  _CentralScreenState createState() => _CentralScreenState();
}

class _CentralScreenState extends State<CentralScreen> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);


  @override
  void initState() {
    super.initState();
  }

  void _onRefresh(BluetoothStore store) async{
    store.startScan(false);
    await Future.delayed(Duration(milliseconds: 1000));
    store.setScanResultList([]);
    store.startScan(true);
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    var bluetoothStore = Provider.of<BluetoothStore>(context, listen: true);
    Size windowSize = MediaQuery.of(context).size;

    return SmartRefresher(
      enablePullDown: true,
      header: WaterDropHeader(),
      controller: _refreshController,
      onRefresh: (){_onRefresh(bluetoothStore);},
      child: ListView.builder(
        itemBuilder: (c, i) =>
            i==0?
              Column(children: [
                bluetoothStore.getScanningState()?LinearProgressIndicator():Container(),
                Container(
                  height: windowSize.height * 0.06,
                  color: Color(ColorStore.primaryColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Text("Count : ${bluetoothStore.getScanResultList().length}",
                          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),),
                    ],
                  ),
                ),
              ],)
            :
              CentralListItem(i-1,bluetoothStore.getScanResultList()[i-1]),//Refresh api 속에서 progressbar 사용 위해서
        // itemExtent: 100.0,
        itemCount: bluetoothStore.getScanResultList().length + 1,//Refresh api 속에서 progressbar 사용 위해서
      ),
    );
  }
}
