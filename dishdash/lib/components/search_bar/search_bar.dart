import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget{
    final String hintText;
    final ValueChanged<String>? onChanged;

    const CustomSearchBar({super.key, this.hintText = 'Search Food...', this.onChanged});

    @override
    Widget build(BuildContext context) {
      return TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      );
    }
}
