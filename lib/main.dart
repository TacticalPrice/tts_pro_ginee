import 'package:flutter/material.dart';
import 'package:tts_pro/ride_details_list.dart';
import 'package:tts_pro/screens/ride_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    List<RideDetails> rideDetailsList =
        RideDetailsProvider.getRideDetailsList();
    return MaterialApp(
      title: 'Flutter Demo',
      home: RideDetailsScreen(
        rideDetailsList: rideDetailsList,
      ),
    );
  }
}
