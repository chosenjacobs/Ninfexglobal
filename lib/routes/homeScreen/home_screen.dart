import 'package:flutter/material.dart';
import '../company_profile/company_profile.dart';
import '../notifications_screen/notifications_screen.dart';
import '../messages_screen/messages_screen.dart';
import '../service_details_screen/service_details_screen.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedService;
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;
  final TextEditingController priceController = TextEditingController();

  final List<Map<String, String>> advertisements = [
    {
      'image': 'https://example.com/ad1.jpg',
      'title': 'Special Offer on TikTok Services',
    },
    {
      'image': 'https://example.com/ad2.jpg',
      'title': 'Instagram Followers Package',
    },
    // Add more advertisements as needed
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoSlide();
  }

  @override
  void dispose() {
    priceController.dispose();
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < advertisements.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  Widget _buildAdvertisementBanner() {
    return Container(
      height: 150,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: advertisements.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        advertisements[index]['image']!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(Icons.image_not_supported, 
                              size: 40, 
                              color: Colors.grey[400],
                            ),
                          );
                        },
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.7),
                                Colors.transparent,
                              ],
                            ),
                          ),
                          child: Text(
                            advertisements[index]['title']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                advertisements.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index 
                      ? Colors.white 
                      : Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onServiceSelected(String service) {
    setState(() {
      selectedService = selectedService == service ? null : service;
    });
  }

  final List<Map<String, dynamic>> platforms = const [
    {
      'name': 'TikTok',
      'services': ['TikTok likes', 'TikTok followers', 'TikTok views', 'TikTok saves'],
    },
    {
      'name': 'Instagram',
      'services': ['Instagram followers', 'Instagram likes', 'Instagram views', 'Instagram saves'],
    },
    {
      'name': 'YouTube',
      'services': ['YouTube subscribers', 'YouTube views', 'YouTube likes', 'YouTube comments'],
    },
    {
      'name': 'Twitter',
      'services': ['Twitter followers', 'Twitter likes', 'Twitter retweets', 'Twitter views'],
    },
    {
      'name': 'LinkedIn',
      'services': ['LinkedIn connections', 'LinkedIn followers', 'LinkedIn engagement', 'LinkedIn posts'],
    },
    {
      'name': 'Facebook',
      'services': ['Facebook likes', 'Facebook followers', 'Facebook views', 'Facebook shares'],
    },
    {
      'name': 'Instagram',
      'services': ['Instagram followers', 'Instagram likes', 'Instagram views', 'Instagram saves'],
    },
    {
      'name': 'Spotify',
      'services': ['Spotify plays', 'Spotify followers', 'Spotify monthly listeners', 'Spotify playlists'],
    },
    {
      'name': 'Snapchat',
      'services': ['Snapchat followers', 'Snapchat views', 'Snapchat engagement', 'Snapchat stories'],
    },
    {
      'name': 'Boomplay',
      'services': ['Boomplay plays', 'Boomplay followers', 'Boomplay downloads', 'Boomplay shares'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 67, 160, 72),
        title: const Text('Ninfex Global', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.message, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MessagesScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              // Handle profile
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildAdvertisementBanner(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Platforms',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 16, right: 16),
              itemCount: platforms.length,
              itemBuilder: (context, index) {
                final platform = platforms[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      Card(
                        elevation: 2,
                        color: Colors.white,
                        shadowColor: Colors.black.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(color: Colors.black),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Upper part - clickable area
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CompanyProfileScreen(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(25),
                                          child: Image.network(
                                            'https://t3.ftcdn.net/jpg/04/52/34/62/360_F_452346210_m6Ni5BJnosaqM7Is0wJh0fwJEvfx8XDH.jpg',
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return CircleAvatar(
                                                radius: 25,
                                                backgroundColor: Colors.grey[200],
                                                child: Icon(
                                                  Icons.business,
                                                  color: Colors.grey[800],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                platform['name'],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 4),
                                             
                                              const SizedBox(height: 4),
                                              
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
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.verified_user,
                                                size: 16,
                                                color: Colors.green[600],
                                              ),
                                              const SizedBox(width: 4),
                                             
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Products section
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Services:',
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 4),
                                  _CompanyProductsList(
                                    products: platform['services'],
                                    isGridView: false,
                                    onServiceSelected: onServiceSelected,
                                    selectedService: selectedService,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            if (selectedService != null && 
                                platform['services'].contains(selectedService))
                              _buildServiceForm(),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.green.shade50,
                  Colors.white,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      icon,
                      size: 32,
                      color: Colors.green.shade700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompanyCard(BuildContext context) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CompanyProfileScreen(),
              ),
            );
          },
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Company Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.location_on, 
                            size: 14, 
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              'Location',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.category, 
                            size: 14, 
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              'Industry',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.verified_user,
                      size: 14,
                      color: Colors.blue[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Trust Score: 4.5',
                      style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  
                  'Products:',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                _CompanyProductsList(
                  products: const [
                    'Electronics',
                    'Smartphones',
                    'Accessories',
                    'Laptops',
                    'Tablets',
                    'Smartwatches'
                  ],
                  onServiceSelected: (service) {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompanyGridCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CompanyProfileScreen(),
            ),
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Company Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.location_on, 
                            size: 14, 
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              'Location',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.category, 
                            size: 14, 
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              'Industry',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.verified_user,
                      size: 14,
                      color: Colors.blue[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Trust Score: 4.5',
                      style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Products:',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                _CompanyProductsList(
                  products: const [
                    'Electronics',
                    'Smartphones',
                    'Accessories',
                    'Laptops',
                    'Tablets',
                    'Smartwatches'
                  ],
                  isGridView: true,
                  onServiceSelected: (service) {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard() {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: SizedBox(
          height: 180,
          child: Column(
            children: [
              Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Image.network(
                        'https://t3.ftcdn.net/jpg/04/52/34/62/360_F_452346210_m6Ni5BJnosaqM7Is0wJh0fwJEvfx8XDH.jpg',
                        width: double.infinity,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[100],
                            child: Center(
                              child: Icon(
                                Icons.inventory_2,
                                size: 32,
                                color: Colors.green[600],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.favorite_border,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Product Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Category',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'MOQ: 100',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Quantity',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: const Icon(Icons.numbers),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final quantity = int.tryParse(value) ?? 0;
              final totalPrice = quantity * 1000;
              priceController.text = quantity > 0 
                  ? 'UGX ${totalPrice.toStringAsFixed(0)}'
                  : '';
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: priceController,
            enabled: false,
            decoration: InputDecoration(
              labelText: 'Price',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: const Icon(Icons.attach_money),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Link',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: const Icon(Icons.link),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Handle payment
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[600],
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Pay Now',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FilterBottomSheet extends StatefulWidget {
  final ScrollController scrollController;

  const FilterBottomSheet({
    super.key,
    required this.scrollController,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? selectedCountry;
  final List<String> countries = ['Kenya', 'Uganda', 'Tanzania', 'Rwanda'];

  Widget _buildCountrySection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Country',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedCountry,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              hint: const Text('Select a country'),
              items: countries.map((String country) {
                return DropdownMenuItem<String>(
                  value: country,
                  child: Text(country),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCountry = newValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fixed header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filters',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Handle reset
                },
                child: Text(
                  'Reset All',
                  style: TextStyle(
                    color: Colors.green[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          // Apply Filters button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Apply filter logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Apply Filters',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              controller: widget.scrollController,
              child: Column(
                children: [
                  _buildCountrySection(),
                  _buildFilterSection(
                    title: 'Company Type',
                    items: ['Importer', 'Exporter']
                  ),
                  _buildFilterSection(
                    title: 'Company Category',
                    items: ['Vehicles', 'Fruits & Vegetables', 'Medicine']
                  ),
                  _buildFilterSection(
                    title: 'Sort By',
                    items: ['Best price', 'Best rating', 'Newly added']
                  ),
                  _buildFilterSection(
                    title: 'Verification Status',
                    items: ['Verified', 'Not Verified', 'Any']
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection({
    required String title,
    required List<String> items,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 12,
              children: items.map((item) {
                final isSelected = selectedCountry == item;
                return FilterChip(
                  label: Text(item),
                  selected: isSelected,
                  showCheckmark: false,
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedCountry = item;
                      } else {
                        selectedCountry = null;
                      }
                    });
                  },
                  selectedColor: Colors.green[50],
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: isSelected ? Colors.green[600]! : Colors.grey[300]!,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.green[700] : Colors.grey[800],
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    fontSize: 14,
                  ),
                  elevation: 0,
                  pressElevation: 0,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompanyProductsList extends StatefulWidget {
  final List<String> products;
  final bool isGridView;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Function(String) onServiceSelected;
  final String? selectedService;

  const _CompanyProductsList({
    required this.products,
    this.isGridView = false,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    required this.onServiceSelected,
    this.selectedService,
  });

  @override
  State<_CompanyProductsList> createState() => _CompanyProductsListState();
}

class _CompanyProductsListState extends State<_CompanyProductsList> {
  bool isExpanded = false;
  static const int initialProductCount = 2;

  @override
  Widget build(BuildContext context) {
    final allProducts = widget.products;
    final displayProducts = widget.selectedService != null || isExpanded 
        ? allProducts 
        : allProducts.take(initialProductCount).toList();
    final remainingCount = allProducts.length - initialProductCount;
    final showExpandButton = remainingCount > 0 && widget.selectedService == null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          spacing: 4,
          runSpacing: 4,
          children: displayProducts.map((product) => GestureDetector(
            onTap: () => widget.onServiceSelected(product),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: widget.selectedService == product ? Colors.green[100] : Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                product,
                style: TextStyle(
                  color: widget.selectedService == product ? Colors.green[800] : Colors.grey[800],
                  fontSize: 12,
                ),
              ),
            ),
          )).toList(),
        ),
        if (showExpandButton) ...[
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '+$remainingCount more services',
                  style: TextStyle(
                    color: widget.textColor ?? Colors.green[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 16,
                  color: widget.textColor ?? Colors.green[600],
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
