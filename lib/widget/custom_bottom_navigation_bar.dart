import 'package:flutter/material.dart';
import 'package:ml_product_recommendation/utils/routes.dart';
import 'package:ml_product_recommendation/widget/navigation_bar_item.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key, required this.currentIndex}) : super(key: key);

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFFFFFFFF),
          currentIndex: currentIndex,
          items: navigationBarItem,
          onTap: (int index) {
            if (index != currentIndex) {
              Navigator.pushReplacementNamed(context, Routes.items.keys.toList()[index]);
            }
          },
          selectedLabelStyle: const TextStyle(color: Color(0xFFDB3022)),
          type: BottomNavigationBarType.fixed,
        ));
  }
}
