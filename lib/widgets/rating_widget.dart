import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  final String reviewCount;

  const RatingWidget({
    super.key,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 20),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 6),
        Text(
          '($reviewCount reviews)',
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}