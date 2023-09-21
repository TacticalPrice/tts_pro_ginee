import 'package:tts_pro/screens/ride_details_screen.dart';

class RideDetailsProvider {
  static List<RideDetails> getRideDetailsList() {
    return [
      RideDetails(
        pickupLocation: "123 Main St",
        dropLocation: "456 Elm St",
        fareAmount: 25.0,
        paymentMethod: "Credit Card",
        customerName: "John Doe",
      ),
      RideDetails(
        pickupLocation: "789 Oak St",
        dropLocation: "101 Pine St",
        fareAmount: 30.5,
        paymentMethod: "Cash",
        customerName: "Jane Smith",
      ),
      RideDetails(
        pickupLocation: "222 Maple St",
        dropLocation: "333 Cedar St",
        fareAmount: 15.75,
        paymentMethod: "PayPal",
        customerName: "Alice Johnson",
      ),
      RideDetails(
        pickupLocation: "555 Willow St",
        dropLocation: "777 Birch St",
        fareAmount: 18.25,
        paymentMethod: "Credit Card",
        customerName: "Bob Anderson",
      ),
      RideDetails(
        pickupLocation: "999 Elm St",
        dropLocation: "123 Oak St",
        fareAmount: 22.0,
        paymentMethod: "Cash",
        customerName: "Eve Wilson",
      ),
    ];
  }
}
