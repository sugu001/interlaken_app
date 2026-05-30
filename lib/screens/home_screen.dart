import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/attractions_data.dart';
import '../widgets/category_badge.dart';
import '../widgets/rating_widget.dart';
import 'attraction_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchText = '';
  String selectedCategory = 'All';

  List<String> favoriteNames = [];

  final List<String> categories = [
    'All',
    'Scenic',
    'Adventure',
    'Fun Park',
    'Food',
    'Hotel',
    'Favorites',
  ];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      favoriteNames = prefs.getStringList('favorites') ?? [];
    });
  }

  Future<void> toggleFavorite(String name) async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      if (favoriteNames.contains(name)) {
        favoriteNames.remove(name);
      } else {
        favoriteNames.add(name);
      }
    });

    await prefs.setStringList('favorites', favoriteNames);
  }

  String getCategoryLabel(String category) {
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
    final filteredAttractions = attractions.where((attraction) {
      final search = searchText.toLowerCase();

      final matchesSearch =
          attraction.name.toLowerCase().contains(search) ||
          attraction.category.toLowerCase().contains(search) ||
          attraction.location.toLowerCase().contains(search);

      final matchesCategory =
          selectedCategory == 'All' ||
          getCategoryLabel(attraction.category) == selectedCategory;

      final matchesFavorite =
          selectedCategory != 'Favorites' ||
          favoriteNames.contains(attraction.name);

      return matchesSearch && matchesCategory && matchesFavorite;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Interlaken Attractions'),
        backgroundColor: const Color(0xFF1D4ED8),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search attraction, food, hotel...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),

          SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    selectedColor: const Color(0xFF1D4ED8),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    onSelected: (_) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          Expanded(
            child: filteredAttractions.isEmpty
                ? const Center(child: Text('No attraction found'))
                : ListView.builder(
                    itemCount: filteredAttractions.length,
                    itemBuilder: (context, index) {
                      final attraction = filteredAttractions[index];
                      final isFavorite = favoriteNames.contains(
                        attraction.name,
                      );

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AttractionDetailScreen(
                                attraction: attraction,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.asset(
                                        attraction.image,
                                        height: 180,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: IconButton(
                                          icon: Icon(
                                            isFavorite
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            toggleFavorite(attraction.name);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 14),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                    CategoryBadge(
                                      category: attraction.category,
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 12),

                                Text(
                                  attraction.location,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),

                                const SizedBox(height: 14),

                                RatingWidget(
                                  rating: attraction.rating,
                                  reviewCount: attraction.reviewCount,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
