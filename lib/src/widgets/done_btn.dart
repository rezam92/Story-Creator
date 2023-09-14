import 'package:flutter/material.dart';

doneBtn({Function? onTap, required ThemeData theme}) => TextButton(
    onPressed: onTap as void Function(),
    child: Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.secondary),
        borderRadius: BorderRadius.circular(10),
      ),
        child: Text('Done', style: theme.textTheme.titleMedium
        )
    )
);
