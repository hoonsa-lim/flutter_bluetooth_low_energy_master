import 'package:bluetooth_finder/Store/ColorStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';

class CentralListItem extends StatefulWidget {
  int index;
  ScanResult scanResult;
  CentralListItem(
      this.index,
      this.scanResult,);

  @override
  _CentralListItemState createState() => _CentralListItemState();
}

class _CentralListItemState extends State<CentralListItem> {
  bool isFullContent = false;

  @override
  Widget build(BuildContext context) {
    int i = widget.index;
    ScanResult sr = widget.scanResult;
    Size windowSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: (){
        setState(() {
          isFullContent = !isFullContent;
        });
          print(isFullContent);
        },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(windowSize.width * 0.015),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(children: [
                Container(
                  width: windowSize.width * 0.07,
                  child: Column(
                      children: [
                        Text("${i+1}"),
                      ]
                  ),
                ),
                Container(
                  width: windowSize.width * 0.65,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(windowSize.width * 0.02, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${sr.device.name==""?"[이름 없음]":sr.device.name}",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),),
                        SizedBox(height: windowSize.height * 0.01,),
                        Text("Id             : ${sr.device.id.id}",
                          style: TextStyle(color: Color(ColorStore.primaryColor)),),
                        Text("Rssi         : ${sr.rssi}",
                          style: TextStyle(color: Color(ColorStore.primaryColor),)),
                        Text("Type        : ${getDeviceType(sr.device.type.index)}",
                          style: TextStyle(color: Color(ColorStore.primaryColor)),),
                        Text("TxPower : ${sr.advertisementData.txPowerLevel}",
                          style: TextStyle(color: Color(ColorStore.primaryColor)),),
                        isFullContent? getFullContent(sr, i, windowSize) : Container()
                      ],),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Column(children: [
                    RaisedButton(
                        color: sr.advertisementData.connectable?Color(ColorStore.accentColor):Color(ColorStore.primaryColor),
                        textColor: Colors.white,
                        child: Text(sr.advertisementData.connectable?"연결 가능":"연결 불가"),
                        onPressed: (){

                        }),
                  ],),
                ),
              ],),
            ],
          ),
        ),
      ),
    );
  }

  Column getFullContent(ScanResult sr, int index, Size ws){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: ws.height * 0.01,),
        Text("serviceUUID : ${sr.advertisementData.serviceUuids}",
          style: TextStyle(color: Color(ColorStore.primaryColor)),),
        Text("serviceData  : ${sr.advertisementData.serviceData}",
          style: TextStyle(color: Color(ColorStore.primaryColor)),),
      ],
    );
  }

  String getDeviceType(int i) {
    String returnValue = "";
    switch(i){
      case 0: returnValue = "unknown";break;
      case 1: returnValue = "classic";break;
      case 2: returnValue = "low energy";break;
      case 3: returnValue = "classic/low energy";break;
    }
    return returnValue;
  }
}
