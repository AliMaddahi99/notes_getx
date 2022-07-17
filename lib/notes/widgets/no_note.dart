import 'package:flutter/material.dart';

class NoNote extends StatelessWidget {
  const NoNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Icon(
              Icons.note_alt_rounded,
              size: 56.0,
              color: Colors.amber.shade200,
            ),
          ),
          const Text(
            "No notes here yet",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
