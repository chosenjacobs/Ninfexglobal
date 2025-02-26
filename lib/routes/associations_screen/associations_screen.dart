import 'package:flutter/material.dart';
import 'package:nexglobal/routes/chat_details_screen/chat_details_screen.dart';
import 'package:nexglobal/routes/service_provider_profile/service_provider_profile.dart';

class AssociationsScreen extends StatelessWidget {
  const AssociationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        elevation: 0,
        title: const Text(
          'Associations',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.green[600],
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search associations...',
                          prefixIcon: const Icon(Icons.search, color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: PopupMenuButton<String>(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          offset: const Offset(0, 48),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Country',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.grey[600],
                                ),
                              ],
                            ),
                          ),
                          itemBuilder: (context) => [
                            'All Countries',
                            'Kenya',
                            'Uganda',
                            'Tanzania',
                            'Rwanda',
                            'Ethiopia',
                          ].map((country) {
                            return PopupMenuItem<String>(
                              value: country,
                              child: Text(country),
                            );
                          }).toList(),
                          onSelected: (String value) {
                            // Handle country selection
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _FilterChip(
                        label: 'All',
                        isSelected: true,
                        onTap: () {},
                      ),
                      _FilterChip(
                        label: 'Top Rated',
                        isSelected: false,
                        onTap: () {},
                      ),
                      _FilterChip(
                        label: 'Most Experienced',
                        isSelected: false,
                        onTap: () {},
                      ),
                      _FilterChip(
                        label: 'Recently Active',
                        isSelected: false,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 20,
              itemBuilder: (context, index) {
                return _AgentCard(
                  name: 'Association ${index + 1}',
                  company: 'Association ${index + 1}',
                  rating: 4.5,
                  experience: '${5 + index} years',
                  location: 'Nairobi, Kenya',
                  isVerified: index % 3 == 0,
                  onTap: () {
                    // Handle agent selection
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const ServiceProviderProfileScreen(),
                    //   ),
                    // );
                  },
                );
              },
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     // Handle becoming a clearing agent
      //   },
      //   backgroundColor: Colors.green[600],
      //   icon: const Icon(Icons.add_business),
      //   label: const Text('Become an Agent'),
      // ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.green[600] : Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _AgentCard extends StatelessWidget {
  final String name;
  final String company;
  final double rating;
  final String experience;
  final String location;
  final bool isVerified;
  final VoidCallback onTap;

  const _AgentCard({
    required this.name,
    required this.company,
    required this.rating,
    required this.experience,
    required this.location,
    required this.isVerified,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey[200],
                    child: Text(
                      name[0],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (isVerified) ...[
                              const SizedBox(width: 4),
                              Icon(
                                Icons.verified,
                                size: 16,
                                color: Colors.blue[600],
                              ),
                            ],
                          ],
                        ),
                        Text(
                          company,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.amber[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          rating.toString(),
                          style: TextStyle(
                            color: Colors.green[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildInfoChip(Icons.work, experience),
                  const SizedBox(width: 16),
                  _buildInfoChip(Icons.location_on, location),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Handle view profile
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ServiceProviderProfileScreen(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.green[600],
                        side: BorderSide(color: Colors.green[600]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('View Profile'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Handle message
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChatDetailsScreen(name: 'Association',),
                          ),
                        );
                      },
                      icon: const Icon(Icons.message),
                      label: const Text('Message'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
