import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:tts_pro/screens/home_screen.dart';

class RideDetailsScreen extends StatefulWidget {
  final List<RideDetails> rideDetailsList;

  const RideDetailsScreen({super.key, required this.rideDetailsList});
  @override
  _RideDetailsScreenState createState() => _RideDetailsScreenState();
}

class _RideDetailsScreenState extends State<RideDetailsScreen> {
  FlutterTts flutterTts = FlutterTts();
  int currentIndex = 0;
  String errorMessage = "";
  bool confirmationReceived = false;

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
        "Pickup Location: ${widget.rideDetailsList[currentIndex].pickupLocation}. "
        "Drop Location: ${widget.rideDetailsList[currentIndex].dropLocation}. "
        "Fare Amount: \$${widget.rideDetailsList[currentIndex].fareAmount}. "
        "Payment Method: ${widget.rideDetailsList[currentIndex].paymentMethod}. "
        "Customer Name: ${widget.rideDetailsList[currentIndex].customerName}.",
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

  void _navigateToNextRide() {
    if (currentIndex < widget.rideDetailsList.length - 1) {
      setState(() {
        currentIndex++;
        _stopSpeaking();
        _speakRideDetails();
        confirmationReceived = false;
      });
    } else {
      // Handle when there are no more rides
      // You can display a message or navigate back to a different screen.
    }
  }

  // Function to handle navigation to the previous ride
  void _navigateToPreviousRide() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        _stopSpeaking();
        _speakRideDetails();
        confirmationReceived = false;
      });
    } else {
      // Handle when there are no previous rides
      // You can display a message or navigate back to a different screen.
    }
  }

  void _confirmAndProceed() {
    setState(() {
      confirmationReceived = true;
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
    // Navigate to the next screen (e.g., HomeScreen) when confirmation is received
    // You can implement the navigation logic here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride Details'),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ride Details',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: const TextStyle(
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
                      _buildInfoRow("Pickup Location:",
                          widget.rideDetailsList[currentIndex].pickupLocation),
                      _buildInfoRow("Drop Location:",
                          widget.rideDetailsList[currentIndex].dropLocation),
                      _buildInfoRow("Fare Amount:",
                          "\$${widget.rideDetailsList[currentIndex].fareAmount}"),
                      _buildInfoRow("Payment Method:",
                          widget.rideDetailsList[currentIndex].paymentMethod),
                      _buildInfoRow("Customer Name:",
                          widget.rideDetailsList[currentIndex].customerName),
                    ].map((widget) => Expanded(child: widget)).toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrangeAccent, // Background color
                    onPrimary: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Adjust the radius as needed
                    ),
                  ),
                  onPressed: _navigateToPreviousRide,
                  child: const Text('Previous Ride'),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrangeAccent, // Background color
                    onPrimary: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Adjust the radius as needed
                    ),
                  ),
                  onPressed: _navigateToNextRide,
                  child: const Text('Next Ride'),
                ),
              ],
            ),
            const SizedBox(
                height: 16.0), // Added space for the confirmation button
            if (!confirmationReceived)
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrangeAccent, // Background color
                    onPrimary: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Adjust the radius as needed
                    ),
                  ),
                  onPressed: _confirmAndProceed,
                  child: const Text('Confirm and Proceed'),
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
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class RideDetails {
  final String pickupLocation;
  final String dropLocation;
  final double fareAmount;
  final String paymentMethod;
  final String customerName;

  RideDetails({
    required this.pickupLocation,
    required this.dropLocation,
    required this.fareAmount,
    required this.paymentMethod,
    required this.customerName,
  });
}
