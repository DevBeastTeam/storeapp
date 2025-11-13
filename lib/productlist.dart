import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storeapp/controllers/chartcontroller.dart';
import '../controllers/product_controller.dart';

class ProductListScreen extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: Obx(
        () => ListView.builder(
          itemCount: productController.products.length,
          itemBuilder: (context, index) {
            final product = productController.products[index];
            return ListTile(
              leading: Image.network(
                product.imageUrl,
                width: 50,
                height: 50,
                errorBuilder: (_, __, ___) => Icon(Icons.error),
              ),
              title: Text(product.name),
              subtitle: Text('\$${product.price}'),
              trailing: IconButton(
                icon: Icon(Icons.add_shopping_cart),
                onPressed: () {
                  cartController.addToCart(product);
                  Get.snackbar('Added', '${product.name} added to cart');
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
