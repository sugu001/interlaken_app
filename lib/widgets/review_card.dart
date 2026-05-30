import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final String username;
  final double rating;
  final String comment;

  const ReviewCard({
    super.key,
    required this.username,
    required this.rating,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              username,

              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Row(
              children: List.generate(
                5,

                (index) => Icon(
                  index < rating ? Icons.star : Icons.star_border,

                  color: Colors.amber,
                ),
              ),
            ),

            const SizedBox(height: 8),

            Text(comment),
          ],
        ),
      ),
    );
  }
}
