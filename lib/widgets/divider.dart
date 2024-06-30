import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentprovider/provider/theme_provider.dart';

class Kdivider extends StatelessWidget {
  const Kdivider({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    return Divider(
        thickness: 1,
        color: provider.isDarkMode
            ? Colors.grey
            : Color.fromARGB(255, 137, 174, 201));
  }
}
