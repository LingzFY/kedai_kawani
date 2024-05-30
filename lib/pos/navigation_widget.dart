import 'package:flutter/material.dart';

class NavigationWidget extends StatelessWidget {
  const NavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            height: 48.0,
            width: 48.0,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16.0),
              image: const DecorationImage(
                image: AssetImage('assets/images/logo.png'),
              ),
            ),
          ),
          const SizedBox(width: 32.0),
          IconButton(
            iconSize: 24.0,
            onPressed: () {},
            icon: const Icon(
              Icons.pending_actions_outlined,
              color: Colors.grey,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 32.0),
          IconButton(
            iconSize: 24.0,
            onPressed: () {},
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
