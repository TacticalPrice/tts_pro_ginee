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
        errorMessage =
            "Error: Text-to-speech failed. Please check your device settings.";
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
        title: Text('Ride Details'),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
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
            Container(
              width: MediaQuery.of(context).size.width * 0.93, // 80% width
              height: MediaQuery.of(context).size.height * 0.6, // 80% height
              child: Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow("Pickup Location:", pickupLocation),
                      _buildInfoRow("Drop Location:", dropLocation),
                      _buildInfoRow("Fare Amount:", "\$$fareAmount"),
                      _buildInfoRow("Payment Method:", paymentMethod),
                      _buildInfoRow("Customer Name:", customerName),
                    ].map((widget) => Expanded(child: widget)).toList(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.0),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrangeAccent, // Background color
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8.0), // Adjust the radius as needed
                  ), // Text color
                ),
                onPressed: () {
                  _stopSpeaking();
                  Navigator.of(context).push(
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

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
