import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/attraction.dart';
import '../widgets/category_badge.dart';
import '../widgets/rating_widget.dart';
import '../widgets/review_card.dart';

class ReviewScreen extends StatefulWidget {
  final Attraction attraction;

  const ReviewScreen({super.key, required this.attraction});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  List<Map<String, dynamic>> reviews = [];

  final TextEditingController controller = TextEditingController();

  double selectedRating = 3;

  String get storageKey => 'reviews_${widget.attraction.name}';

  @override
  void initState() {
    super.initState();
    loadReviews();
  }

  Future<void> loadReviews() async {
    final prefs = await SharedPreferences.getInstance();

    final savedReviews = prefs.getString(storageKey);

    if (savedReviews != null) {
      final List decodedReviews = jsonDecode(savedReviews);

      setState(() {
        reviews = decodedReviews
            .map((review) => Map<String, dynamic>.from(review))
            .toList();
      });
    } else {
      setState(() {
        reviews = [
          {
            'name': 'Brian',
            'rating': 5.0,
            'comment': 'Amazing experience and scenery!',
          },
          {
            'name': 'James',
            'rating': 4.0,
            'comment': 'Beautiful location and fun activities.',
          },
        ];
      });

      saveReviews();
    }
  }

  Future<void> saveReviews() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(storageKey, jsonEncode(reviews));
  }

  Future<void> addReview() async {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      reviews.add({
        'name': 'Guest User',
        'rating': selectedRating,
        'comment': controller.text.trim(),
      });
    });

    await saveReviews();
    if (!mounted) return;
    controller.clear();

    setState(() {
      selectedRating = 3;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Review saved successfully')));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double averageRating = widget.attraction.rating;

    if (reviews.isNotEmpty) {
      averageRating =
          reviews
              .map((review) => review['rating'] as double)
              .reduce((a, b) => a + b) /
          reviews.length;
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.attraction.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoryBadge(category: widget.attraction.category),

            const SizedBox(height: 16),

            RatingWidget(
              rating: averageRating,
              reviewCount: reviews.length.toString(),
            ),

            const SizedBox(height: 24),

            const Text(
              'Reviews',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];

                  return ReviewCard(
                    username: review['name'],
                    rating: review['rating'],
                    comment: review['comment'],
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => IconButton(
                  onPressed: () {
                    setState(() {
                      selectedRating = index + 1.0;
                    });
                  },
                  icon: Icon(
                    index < selectedRating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 32,
                  ),
                ),
              ),
            ),

            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Write a review...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addReview,
                child: const Text('Submit Review'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
