import 'package:flutter/material.dart';
import 'package:story_creator_plus/src/constants.dart';
import 'package:story_creator_plus/src/widgets/icon_widget.dart';

///allows to delete graphic (Sticker/Emojie) by dragging to top left corner
deletionBar({required BuildContext context}) {
  return Container(
    height:
        MediaQuery.of(context).size.height * Constants.editingBarHeightRatio,
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      children: [
        buildIcon(onTap: () {},
            icon: Icons.delete_outline_rounded,
            theme: Theme.of(context)),
      ],
    ),
  );
}
