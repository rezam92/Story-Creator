import 'package:flutter/material.dart';


buildTextBtn({required String text, Function? onTap, required ThemeData theme}) => TextButton(
    onPressed: onTap as void Function(),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.secondary),
        borderRadius: BorderRadius.circular(10),
      ),
        child: Text(text, style: theme.textTheme.titleMedium
        )
    )
);

doneBtn({Function? onTap, required ThemeData theme})=>
    buildTextBtn(text: "Done", theme: theme, onTap: onTap);
