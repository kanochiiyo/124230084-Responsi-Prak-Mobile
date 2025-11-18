import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  static const _cartKey = 'cart_product_id';

  // Get cart product key
  Future<List<String>> getCartIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_cartKey) ?? [];
  }

  Future<bool> isAdded(String productId) async {
    final ids = await getCartIds();
    return ids.contains(productId);
  }

  Future<void> addToCart(String productId) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> ids = await getCartIds();

    if (ids.contains(productId)) {
      ids.remove(productId);
    } else {
      ids.add(productId);
    }

    await prefs.setStringList(_cartKey, ids);
  }
}
