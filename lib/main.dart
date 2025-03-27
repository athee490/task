import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScaffold(), // Our main page with header, search, categories, bottom nav
    );
  }
}

class MainScaffold extends StatelessWidget {
  const MainScaffold({Key? key}) : super(key: key);

  // Navigation helper used for header and bottom nav taps.
  void _navigateToDetail(BuildContext context, String label) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailPage(categoryName: label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            children: [
              // Header Section
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left side: Avatar and Location
                      Row(
                        children: [
                          // Wrap avatar with GestureDetector
                          GestureDetector(
                            onTap: () => _navigateToDetail(context, "Avatar"),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Vijay_at_Protest_of_the_Nadigar_Sangam.jpg/250px-Vijay_at_Protest_of_the_Nadigar_Sangam.jpg',
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          GestureDetector(
                            onTap: () => _navigateToDetail(context, "Location"),
                            child: Row(
                              children: [
                                Icon(Icons.location_on, color: Colors.white),
                                SizedBox(width: 4),
                                Text(
                                  'Anna Nagar',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(width: 4),
                                Icon(Icons.arrow_drop_down, color: Colors.white),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Right side: Notifications and Chat
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => _navigateToDetail(context, "Notifications"),
                            child: Icon(Icons.notifications, color: Colors.white),
                          ),
                          SizedBox(width: 16),
                          GestureDetector(
                            onTap: () => _navigateToDetail(context, "Chat"),
                            child: Icon(Icons.chat_bubble_outline, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: SearchBar(),
              ),

              // ============= The Categories Section =============
              // Replace the placeholder Expanded with our new widget
              Expanded(
                child: CategoriesSection(), // Insert categories here
              ),
            ],
          ),

          // Bottom Navigation Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  color: Color(0xFF1F1B2E),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Wrap nav items with GestureDetector to navigate on tap.
                      buildNavItem(context, Icons.home, "Home", Colors.white),
                      buildNavItem(context, Icons.store, "Shop", Colors.purple),
                      SizedBox(width: 56), // Space for center icon
                      buildNavItem(context, Icons.person, "Experts", Colors.white),
                      buildNavItem(context, Icons.article, "Blogs", Colors.white),
                    ],
                  ),
                ),
                // Center Floating Button with an asset image
                Positioned(
                  top: -28,
                  left: 0,
                  right: 0,
                  child: Center(child: buildCenterIcon()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Bottom nav item wrapped with GestureDetector for navigation.
  Widget buildNavItem(BuildContext context, IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () {
        // Navigate when tapped.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailPage(categoryName: label),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(color: color, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // Center floating icon replaced with an asset image.
  Widget buildCenterIcon() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Image.asset(
        'assets/cen.png',
        width: 50,
        height: 50,
      ),
    );
  }
}

// ================== Search Bar Widget ==================
class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6A1B9A), Color(0xFF4A148C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search anything...',
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          suffixIcon: Container(
            margin: EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Color(0xFF8E24AA),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}

// =============== Categories Section ===============
class CategoriesSection extends StatelessWidget {
  const CategoriesSection({Key? key}) : super(key: key);

  // Helper method to navigate to detail page for categories.
  void _onCategoryTap(BuildContext context, String categoryName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailPage(categoryName: categoryName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This Stack displays your home_categories.png with clickable areas.
    return Center(
      child: Stack(
        children: [
          // The background image.
          Image.asset(
            'assets/home_categories.png',
            width: 400,
            height: 400,
            fit: BoxFit.cover,
          ),

          // ========== 1. Sofas ==========
          Positioned(
            left: 160,
            top: 10,
            child: GestureDetector(
              onTap: () => _onCategoryTap(context, 'Sofas'),
              child: Container(
                width: 80,
                height: 80,
                color: Colors.transparent,
              ),
            ),
          ),

          // ========== 2. Mirrors ==========
          Positioned(
            left: 40,
            top: 60,
            child: GestureDetector(
              onTap: () => _onCategoryTap(context, 'Mirrors'),
              child: Container(
                width: 80,
                height: 80,
                color: Colors.transparent,
              ),
            ),
          ),

          // ========== 3. Frames ==========
          Positioned(
            left: 280,
            top: 60,
            child: GestureDetector(
              onTap: () => _onCategoryTap(context, 'Frames'),
              child: Container(
                width: 80,
                height: 80,
                color: Colors.transparent,
              ),
            ),
          ),

          // ========== 4. Plants ==========
          Positioned(
            left: 320,
            top: 150,
            child: GestureDetector(
              onTap: () => _onCategoryTap(context, 'Plants'),
              child: Container(
                width: 80,
                height: 80,
                color: Colors.transparent,
              ),
            ),
          ),

          // ========== 5. Beds ==========
          Positioned(
            left: 50,
            top: 180,
            child: GestureDetector(
              onTap: () => _onCategoryTap(context, 'Beds'),
              child: Container(
                width: 80,
                height: 80,
                color: Colors.transparent,
              ),
            ),
          ),

          // ========== 6. Table ==========
          Positioned(
            left: 0,
            top: 250,
            child: GestureDetector(
              onTap: () => _onCategoryTap(context, 'Table'),
              child: Container(
                width: 80,
                height: 80,
                color: Colors.transparent,
              ),
            ),
          ),

          // ========== 7. Lamps ==========
          Positioned(
            left: 60,
            top: 310,
            child: GestureDetector(
              onTap: () => _onCategoryTap(context, 'Lamps'),
              child: Container(
                width: 80,
                height: 80,
                color: Colors.transparent,
              ),
            ),
          ),

          // ========== 8. Wardrobe ==========
          Positioned(
            left: 160,
            top: 320,
            child: GestureDetector(
              onTap: () => _onCategoryTap(context, 'Wardrobe'),
              child: Container(
                width: 80,
                height: 80,
                color: Colors.transparent,
              ),
            ),
          ),

          // ========== 9. Dining ==========
          Positioned(
            left: 270,
            top: 280,
            child: GestureDetector(
              onTap: () => _onCategoryTap(context, 'Dining'),
              child: Container(
                width: 80,
                height: 80,
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============== Detail Page ===============
class DetailPage extends StatelessWidget {
  final String categoryName;

  const DetailPage({Key? key, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'You clicked $categoryName',
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}