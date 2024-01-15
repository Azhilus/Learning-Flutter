import 'package:ecomapp/components/my_button.dart';
import 'package:flutter/material.dart';
import '/models/shop.dart';
import 'package:provider/provider.dart';
import '/models/product.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void removeFromCart(BuildContext context, Product product) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("Remove this item from your cart?"),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);

                    context.read<Shop>().removeFromCart(product);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Removed from cart"),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  child: const Text("Remove"),
                )
              ],
            ));
  }

  //user pressed the pay button
  void payButtonPressed(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("Pay for your items?"),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);

                    context.read<Shop>().cart.clear();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Paid"),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  child: const Text("Pay"),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Shop>().cart;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          "Cart",
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Expanded(
            child: cart.isEmpty
                ? const Center(
                    child: Text(
                      "Your cart is empty...",
                    ),
                  )
                : ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final product = cart[index];

                      return ListTile(
                        title: Text(
                          product.name,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                        subtitle: Text(
                          "\$${product.price}",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            removeFromCart(context, product);
                          },
                          icon: Icon(
                            Icons.remove_shopping_cart,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                      );
                    },
                  ),
          ),

          //pay button

          Padding(
            padding: const EdgeInsets.all(50.0),
            child: MyButton(
                onTap: () => payButtonPressed(context), child: Text("Pay Now")),
          ),
        ],
      ),
    );
  }
}
