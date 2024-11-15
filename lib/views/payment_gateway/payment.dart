import 'package:flutter/material.dart';
import 'package:gyanavi_academy/models/payment/purchase_model.dart';
import '../../repository/purchase/purchase_repository.dart'; // Your repository import

class PaymentScreen extends StatelessWidget {
  final PurchaseRepository purchaseRepository = PurchaseRepository();
  final String userId;   // Passed user ID from SharedPreferences
  final int courseId;    // Passed course ID from CourseDetailsScreen
  final double coursePrice;  // Passed course price from CourseDetailsScreen

  PaymentScreen({
    required this.userId,
    required this.courseId,
    required this.coursePrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Information
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/JPEG-1221.jpg'), // Replace with your image
                  radius: 24,
                ),
                title: Text(
                  'Course Title', // Dynamically use the course title
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Instructor Name'), // Replace with the instructor name
              ),
            ),
            SizedBox(height: 20),

            // Card Information
            Text(
              'Card Information',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            // Add the input fields for payment details here
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Card Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            // Other fields...

            SizedBox(height: 20),
            // Pay Now Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    // Call the createPurchase method with userId, courseId, and coursePrice
                    await purchaseRepository.createPurchase(userId as Purchase, courseId, coursePrice);

                    // Navigate to My Courses screen
                    Navigator.of(context).pushReplacementNamed('/myCourses');
                  } catch (e) {
                    // Handle error
                    print('Purchase failed: $e');
                  }
                },
                child: Text('Pay Now'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
