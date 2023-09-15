import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:story_creator_plus/src/constants.dart';
import 'package:story_creator_plus/src/controller/editing_controller.dart';

import '../../../story_creator.dart';
import '../../controller/utils.dart';

//Allows to add caption on the image
Widget captionBar({required BuildContext context}) {
  final EditingController controller = Get.find<EditingController>();
  return Container(
    height:
        MediaQuery.of(context).size.height * Constants.captionBarHeightRatio*0.6,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
    ),
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
        tooltip: "Create story",
        onPressed: () async {
          final imageData = await takeScreenshotAndReturnMemoryImage(getScreenshotKey);
          if (context.mounted){
            Navigator.pop(context);
            Navigator.pop(
                context,
                StoryCreatorResult(
                    image: imageData,
                    caption: Get.find<EditingController>().caption
                ),
            );
            Get.deleteAll();
          }
        },
        icon: Icon(Icons.done, color: Theme.of(context).colorScheme.inverseSurface),
      )
    ]),
  );
}
