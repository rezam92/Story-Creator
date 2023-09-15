import 'package:flutter/material.dart';
import 'package:story_creator_plus/src/widgets/icon_widget.dart';

undo({Function? onTap, required ThemeData theme}) =>
    buildIcon(icon: Icons.undo, theme: theme, onTap: (){
      if(onTap != null){
        onTap();
      }
    });
