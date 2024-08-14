import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final double rating;

  const RatingWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(5, (index) {
          return Icon(
            index < rating.floor() ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 16,
          );
        }),
        const SizedBox(width: 4),
        Text('(${rating.toStringAsFixed(1)})'),
      ],
    );
  }
}