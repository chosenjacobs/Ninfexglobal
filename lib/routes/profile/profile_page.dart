import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'User Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildProfileOption('Total Orders', '10'), // Example data
            _buildProfileOption('Deposit Option', 'Available'),
            _buildProfileOption('Advertise with Us', 'Click here to learn more'),
            _buildProfileOption('Bought Accounts', '5'), // Example data
            _buildProfileOption('Sold Accounts', '3'), // Example data
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18)),
          Text(value, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
} 