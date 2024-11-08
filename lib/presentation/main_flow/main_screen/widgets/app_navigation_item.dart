import 'package:flutter/material.dart';

class AppNavigationItem extends StatelessWidget {
  const AppNavigationItem({
    super.key,
    required this.onTap,
    required this.isActive,
    required this.icon,
  });

  final VoidCallback onTap;
  final bool isActive;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(
          16,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFFBEB7EB)
              : const Color(0xFFE8E9EA).withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: icon,
      ),
    );
  }
}
