import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:project/screens/userhome/userHomeUI.dart';


void main() async {
  testGoldens('User Home Screen',
      (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
       
        Device.phone,
        Device.iphone11,
      
      ])
      ..addScenario(
        widget: UserHomeUI(),
        name: 'sc page',
      );

    await tester.pumpDeviceBuilder(
      builder,
      wrapper: materialAppWrapper(
        theme: ThemeData.light(),
        platform: TargetPlatform.android,
      ),
    );

    await screenMatchesGolden(tester, 'UserHome_Screen');
   
  });
}