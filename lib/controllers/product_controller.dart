import 'package:get/get.dart';
import 'package:storeapp/models/product_model.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() {
    // Mock data or fetch from Firebase/API
    products.addAll([
      Product(
        id: '1',
        name: 'Laptop',
        description: 'High-performance laptop',
        price: 999.99,
        imageUrl: 'https://example.com/laptop.jpg',
      ),
      Product(
        id: '2',
        name: 'Smartphone',
        description: 'Latest model smartphone',
        price: 599.99,
        imageUrl: 'https://example.com/phone.jpg',
      ),
    ]);
  }
}
