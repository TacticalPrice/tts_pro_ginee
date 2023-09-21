import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:tts_pro/screens/home_screen.dart';

class RideDetailsScreen extends StatefulWidget {
  @override
  _RideDetailsScreenState createState() => _RideDetailsScreenState();
}

class _RideDetailsScreenState extends State<RideDetailsScreen> {
  FlutterTts flutterTts = FlutterTts();
  String pickupLocation = "123 Main St";
  String dropLocation = "456 Elm St";
  double fareAmount = 25.0;
  String paymentMethod = "Credit Card";
  String customerName = "John Doe";
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    _speakRideDetails();
  }

  Future<void> _speakRideDetails() async {
    try {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(
        "Pickup Location: $pickupLocation. "
        "Drop Location: $dropLocation. "
        "Fare Amount: \$$fareAmount. "
        "Payment Method: $paymentMethod. "
        "Customer Name: $customerName.",
      );
    } catch (e) {
      setState(() {
        errorMessage = "Error: Text-to-speech failed. Please check your device settings.";
      });
    }
  }

  Future<void> _stopSpeaking() async {
    await flutterTts.stop();
  }

  @override
  void dispose() {
    flutterTts.stop();
    flutterTts.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming Ride Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ride Details',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: TextStyle(
                  color: Colors.red,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ListTile(
              title: Text(
                "Pickup Location:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(pickupLocation),
            ),
            // ... (other ListTile widgets for ride details)
            SizedBox(height: 24.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _stopSpeaking();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
                child: Text('Confirm and Proceed'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
