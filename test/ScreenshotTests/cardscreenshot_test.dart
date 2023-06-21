import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:project/screens/card/cardUI.dart';


void main() async {
  testGoldens('Card Screen',
      (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
       
        Device.phone,
        Device.iphone11,
        Device.tabletPortrait,
        Device.tabletLandscape,
      ])
      ..addScenario(
        widget: MyCards(),
        name: 'sc page',
      );

    await tester.pumpDeviceBuilder(
      builder,
      wrapper: materialAppWrapper(
        theme: ThemeData.light(),
        platform: TargetPlatform.android,
      ),
    );

    await screenMatchesGolden(tester, 'Card_Screen');
   
  });
}