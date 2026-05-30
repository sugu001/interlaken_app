import 'package:flutter/material.dart';

import '../models/attraction.dart';
import 'category_badge.dart';
import 'rating_widget.dart';

class AttractionCard extends StatelessWidget {
  final Attraction attraction;
  final VoidCallback onTap;

  const AttractionCard({
    super.key,
    required this.attraction,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      attraction.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CategoryBadge(category: attraction.category),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                attraction.location,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 12),
              RatingWidget(
                rating: attraction.rating,
                reviewCount: attraction.reviewCount,
              ),
            ],
          ),
        ),
      ),
    );
  }
}