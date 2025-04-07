import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wardrobe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Quick Try-On Button
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextButton.icon(
                icon: const Icon(Icons.photo_camera, color: Colors.white),
                label: const Text(
                  'Quick Try-On',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const TryOnPage()),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Featured Outfits
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Featured Outfits',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildFeaturedOutfitCard(
                    'Summer Casual',
                    'https://images.pexels.com/photos/5886041/pexels-photo-5886041.jpeg',
                  ),
                  _buildFeaturedOutfitCard(
                    'Office Wear',
                    'https://images.pexels.com/photos/2983464/pexels-photo-2983464.jpeg',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Recent Try-Ons
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent Try-Ons',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildRecentTryOnCard(
                    'White T-shirt',
                    'https://images.pexels.com/photos/428340/pexels-photo-428340.jpeg',
                  ),
                  _buildRecentTryOnCard(
                    'Blue Jeans',
                    'https://images.pexels.com/photos/1598507/pexels-photo-1598507.jpeg',
                  ),
                  _buildRecentTryOnCard(
                    'Gray Sweater',
                    'https://images.pexels.com/photos/845434/pexels-photo-845434.jpeg',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Style Suggestions
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Style Suggestions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildSuggestionTile(
                      Icons.lightbulb_outline,
                      'Mix & Match',
                      'Try pairing your blue jeans with this white shirt',
                      Colors.blue,
                    ),
                    const Divider(),
                    _buildSuggestionTile(
                      Icons.calendar_today,
                      'Weekend Look',
                      'Perfect outfit for a casual weekend',
                      Colors.purple,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedOutfitCard(String title, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: SizedBox(
        width: 200,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  height: 200,
                  width: 200,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentTryOnCard(String title, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionTile(
      IconData icon, String title, String subtitle, Color color) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
    );
  }
}