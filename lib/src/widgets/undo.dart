import 'package:flutter/material.dart';

undo({Function? onTap}) =>
IconButton(
        onPressed: onTap as void Function()?,
        icon: const Icon(
          Icons.undo,
          color: Colors.white,
          size: 28,
        )
);
