import 'dart:io';
import 'package:story_creator_plus/src/controller/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:story_creator_plus/src/constants.dart';
import 'package:story_creator_plus/src/controller/editing_controller.dart';
import 'package:story_creator_plus/src/enums/editing_mode.dart'; 
import 'package:story_creator_plus/src/views/graphic_view.dart';
import 'package:story_creator_plus/src/views/crop_view.dart';
import 'package:story_creator_plus/src/widgets/icon_widget.dart';
import 'package:story_creator_plus/src/widgets/undo.dart';

/// The top editing bar containing crop, graphics (Stickers/Emojie), text and Painting
editingBar({required BuildContext context, required File file}) {
  return Container(
    height:
        MediaQuery.of(context).size.height * Constants.editingBarHeightRatio,
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      children: [
        buildIcon(
            theme: Theme.of(context),
            onTap: () async {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            icon: Icons.close),
        const SizedBox(width: 4.0),
        Get.find<EditingController>().editableItemInfo.isNotEmpty
            ? undo(onTap: () {
          Get.find<EditingController>().editableItemInfo.removeLast();
        }, theme: Theme.of(context))
            : const SizedBox.shrink(),
        const Spacer(),
        buildIcon(
            theme: Theme.of(context),
            icon: Icons.crop,
            onTap: () {
              takeScreenshotAndReturnMemoryImage(getScreenshotKey)
                  .then((MemoryImage imageData) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CropView(image: file)
                    ));
              });
            }),
        const SizedBox(width: 4.0),
        const VisibilityButton(),
      ],
    ),
  );
}

class VisibilityButton extends StatefulWidget {
  const VisibilityButton({Key? key}) : super(key: key);

  @override
  State<VisibilityButton> createState() => _VisibilityButtonState();
}
class _VisibilityButtonState extends State<VisibilityButton> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
        replacement: buildIconButton(),
        child: Row(
          children: [
            buildIcon(
                theme: Theme.of(context),
                icon: Icons.emoji_emotions_outlined,
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const GraphicView()))),
            const SizedBox(width: 4.0),
            buildIcon(
                theme: Theme.of(context),
                icon: Icons.title,
                onTap: () => Get.find<EditingController>().editingModeSelected =
                    EDITINGMODE.TEXT),
            const SizedBox(width: 4.0),
            buildIcon(
                theme: Theme.of(context),
                icon: Icons.edit,
                onTap: () {
                  Get.find<EditingController>().editingModeSelected =
                      EDITINGMODE.DRAWING;
                }),
            const SizedBox(width: 12.0),
            buildIconButton(),
          ],
        )
    );
  }

  Widget buildIconButton() {
    return IconButton(
        onPressed: (){
          setState(() {
            isVisible = !isVisible;
          });
        }, icon:
        Icon(isVisible? Icons.arrow_circle_right :
        Icons.arrow_circle_left,
            color: Theme.of(context).colorScheme.surface, size: 32.0
        )
    );

  }

}
