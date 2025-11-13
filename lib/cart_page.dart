import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storeapp/controllers/chartcontroller.dart';
import 'package:storeapp/models/chartmodel.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController cartController = Get.find<CartController>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    setState(() {
      _isLoading = true;
    });
    // Simulate fetching cart data (replace with actual API call if needed)
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _isLoading = false;
    });
  }

  void _removeItem(CartItem item) {
    cartController.cartItems.remove(item);
    cartController.cartItems.refresh();
    Get.snackbar('Removed', '${item.product.name} removed from cart');
  }

  void _updateQuantity(CartItem item, bool increase) {
    if (increase) {
      item.quantity++;
    } else if (item.quantity > 1) {
      item.quantity--;
    } else {
      _removeItem(item);
      return;
    }
    cartController.cartItems.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadCart,
            tooltip: 'Refresh Cart',
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Obx(
              () => cartController.cartItems.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 100,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Your cart is empty',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () => Get.back(),
                            child: Text('Shop Now'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(150, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(16.0),
                      itemCount: cartController.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartController.cartItems[index];
                        return Card(
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                item.product.imageUrl,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    Icon(Icons.error, size: 40),
                              ),
                            ),
                            title: Text(
                              item.product.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '\$${item.product.price.toStringAsFixed(2)} each',
                                  style: TextStyle(color: Colors.green),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.remove_circle_outline,
                                        size: 20,
                                      ),

                                      onPressed: () =>
                                          _updateQuantity(item, false),
                                    ),
                                    Text('${item.quantity}'),
                                    IconButton(
                                      icon: Icon(
                                        Icons.add_circle_outline,
                                        size: 20,
                                      ),
                                      onPressed: () =>
                                          _updateQuantity(item, true),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _removeItem(item),
                              tooltip: 'Remove Item',
                            ),
                          ),
                        );
                      },
                    ),
            ),
      bottomNavigationBar: Obx(
        () => cartController.cartItems.isEmpty
            ? SizedBox.shrink()
            : Container(
                padding: EdgeInsets.all(16.0),
                color: Colors.grey[100],
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${cartController.totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Placeholder action (replace with desired functionality)
                        Get.snackbar(
                          'Checkout',
                          'Proceeding to checkout (implement your checkout flow)',
                        );
                        // Optionally, navigate to another screen, e.g., Get.toNamed('/home');
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Proceed to Checkout',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
