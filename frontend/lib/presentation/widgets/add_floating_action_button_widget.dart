import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddFloatingActionButton extends StatelessWidget {
  const AddFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.go('/add');
      },
      // icon: const Icon(Icons.add),
      backgroundColor: Colors.blue.shade600,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 8,
      // label: const Text(''),
      child: const Icon(Icons.add),
    );
  }
}
