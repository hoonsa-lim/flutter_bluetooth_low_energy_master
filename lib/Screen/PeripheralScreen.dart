import 'package:flutter/material.dart';

class PeripheralScreen extends StatefulWidget {
  @override
  _PeripheralScreenState createState() => _PeripheralScreenState();
}

class _PeripheralScreenState extends State<PeripheralScreen> {
  bool _lights = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          title: const Text('Lights'),
          value: _lights,
          onChanged: (bool value) {
            setState(() {
              _lights = value;
            });
          },
          secondary: const Icon(Icons.lightbulb_outline),
        ),
        SwitchListTile(
          title: const Text('Lights'),
          value: _lights,
          onChanged: (bool value) {
            setState(() {
              _lights = value;
            });
          },
          secondary: const Icon(Icons.lightbulb_outline),
        ),
        SwitchListTile(
          title: const Text('Lights'),
          value: _lights,
          onChanged: (bool value) {
            setState(() {
              _lights = value;
            });
          },
          secondary: const Icon(Icons.lightbulb_outline),
        ),
        SwitchListTile(
          title: const Text('Lights'),
          value: _lights,
          onChanged: (bool value) {
            setState(() {
              _lights = value;
            });
          },
          secondary: const Icon(Icons.lightbulb_outline),
        ),
      ]
    );
  }
}
