import 'package:bluetooth_finder/Screen/CentralScreen.dart';
import 'package:bluetooth_finder/Screen/PeripheralScreen.dart';
import 'package:bluetooth_finder/Store/ColorStore.dart';
import 'package:bluetooth_finder/Store/BluetoothStore.dart';
import 'package:bluetooth_finder/Store/StringStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _screenSelectedIndex = 0;
  static List<Widget> _WidgetOptions = <Widget>[
    CentralScreen(),
    PeripheralScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _screenSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("MainScreen build");
    var bluetoothStore = Provider.of<BluetoothStore>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(StringStore.AppName),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: const Color(ColorStore.primaryColor),
              ),
            ),
            ListTile(
              title: Text('설문 추가'),
              onTap: () {
                Navigator.pop(context);
                // Navigator.pushNamed(context, "/RegisterSurveyScreen");
              },
            ),
            ListTile(
              title: Text('Item'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: _WidgetOptions.elementAt(_screenSelectedIndex),
      ),
      floatingActionButton: getFloatingButton(_screenSelectedIndex, bluetoothStore),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(ColorStore.primaryColor),
          textTheme: Theme.of(context).textTheme.copyWith(caption: TextStyle(color: Colors.white))
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              label: '기기 검색',
              backgroundColor: const Color(ColorStore.primaryColor),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bluetooth_searching_sharp),
              label: '신호 송신',
              backgroundColor: const Color(ColorStore.primaryColor),
            ),
          ],
          currentIndex: _screenSelectedIndex,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  FloatingActionButton getFloatingButton(int index, BluetoothStore store) {
    return FloatingActionButton(
      onPressed: () {
        if(index == 0){//기기검색 화면
          if(store.getScanningState() == true){
            store.startScan(false);
          }else{
            store.startScan(true);
          }
        }else{//신호 송신 화면

        }
      },
      child: getFloatingButtonIcon(index, index==0?store.getScanningState():false),
      backgroundColor: Color(ColorStore.accentColor),
    );
  }

  Icon getFloatingButtonIcon(int index, bool flag){
    if(index == 0){
      return Icon(flag?Icons.search_off:Icons.search);
    }else{
      return Icon(flag?Icons.search_off:Icons.bluetooth_searching_outlined);
    }
  }
}
