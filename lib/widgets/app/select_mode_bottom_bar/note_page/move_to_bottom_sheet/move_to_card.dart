import 'dart:async';

import 'package:flutter/material.dart';

class MoveToCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? notesInFolderCount;
  final FutureOr<void> Function()? onTap;

  const MoveToCard({
    super.key,
    required this.icon,
    required this.title,
    this.notesInFolderCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: Colors.amber,
                size: 44,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16.0,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    notesInFolderCount ?? "",
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
