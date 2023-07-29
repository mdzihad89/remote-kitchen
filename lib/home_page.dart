import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_kitchen/cart_page.dart';
import 'food_item.dart';
import 'food_model.dart';
import 'food_provider.dart';
import 'package:badges/badges.dart' as badges;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

@override
  void initState() {
  Provider.of<FoodProvider>(context,listen: false).fetchFoodData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final foodProvider = Provider.of<FoodProvider>(context);

      return Scaffold(
        appBar: AppBar(
          title: const Text('Food List'),
          actions:  [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(),));
                },
                child: badges.Badge(
                  badgeContent: Text( foodProvider.cartItems.length.toString(),style: TextStyle(color: Colors.white),),
                  child: Icon(Icons.shopping_cart,),
                ),
              )
            )
          ],
        ),
        body: foodProvider.isLoading?Center(child: CircularProgressIndicator(),): GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: foodProvider.foodList.length,
          itemBuilder: (context, index) {
            Food food = foodProvider.foodList[index];
            return FoodItem(
              name: food.name,
              description: food.description,
              price: food.price,
              imageUrl: food.imageUrl,
              onAddToCart: () {foodProvider.addToCart(food);},
            );
          },
        )
      );
    }
  }

