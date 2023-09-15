import 'package:flutter/material.dart';
import 'package:whatsapp_story_editor/src/widgets/icon_widget.dart';

undo({Function? onTap, required ThemeData theme}) =>
    buildIcon(icon: Icons.undo, theme: theme, onTap: (){
      if(onTap != null){
        onTap();
      }
    });
