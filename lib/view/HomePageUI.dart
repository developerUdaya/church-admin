import 'package:flutter/material.dart';

class GymFoodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym Food Ordering',
      theme: ThemeData(primarySwatch: Colors.green),
      home: GymFoodHomePage(),
    );
  }
}

class GymFoodHomePage extends StatefulWidget {
  @override
  _GymFoodHomePageState createState() => _GymFoodHomePageState();
}

class _GymFoodHomePageState extends State<GymFoodHomePage> {
  List<Map<String, dynamic>> products = [
    {
      'name': 'Chicken Breast',
      'protein': 31,
      'calories': 165,
      'image': 'assets/food.png',
      'quantity': 0,
    },
    {
      'name': 'Eggs',
      'protein': 13,
      'calories': 155,
      'image': 'assets/food.png',
      'quantity': 0,
    },
    {
      'name': 'Greek Yogurt',
      'protein': 10,
      'calories': 59,
      'image': 'assets/food.png',
      'quantity': 0,
    },
    {
      'name': 'Protein Shake',
      'protein': 25,
      'calories': 120,
      'image': 'assets/food.png',
      'quantity': 0,
    },
  ];

  List<Map<String, dynamic>> cart = [];
  int _selectedIndex = 0;

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      bool isInCart = false;
      for (var item in cart) {
        if (item['name'] == product['name']) {
          item[
          'quantity']++; // Increment quantity if the item is already in the cart
          isInCart = true;
          break;
        }
      }
      if (!isInCart) {
        // Add the product with quantity = 1 if not already in the cart
        cart.add({...product, 'quantity': 1});
      }
    });
  }

  void removeFromCart(Map<String, dynamic> product) {
    setState(() {
      for (var item in cart) {
        if (item['name'] == product['name']) {
          item['quantity']--;
          if (item['quantity'] <= 0) {
            cart.remove(item); // Remove the item if quantity is 0
          }
          break;
        }
      }
    });
  }

  void removeFromCartTotaly (Map<String, dynamic> product) {
    setState(() {
      cart.remove(product);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showOrderDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Order Foods Here'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  child: ListTile(
                    leading: Image.asset(product['image']),
                    title: Text(product['name']),
                    subtitle: Text(
                        'Protein: ${product['protein']}g,\nCalories: ${product['calories']} kcal'),
                    trailing: ElevatedButton(
                      onPressed: () => addToCart(product),
                      child: Text('Add'),
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Done'),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      // Home Page
      Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                onPressed: _showOrderDialog,
                child: Text('Order Foods'),
              ),
            ),
            cart.isEmpty
                ? Expanded(
                child: Center(
                    child: Text('Cart is empty\n Add some items to cart')))
                : Expanded(
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final product = cart[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: ListTile(
                              leading: Image.asset(product['image']),
                              title: Text(product['name']),
                              subtitle: Text(
                                  'Protein: ${product['protein']}g,\nCalories: ${product['calories']} kcal'),
                            ),
                          ),
                          Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () => addToCart(
                                        product), // Call addToCart to increment quantity
                                    child: Icon(Icons.add),
                                  ),
                                  Text(product['quantity'].toString()),
                                  ElevatedButton(
                                    onPressed: () => removeFromCart(
                                        product), // Call removeFromCart to decrement quantity
                                    child: Icon(Icons.remove),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () => removeFromCartTotaly(product),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Remove'),
                                    Icon(Icons.delete),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Total Protein: ${cart.fold<int>(0, (sum, item) => (sum + item['protein']) * item['quantity'] as int)}g',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Total Calories: ${cart.fold<int>(0, (sum, item) => (sum + item['calories']) * item['quantity'] as int)} kcal',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Empty Page
      Center(
        child: Text('Empty page'),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Gym Food Ordering'),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Empty Page',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}
