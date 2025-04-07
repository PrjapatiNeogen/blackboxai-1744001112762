import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WardrobePage extends StatefulWidget {
  const WardrobePage({super.key});

  @override
  State<WardrobePage> createState() => _WardrobePageState();
}

class _WardrobePageState extends State<WardrobePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Tops', 'Bottoms', 'Dresses', 'Outerwear'];
  final List<Map<String, dynamic>> _clothingItems = [
    {
      'image': 'https://images.pexels.com/photos/428340/pexels-photo-428340.jpeg',
      'name': 'White T-shirt',
      'category': 'Tops',
      'date': '2 days ago'
    },
    {
      'image': 'https://images.pexels.com/photos/1598507/pexels-photo-1598507.jpeg',
      'name': 'Blue Jeans',
      'category': 'Bottoms',
      'date': '1 week ago'
    },
    {
      'image': 'https://images.pexels.com/photos/845434/pexels-photo-845434.jpeg',
      'name': 'Gray Sweater',
      'category': 'Outerwear',
      'date': '3 days ago'
    },
    {
      'image': 'https://images.pexels.com/photos/994517/pexels-photo-994517.jpeg',
      'name': 'Silk Blouse',
      'category': 'Tops',
      'date': '2 weeks ago'
    },
    {
      'image': 'https://images.pexels.com/photos/1485031/pexels-photo-1485031.jpeg',
      'name': 'Summer Dress',
      'category': 'Dresses',
      'date': '1 month ago'
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wardrobe'),
        bottom: TabBar(
          controller: _tabController,
          tabs: _categories.map((category) => Tab(text: category)).toList(),
          onTap: (index) {
            setState(() {
              _selectedCategory = _categories[index];
            });
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _categories.map((category) {
          return _buildClothingGrid(category);
        }).toList(),
      ),
    );
  }

  Widget _buildClothingGrid(String category) {
    final filteredItems = category == 'All'
        ? _clothingItems
        : _clothingItems.where((item) => item['category'] == category).toList();

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return Card(
          child: Column(
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: item['image'],
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  item['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                item['date'],
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        );
      },
    );
  }
}