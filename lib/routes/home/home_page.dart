import 'package:flutter/material.dart';
import '../profile/profile_page.dart'; // Ensure this file exists

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              print('Profile icon clicked!'); // Debugging line
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Profile'),
                    content: const Text('This is your profile!'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Center(
        child: const Text('Welcome to the Home Page!'),
      ),
    );
  }
} 