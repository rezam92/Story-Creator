import 'package:flutter/material.dart';

buildIcon({required IconData icon, Function()? onTap, required ThemeData theme}) =>
    CircleAvatar(
      backgroundColor: theme.colorScheme.secondary.withOpacity(0.3),
      radius: 20,
      child: IconButton(
        onPressed: () {
          if (onTap != null) {
            onTap();
          }
        },
        icon: Icon(icon, color: theme.colorScheme.inverseSurface, size: 24),
      ),
);
