import 'package:flutter/material.dart';

import '../data/attractions_data.dart';
import 'manage_attractions_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  int countCategory(String category) {
    return attractions.where((item) => item.category == category).length;
  }

  Widget buildCard(String title, String value, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white70, fontSize: 15),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: const Color(0xFF1D4ED8),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ManageAttractionsScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.edit_location_alt),
                label: const Text(
                  'Manage Attractions',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D4ED8),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  buildCard(
                    'Total Attractions',
                    attractions.length.toString(),
                    Colors.blue,
                  ),
                  buildCard(
                    'Scenic',
                    countCategory('S').toString(),
                    Colors.green,
                  ),
                  buildCard(
                    'Adventure',
                    countCategory('A').toString(),
                    Colors.orange,
                  ),
                  buildCard(
                    'Fun Park',
                    countCategory('F').toString(),
                    Colors.pink,
                  ),
                  buildCard(
                    'Food',
                    countCategory('R').toString(),
                    Colors.brown,
                  ),
                  buildCard(
                    'Hotels',
                    countCategory('H').toString(),
                    Colors.deepPurple,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
