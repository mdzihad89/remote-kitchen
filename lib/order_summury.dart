// order_summary_screen.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_kitchen/utils.dart';

import 'cart_model.dart';
import 'food_provider.dart';
import 'home_page.dart';

class OrderSummaryScreen extends StatelessWidget {
  final List<CartItem> cartItems;
  final String name;
  final String phoneNumber;
  final String address;
  final String subtotal_amount;

  OrderSummaryScreen({
    required this.cartItems,
    required this.name,
    required this.phoneNumber,
    required this.address, required this.subtotal_amount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text('Name: $name'),
            SizedBox(height: 10),
            Text('Phone Number: $phoneNumber'),
            SizedBox(height: 10),
            Text('Address: $address'),
            SizedBox(height: 20),
            Text(
              'Ordered Items',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Column(
              children: List.generate(cartItems.length, (index) {
                CartItem cartItem = cartItems[index];
                return ListTile(
                  leading: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: cartItem.imageUrl,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(cartItem.name),
                  subtitle: Text('Quantity: ${cartItem.quantity}'),
                  // Add other details of the ordered food item here as needed
                );
              }),
            ),
            SizedBox(height: 20),
            Text(
              'Total Amount: \$${subtotal_amount}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.sizeOf(context).width, 20),
                backgroundColor: Colors.yellow,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              onPressed: () {
                showSnackbar(context, "Ordered Successfully");
                final foodProvider = Provider.of<FoodProvider>(context, listen: false);
                foodProvider.clearCart();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                      (route) => false, // This removes all routes on top of the home page
                );

              },
              child: Text('Confirm Order'),
            ),
          ],
        ),
      ),
    );
  }


}
