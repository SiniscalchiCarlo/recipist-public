import 'package:flutter/material.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final VoidCallback onDelete;

  const ConfirmDeleteDialog({Key? key, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Delete'),
      content: const Text('Are you sure you want to delete this item?'),
      actions: [
        TextButton(
          onPressed: () {
            // Close the dialog without doing anything
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Perform the delete action
            onDelete();
            Navigator.of(context)
                .pop("delete"); // Close the dialog after confirming
          },
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
