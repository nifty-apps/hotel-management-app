import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  final void Function()? onPressed;
  const SearchButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        // minimumSize: Size(60, 50),
        fixedSize: Size(200, 50),
        foregroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      onPressed: () {},
      icon: Icon(Icons.search, color: Colors.white),
      label: Text(
        'Search',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
