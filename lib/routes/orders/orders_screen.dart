import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> orders = [];
  Map<String, List<Map<String, dynamic>>> categorizedOrders = {};
  Map<String, dynamic>? selectedOrder;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _generateDummyData();
  }

  void _generateDummyData() {
    orders = List.generate(20, (index) {
      return {
        'id': index + 1,
        'date': '2023-10-${(index % 30) + 1}',
        'link': 'https://example.com/order/${index + 1}',
        'charge': (index + 1) * 1000,
        'startCount': (index + 1) * 2,
        'quantity': (index + 1) * 3,
        'service': 'Service ${index % 5 + 1}',
        'remains': (index + 1) * 5,
        'status': [
          'pending',
          'in_progress',
          'completed',
          'partial',
          'processing',
          'canceled'
        ][index % 6],
      };
    });

    // Categorize orders by status
    for (var order in orders) {
      String status = order['status'];
      if (categorizedOrders[status] == null) {
        categorizedOrders[status] = [];
      }
      categorizedOrders[status]!.add(order);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildOrderDetails(Map<String, dynamic> order) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('ID', '#${order['id']}'),
            _buildDetailRow('Date', order['date']),
            _buildDetailRow('Link', order['link']),
            _buildDetailRow('Charge', 'UGX ${order['charge']}'),
            _buildDetailRow('Start Count', order['startCount'].toString()),
            _buildDetailRow('Quantity', order['quantity'].toString()),
            _buildDetailRow('Service', order['service']),
            _buildDetailRow('Remains', order['remains'].toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(List<Map<String, dynamic>> orders) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedOrder = orders[index];
            });
          },
          child: _buildOrderDetails(orders[index]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Combine all orders for the "All" tab
    List<Map<String, dynamic>> allOrders = orders;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Pending'),
            Tab(text: 'In Progress'),
            Tab(text: 'Completed'),
            Tab(text: 'Partial'),
            Tab(text: 'Processing'),
            Tab(text: 'Canceled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrdersList(allOrders),
          _buildOrdersList(categorizedOrders['pending'] ?? []),
          _buildOrdersList(categorizedOrders['in_progress'] ?? []),
          _buildOrdersList(categorizedOrders['completed'] ?? []),
          _buildOrdersList(categorizedOrders['partial'] ?? []),
          _buildOrdersList(categorizedOrders['processing'] ?? []),
          _buildOrdersList(categorizedOrders['canceled'] ?? []),
        ],
      ),
      floatingActionButton: selectedOrder != null
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  selectedOrder = null; // Clear selection
                });
              },
              child: const Icon(Icons.close),
            )
          : null,
    );
  }
}
