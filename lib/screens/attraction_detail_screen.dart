import 'package:flutter/material.dart';

import '../models/attraction.dart';
import '../widgets/category_badge.dart';
import '../widgets/rating_widget.dart';
import 'review_screen.dart';

class AttractionDetailScreen extends StatelessWidget {
  final Attraction attraction;

  const AttractionDetailScreen({
    super.key,
    required this.attraction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(attraction.name),
        backgroundColor: const Color(0xFF1D4ED8),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// IMAGE
            Image.asset(
              attraction.image,
              height: 260,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// TITLE + CATEGORY
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      Expanded(
                        child: Text(
                          attraction.name,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      CategoryBadge(
                        category: attraction.category,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// LOCATION
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),

                      const SizedBox(width: 6),

                      Expanded(
                        child: Text(
                          attraction.location,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// RATING
                  RatingWidget(
                    rating: attraction.rating,
                    reviewCount: attraction.reviewCount,
                  ),

                  const SizedBox(height: 24),

                  /// DESCRIPTION TITLE
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// DESCRIPTION
                  Text(
                    attraction.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.reviews),

                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ReviewScreen(
                              attraction: attraction,
                            ),
                          ),
                        );
                      },

                      label: const Text(
                        'View Reviews',
                      ),

                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF1D4ED8),

                        foregroundColor: Colors.white,

                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                      ),
                    ),
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