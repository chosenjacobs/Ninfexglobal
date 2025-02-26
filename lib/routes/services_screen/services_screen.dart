import 'package:flutter/material.dart';

class SaleAccounts extends StatefulWidget {
  const SaleAccounts({Key? key}) : super(key: key);

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
      'photo': 'https://via.placeholder.com/150',
      'description':
          'Fashion-focused Instagram account with high engagement rate and authentic followers.'
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
      'photo': 'https://via.placeholder.com/150',
      'description':
          'Growing comedy TikTok with viral potential and active audience.'
    },
    {
      'name': 'Twitter Account - @example3',
      'platform': 'Twitter',
      'followers': 2500,
      'niche': 'Tech',
      'likes': 450,
      'following': 350,
      'age': '3 years',
      'price': 150,
      'photo': 'https://via.placeholder.com/150',
      'description':
          'Tech-focused Twitter with industry connections and regular engagement.'
    },
    {
      'name': 'Facebook Page - Tech Enthusiasts',
      'platform': 'Facebook',
      'followers': 3500,
      'niche': 'Technology',
      'likes': 2800,
      'following': 0,
      'age': '4 years',
      'price': 200,
      'photo': 'https://via.placeholder.com/150',
      'description':
          'Established Facebook page with dedicated tech community and monetization options.'
    },
    {
      'name': 'Instagram Account - @travelbug',
      'platform': 'Instagram',
      'followers': 5000,
      'niche': 'Travel',
      'likes': 600,
      'following': 450,
      'age': '2.5 years',
      'price': 250,
      'photo': 'https://via.placeholder.com/150',
      'description':
          'Travel-focused Instagram with partnerships and high-quality content library.'
    },
  ];

  String searchQuery = '';
  String selectedPlatform = 'All';
  String selectedSort = 'Default';
  RangeValues _priceRange = const RangeValues(0, 300);
  RangeValues _followersRange = const RangeValues(0, 5000);
  bool _showFilters = false;

  List<Map<String, dynamic>> get filteredAccounts {
    return socialMediaAccounts.where((account) {
      final matchesPlatform =
          selectedPlatform == 'All' || account['platform'] == selectedPlatform;
      final matchesSearch = searchQuery.isEmpty ||
          account['name'].toLowerCase().contains(searchQuery.toLowerCase()) ||
          account['niche'].toLowerCase().contains(searchQuery.toLowerCase());
      final matchesPrice = account['price'] >= _priceRange.start &&
          account['price'] <= _priceRange.end;
      final matchesFollowers = account['followers'] >= _followersRange.start &&
          account['followers'] <= _followersRange.end;

      return matchesPlatform &&
          matchesSearch &&
          matchesPrice &&
          matchesFollowers;
    }).toList()
      ..sort((a, b) {
        switch (selectedSort) {
          case 'Price (Low to High)':
            return a['price'].compareTo(b['price']);
          case 'Price (High to Low)':
            return b['price'].compareTo(a['price']);
          case 'Followers (Low to High)':
            return a['followers'].compareTo(b['followers']);
          case 'Followers (High to Low)':
            return b['followers'].compareTo(a['followers']);
          default:
            return 0;
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Media Accounts'),
        backgroundColor: Colors.indigo,
        elevation: 0,
        actions: [
          IconButton(
            icon:
                Icon(_showFilters ? Icons.filter_list_off : Icons.filter_list),
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.indigo.shade50,
            child: Column(
              children: [
                // Search bar
                TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search by name, niche...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),

                if (_showFilters) ...[
                  const SizedBox(height: 16),
                  // Platform filter
                  Row(
                    children: [
                      const Text('Platform: ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <String>[
                              'All',
                              'Instagram',
                              'TikTok',
                              'Twitter',
                              'Facebook'
                            ]
                                .map((platform) => Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: ChoiceChip(
                                        label: Text(platform),
                                        selected: selectedPlatform == platform,
                                        onSelected: (selected) {
                                          if (selected) {
                                            setState(() {
                                              selectedPlatform = platform;
                                            });
                                          }
                                        },
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  // Sort options
                  Row(
                    children: [
                      const Text('Sort by: ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedSort,
                          items: <String>[
                            'Default',
                            'Price (Low to High)',
                            'Price (High to Low)',
                            'Followers (Low to High)',
                            'Followers (High to Low)'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedSort = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  // Price range slider
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('Price Range: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(
                              '\$${_priceRange.start.toInt()} - \$${_priceRange.end.toInt()}'),
                        ],
                      ),
                      RangeSlider(
                        values: _priceRange,
                        min: 0,
                        max: 300,
                        divisions: 30,
                        labels: RangeLabels('\$${_priceRange.start.toInt()}',
                            '\$${_priceRange.end.toInt()}'),
                        onChanged: (RangeValues values) {
                          setState(() {
                            _priceRange = values;
                          });
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                  // Followers range slider
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('Followers: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(
                              '${_followersRange.start.toInt()} - ${_followersRange.end.toInt()}'),
                        ],
                      ),
                      RangeSlider(
                        values: _followersRange,
                        min: 0,
                        max: 5000,
                        divisions: 50,
                        labels: RangeLabels('${_followersRange.start.toInt()}',
                            '${_followersRange.end.toInt()}'),
                        onChanged: (RangeValues values) {
                          setState(() {
                            _followersRange = values;
                          });
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  // Apply filter button
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _showFilters = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Apply Filters'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            searchQuery = '';
                            selectedPlatform = 'All';
                            selectedSort = 'Default';
                            _priceRange = const RangeValues(0, 300);
                            _followersRange = const RangeValues(0, 5000);
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Reset'),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          // Results counter
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Showing ${filteredAccounts.length} accounts',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // Account listings
          Expanded(
            child: filteredAccounts.isEmpty
                ? const Center(
                    child: Text('No accounts match your filters',
                        style: TextStyle(fontSize: 16, color: Colors.grey)))
                : ListView.builder(
                    itemCount: filteredAccounts.length,
                    itemBuilder: (context, index) {
                      final account = filteredAccounts[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () {
                            // Navigate to account details
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                              builder: (context) =>
                                  _buildAccountDetailsSheet(account),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        account['photo'],
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            account['name'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              _buildPlatformIcon(
                                                  account['platform']),
                                              const SizedBox(width: 4),
                                              Text(account['platform']),
                                              const SizedBox(width: 12),
                                              const Icon(Icons.people,
                                                  size: 16, color: Colors.grey),
                                              const SizedBox(width: 4),
                                              Text('${account['followers']}'),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Niche: ${account['niche']}',
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '\$${account['price']}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.indigo,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Processing purchase for ${account['name']}...'),
                                            duration:
                                                const Duration(seconds: 2),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.indigo,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      child: const Text('Buy Now'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.help_outline),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('About This Marketplace'),
              content: const SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        'This marketplace connects buyers and sellers of established social media accounts.'),
                    SizedBox(height: 8),
                    Text('• All accounts have been verified'),
                    Text('• Secure transfer process'),
                    Text('• 30-day support after purchase'),
                    SizedBox(height: 8),
                    Text('For any questions, contact support@example.com'),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlatformIcon(String platform) {
    IconData iconData;
    Color color;

    switch (platform) {
      case 'Instagram':
        iconData = Icons.camera_alt;
        color = Colors.pink;
        break;
      case 'TikTok':
        iconData = Icons.music_note;
        color = Colors.black;
        break;
      case 'Twitter':
        iconData = Icons.chat;
        color = Colors.blue;
        break;
      case 'Facebook':
        iconData = Icons.facebook;
        color = Colors.indigo;
        break;
      default:
        iconData = Icons.public;
        color = Colors.grey;
    }

    return Icon(iconData, size: 16, color: color);
  }

  Widget _buildAccountDetailsSheet(Map<String, dynamic> account) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        account['photo'],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            account['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              _buildPlatformIcon(account['platform']),
                              const SizedBox(width: 8),
                              Text(
                                account['platform'],
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Account age: ${account['age']}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Account Statistics',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                _buildStatCard(account),
                const SizedBox(height: 24),
                const Text(
                  'Description',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  account['description'],
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Price',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${account['price']}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.favorite_border),
                        label: const Text('Save'),
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Account saved to favorites')),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: const BorderSide(color: Colors.indigo),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.shopping_cart),
                        label: const Text('Buy Now'),
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Proceeding to checkout...')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                const Text(
                  'Important Information',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '• Account will be transferred within 24 hours of purchase\n'
                  '• Includes 30 days of post-purchase support\n'
                  '• All sales are final after successful transfer',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatCard(Map<String, dynamic> account) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
              Icons.people, 'Followers', account['followers'].toString()),
          _buildStatItem(Icons.favorite, 'Likes', account['likes'].toString()),
          _buildStatItem(
              Icons.person_add, 'Following', account['following'].toString()),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.indigo),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
