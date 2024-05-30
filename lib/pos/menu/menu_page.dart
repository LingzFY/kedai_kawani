import 'package:flutter/material.dart';
import 'package:pos_kawani/pos/menu/widgets/category_widget/category_widget.dart';
import 'package:pos_kawani/pos/menu/widgets/product_widget/product_widget.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 48.0,
                  width: 48.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kedai Kawani",
                      style: TextStyle(color: Colors.black, fontSize: 22.0),
                    ),
                    Text(
                      "Tuesday, 28 May 2024",
                      style: TextStyle(color: Colors.grey, fontSize: 14.0),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  height: 48.0,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      "Order List",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Container(
                  height: 48.0,
                  width: 48.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Administrator",
                      style: TextStyle(color: Colors.black, fontSize: 22.0),
                    ),
                    Text(
                      "Administrator",
                      style: TextStyle(color: Colors.grey, fontSize: 14.0),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome to Kedai Kawani",
                  style: TextStyle(color: Colors.black, fontSize: 24.0),
                ),
                Text(
                  "Choose the Category",
                  style: TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            const CategoryWidget(),
            const SizedBox(height: 32.0),
            const Text(
              "All Menu",
              style: TextStyle(color: Colors.black, fontSize: 14.0),
            ),
            const SizedBox(height: 24.0),
            const ProductWidget(),
          ],
        ),
      ),
    );
  }
}
