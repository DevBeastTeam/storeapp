import 'package:get/get.dart';
import 'package:storeapp/models/chartmodel.dart';
import 'package:storeapp/models/product_model.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  void addToCart(Product product) {
    var existingItem = cartItems.firstWhereOrNull(
      (item) => item.product.id == product.id,
    );
    if (existingItem != null) {
      existingItem.quantity++;
    } else {
      cartItems.add(CartItem(product: product));
    }
    cartItems.refresh();
  }

  double get totalPrice => cartItems.fold(
    0,
    (sum, item) => sum + item.product.price * item.quantity,
  );
}
