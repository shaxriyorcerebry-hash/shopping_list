import 'package:flutter/material.dart';
import 'package:shopping_list/data/dummy_items.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceryProvider extends ChangeNotifier {
  final List<GroceryItem> _items = [...groceryItems];

  List<GroceryItem> get items => List.unmodifiable(_items);

  void addItem(String name, int quantity, Category category) {
    final newItem = GroceryItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      quantity: quantity,
      category: category,
    );
    _items.add(newItem);
    notifyListeners();
  }

  void removeItem(GroceryItem item) {
    _items.remove(item);
    notifyListeners();
  }
}
