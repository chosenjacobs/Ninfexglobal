import 'package:flutter/material.dart';

class SaleAccounts extends StatefulWidget {
  @override
  _SaleAccountsState createState() => _SaleAccountsState();
}

class _SaleAccountsState extends State<SaleAccounts> {
  // Sample data for social media accounts
  final List<Map<String, dynamic>> socialMediaAccounts = [
    {
      'name': 'Instagram Account - @example1',
      'platform': 'Instagram',
      'followers': 1000,
      'niche': 'Fashion',
      'likes': 150,
      'following': 200,
      'age': '2 years',
      'price': 100,
      'photo': 'https://via.placeholder.com/150', // Dummy photo
    },
    {
      'name': 'TikTok Account - @example2',
      'platform': 'TikTok',
      'followers': 500,
      'niche': 'Comedy',
      'likes': 300,
      'following': 150,
      'age': '1 year',
      'price': 80,
      'photo': 'https://via.placeholder.com/150', // Dummy photo
    },
    // ... add more accounts with similar structure
  ];

  String searchQuery = '';
  String selectedPlatform = 'All'; // Default platform filter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Media Accounts for Sale'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search accounts by name',
                ),
              ),
              DropdownButton<String>(
                value: selectedPlatform,
                items: <String>['All', 'Instagram', 'TikTok', 'Twitter', 'Facebook']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPlatform = newValue!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: socialMediaAccounts.length,
        itemBuilder: (context, index) {
          final account = socialMediaAccounts[index];
          if ((selectedPlatform == 'All' || account['platform'] == selectedPlatform) &&
              (searchQuery.isEmpty || account['name'].toLowerCase().contains(searchQuery.toLowerCase()))) {
            return Card( // Added Card for better UI
              margin: EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.network(account['photo'], width: 50, height: 50), // Display account photo
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(account['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                              Text('${account['platform']} - ${account['followers']} followers'),
                              Text('Niche: ${account['niche']}'),
                              Text('Likes: ${account['likes']}'),
                              Text('Following: ${account['following']}'),
                              Text('Age: ${account['age']}'),
                              Text('Price: \$${account['price']}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Add your buy now action here
                      },
                      child: Text('Buy Now'),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container(); // Return empty container if not displayed
        },
      ),
    );
  }
}
