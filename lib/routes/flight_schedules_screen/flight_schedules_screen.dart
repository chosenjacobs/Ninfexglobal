import 'package:flutter/material.dart';

class FlightSchedulesScreen extends StatelessWidget {
  const FlightSchedulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        elevation: 0,
        title: const Text(
          'Flight Schedules',
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
                      child: _buildDropdown('From', 'Nairobi (NBO)'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDropdown('To', 'Dubai (DXB)'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildDatePicker(context, 'Departure'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDropdown('Airline', 'All Airlines'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Handle search
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.green[600],
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Search Flights',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 10,
              itemBuilder: (context, index) {
                return _FlightCard(
                  airline: 'Airline ${index + 1}',
                  flightNumber: 'FL${1000 + index}',
                  departure: '10:${index}0 AM',
                  arrival: '12:${index}0 PM',
                  price: '${800 + (index * 50)}',
                  onTap: () {
                    // Handle flight selection
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, String initialValue) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: initialValue,
          isExpanded: true,
          hint: Text(label),
          items: [initialValue].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            // Handle selection
          },
        ),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context, String label) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
          ),
          Icon(
            Icons.calendar_today,
            color: Colors.grey[600],
            size: 20,
          ),
        ],
      ),
    );
  }
}

class _FlightCard extends StatelessWidget {
  final String airline;
  final String flightNumber;
  final String departure;
  final String arrival;
  final String price;
  final VoidCallback onTap;

  const _FlightCard({
    required this.airline,
    required this.flightNumber,
    required this.departure,
    required this.arrival,
    required this.price,
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
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[200],
                    child: Icon(
                      Icons.flight,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          airline,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Flight $flightNumber',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 12,
                  //     vertical: 6,
                  //   ),
                  //   decoration: BoxDecoration(
                  //     color: Colors.green[50],
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: Text(
                  //     '\$$price',
                  //     style: TextStyle(
                  //       color: Colors.green[600],
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 16,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTimeColumn('Departure', departure),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.grey[400],
                  ),
                  _buildTimeColumn('Arrival', arrival),
                ],
              ),
              // const SizedBox(height: 16),
              // OutlinedButton(
              //   onPressed: () {
              //     // Handle booking
              //   },
              //   style: OutlinedButton.styleFrom(
              //     foregroundColor: Colors.green[600],
              //     side: BorderSide(color: Colors.green[600]!),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     minimumSize: const Size(double.infinity, 44),
              //   ),
              //   child: const Text('Book Now'),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeColumn(String label, String time) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
