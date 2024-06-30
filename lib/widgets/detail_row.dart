import 'package:flutter/material.dart';

class DetailRow extends StatelessWidget {
  final String title;
  final String details;
  const DetailRow({super.key,required this.title,required this.details});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [ Text(title), Text(details)],
    );
  }
}
