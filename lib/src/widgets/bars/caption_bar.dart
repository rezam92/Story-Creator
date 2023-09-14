import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_story_editor/src/constants.dart';
import 'package:whatsapp_story_editor/src/controller/editing_controller.dart';

import '../../../whatsapp_story_editor.dart';
import '../../controller/utils.dart';

//Allows to add caption on the image
Container captionBar({required BuildContext context}) {
  final EditingController controller = Get.find<EditingController>();
  return Container(
    height:
        MediaQuery.of(context).size.height * Constants.captionBarHeightRatio*0.6,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        borderRadius: const BorderRadius.all(Radius.circular(24.0))),
    child: Row(children: [
      Obx(() {
        return Expanded(
          child: TextField(
            controller: TextEditingController(text: controller.caption),
            style: Theme.of(context).textTheme.bodyMedium,
            onSubmitted: (value) {
              controller.caption = value;
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              hintText: 'Caption for story',
              hintStyle: (Theme.of(context).textTheme.bodyMedium??const TextStyle()).copyWith(
                color: Theme.of(context).hintColor,
              ),
            ),
          ),
        );
      }),
      const SizedBox(width: 10.0),
      IconButton(
        onPressed: () async {
          takeScreenshotAndReturnMemoryImage(getScreenshotKey)
              .then((imageData) {
            Navigator.pop(context);
            Navigator.pop(
                context,
                WhatsappStoryEditorResult(
                    image: imageData,
                    caption: Get.find<EditingController>().caption));
          });
        },
        icon: Icon(Icons.send, color: Theme.of(context).colorScheme.surface),
      )
    ]),
  );
}
