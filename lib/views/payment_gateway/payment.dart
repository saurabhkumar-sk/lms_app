import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Razorpay Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Course Payment',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Total: ₹500',
              style: TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Simulating the payment process
                _showPaymentResultDialog(context, 'success');
              },
              child: Text('Pay Now'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Simulating the payment failure
                _showPaymentResultDialog(context, 'failure');
              },
              child: Text('Simulate Failure'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Simulating the payment cancellation
                _showPaymentResultDialog(context, 'cancel');
              },
              child: Text('Simulate Cancel'),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentResultDialog(BuildContext context, String result) {
    String message;
    switch (result) {
      case 'success':
        message = 'Payment Success!';
        break;
      case 'failure':
        message = 'Payment Failed!';
        break;
      case 'cancel':
        message = 'Payment Cancelled!';
        break;
      default:
        message = 'Unknown status';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment $result'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                // Simulate going back to the courses screen after payment
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
