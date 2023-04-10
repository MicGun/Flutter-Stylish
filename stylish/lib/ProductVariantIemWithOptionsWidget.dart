import 'package:flutter/material.dart';

class ProductVariantIemWithOptionsWidget extends StatelessWidget {
  const ProductVariantIemWithOptionsWidget({
    super.key, 
    required this.child,
    required this.title,
    });

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const VerticalDivider(
              width: 16,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
