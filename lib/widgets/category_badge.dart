import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CategoryBadge extends StatelessWidget {
  final String category;

  const CategoryBadge({
    super.key,
    required this.category,
  });

  Color getColor() {
    switch (category) {
      case 'S':
        return AppColors.scenic;
      case 'A':
        return AppColors.adventure;
      case 'F':
        return AppColors.funPark;
      case 'R':
        return AppColors.food;
      case 'H':
        return AppColors.hotel;
      default:
        return AppColors.primary;
    }
  }

  String getLabel() {
    switch (category) {
      case 'S':
        return 'Scenic';
      case 'A':
        return 'Adventure';
      case 'F':
        return 'Fun Park';
      case 'R':
        return 'Food';
      case 'H':
        return 'Hotel';
      default:
        return 'Other';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: getColor(),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        getLabel(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}