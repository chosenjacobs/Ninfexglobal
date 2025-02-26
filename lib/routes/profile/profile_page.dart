import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture and Account Balance
            _buildProfileHeader(),
            const SizedBox(height: 20),
            const Text(
              'User Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildProfileCard(
              title: 'Deposit Money',
              value: 'Add funds to your account using mobile money',
              icon: Icons.account_balance_wallet,
              onTap: () {
                // Navigate to deposit money page
                _navigateToDepositPage(context);
              },
            ),
            const SizedBox(height: 16),
            _buildProfileCard(
              title: 'Advertise with Us',
              value: 'Promote your business on our platform',
              icon: Icons.ad_units,
              onTap: () {
                // Navigate to advertise page
                _navigateToAdvertisePage(context);
              },
            ),
            const SizedBox(height: 16),
            _buildProfileCard(
              title: 'Sell Social Media Accounts',
              value: 'Sell your social media accounts securely',
              icon: Icons.sell,
              onTap: () {
                // Navigate to sell accounts page
                _navigateToSellAccountsPage(context);
              },
            ),
            const SizedBox(height: 16),
            _buildProfileCard(
              title: 'Bought Accounts',
              value: '5', // Example data
              icon: Icons.shopping_cart,
              onTap: () {
                // Navigate to bought accounts page
                _navigateToBoughtAccountsPage(context);
              },
            ),
            const SizedBox(height: 16),
            _buildProfileCard(
              title: 'Sold Accounts',
              value: '3', // Example data
              icon: Icons.attach_money,
              onTap: () {
                // Navigate to sold accounts page
                _navigateToSoldAccountsPage(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // Profile Picture
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(
                'assets/profile_picture.png'), // Add your image asset
          ),
          const SizedBox(width: 16),
          // Account Balance
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'John Doe', // Replace with user's name
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Account Balance: \$500', // Replace with dynamic balance
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard({
    required String title,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Colors.blueAccent),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDepositPage(BuildContext context) {
    // Navigate to deposit money page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DepositPage()),
    );
  }

  void _navigateToAdvertisePage(BuildContext context) {
    // Navigate to advertise page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdvertisePage()),
    );
  }

  void _navigateToSellAccountsPage(BuildContext context) {
    // Navigate to sell accounts page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SellAccountsPage()),
    );
  }

  void _navigateToBoughtAccountsPage(BuildContext context) {
    // Navigate to bought accounts page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BoughtAccountsPage()),
    );
  }

  void _navigateToSoldAccountsPage(BuildContext context) {
    // Navigate to sold accounts page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SoldAccountsPage()),
    );
  }
}

// Placeholder pages for navigation
class DepositPage extends StatelessWidget {
  const DepositPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deposit Money'),
      ),
      body: const Center(
        child: Text('Deposit Money Page'),
      ),
    );
  }
}

class AdvertisePage extends StatelessWidget {
  const AdvertisePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advertise with Us'),
      ),
      body: const Center(
        child: Text('Advertise Page'),
      ),
    );
  }
}

class SellAccountsPage extends StatelessWidget {
  const SellAccountsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell Social Media Accounts'),
      ),
      body: const Center(
        child: Text('Sell Accounts Page'),
      ),
    );
  }
}

class BoughtAccountsPage extends StatelessWidget {
  const BoughtAccountsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bought Accounts'),
      ),
      body: const Center(
        child: Text('Bought Accounts Page'),
      ),
    );
  }
}

class SoldAccountsPage extends StatelessWidget {
  const SoldAccountsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sold Accounts'),
      ),
      body: const Center(
        child: Text('Sold Accounts Page'),
      ),
    );
  }
}
