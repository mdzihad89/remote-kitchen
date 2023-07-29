
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'cart_model.dart';
import 'food_model.dart';

class FoodProvider with ChangeNotifier {
  List<Food> _foodList = [];
  List<CartItem> _cartItems = [];
  bool _isLoading = false;


  List<Food> get foodList => _foodList;
  List<CartItem> get cartItems => _cartItems;
  bool get isLoading => _isLoading;


  Future<void> fetchFoodData( ) async {

    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(Duration(seconds: 3));
      String jsonData = await rootBundle.loadString('assets/dummy_data.json');
      List<dynamic> jsonDataList = jsonDecode(jsonData);
      _foodList = jsonDataList.map((item) => Food.fromJson(item)).toList();
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      print('Error fetching data: $error');
    }
  }
  void addToCart(Food food) {
    // Check if the item is already in the cart
    int existingIndex = _cartItems.indexWhere((item) => item.name == food.name);

    if (existingIndex != -1) {
      // If item already exists, update its quantity
      _cartItems[existingIndex].incrementQuantity();
    } else {
      // If item doesn't exist, add it to the cart
      _cartItems.add(CartItem(
        name: food.name,
        price: food.price,
        imageUrl: food.imageUrl,
      ));
    }
    notifyListeners();
  }


  void removeFromCart(CartItem cartItem) {
    _cartItems.remove(cartItem);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}