import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/providers/grocery_provider.dart';
import 'package:shopping_list/widgets/new_item.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({super.key});

  void _addItem(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => const NewItem()),
    );
  }

  void _removeItem(BuildContext context, GroceryItem item) {
    context.read<GroceryProvider>().removeItem(item);
  }

  @override
  Widget build(BuildContext context) {
    final items = context.watch<GroceryProvider>().items;

    Widget content = const Center(child: Text('No items added yet.'));

    if (items.isNotEmpty) {
      content = ListView.builder(
        itemCount: items.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(items[index].id),
          onDismissed: (direction) {
            _removeItem(context, items[index]);
          },
          child: ListTile(
            title: Text(items[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: items[index].category.color,
            ),
            trailing: Text(items[index].quantity.toString()),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: () => _addItem(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
