import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Shop',
      theme: ThemeData.dark(),
      home: MobileShopScreen(),
    );
  }
}

class MobileShopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {},
        ),
        title: Text(
          'Mobile Phone',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
        ],
        flexibleSpace: Container(
          // Simulate status bar
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 40), // Approximate status bar height
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      '9:41',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.signal_wifi_4_bar, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Icon(Icons.battery_full, color: Colors.white, size: 16),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Brand chips
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildBrandChip('iPhone'),
                SizedBox(width: 12),
                _buildBrandChip('Samsung'),
                SizedBox(width: 12),
                _buildBrandChip('Nothing'),
                SizedBox(width: 12),
                _buildBrandChip('Xiaomi'),
                SizedBox(width: 12),
                _buildBrandChip('Ho'),
              ],
            ),
          ),
          // Product grid
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(16),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildProductCard(
                  imageUrl: 'https://via.placeholder.com/200x300/000000/FFFFFF?text=Samsung+S25+Ultra', // Placeholder
                  title: 'Samsung Galaxy S25 Ultra',
                  subtitle: 'Galaxy S25 Ultra',
                  price: '\$1,247 USD',
                ),
                _buildProductCard(
                  imageUrl: 'https://via.placeholder.com/200x300/000000/FFFFFF?text=OnePlus+13', // Placeholder
                  title: 'OnePlus 13 - Co-developed with',
                  subtitle: 'Hasselblad',
                  price: 'From \$899 USD',
                ),
                _buildProductCard(
                  imageUrl: 'https://via.placeholder.com/200x300/000000/FFFFFF?text=iPhone+16', // Placeholder
                  title: 'iPhone 16 - A total',
                  subtitle: 'powerhouse',
                  price: 'From \$799',
                ),
                _buildProductCard(
                  imageUrl: 'https://via.placeholder.com/200x300/000000/FFFFFF?text=Nothing+Phone+2', // Placeholder
                  title: 'Nothing Phone (2)',
                  subtitle: 'Coming to the bright side',
                  price: '\$619.99 USD',
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'Scan'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildBrandChip(String label) {
    return ChoiceChip(
      label: Text(label, style: TextStyle(color: Colors.white, fontSize: 14)),
      selected: false,
      onSelected: (_) {},
      backgroundColor: Colors.grey[800],
      selectedColor: Colors.grey[600],
    );
  }

  Widget _buildProductCard({
    required String imageUrl,
    required String title,
    required String subtitle,
    required String price,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Stack(
                children: [
                  Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[800],
                      child: Icon(Icons.phone_android, color: Colors.grey, size: 50),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Icon(Icons.favorite_border, color: Colors.white, size: 20),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Text(
                  price,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}