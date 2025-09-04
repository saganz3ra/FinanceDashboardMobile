import 'package:flutter/material.dart';
import '../../constants/sizes.dart';

class FinanceInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final String semanticsLabel;

  const FinanceInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: semanticsLabel,
      child: Card(
        elevation: 2,
        child: ListTile(
          leading: Icon(icon, color: iconColor, size: AppSizes.iconSize),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }
}
