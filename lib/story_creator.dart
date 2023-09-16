library story_creator_plus;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker_plus/image_picker_plus.dart';
import 'package:story_creator_plus/src/controller/editing_binding.dart';
import 'package:story_creator_plus/src/views/main_view.dart';

///To encapsulate the result of editing a WhatsApp story.
///The image property contains the edited image,
///and the caption property contains the caption (if any) that was added to the image.
class StoryCreatorResult {
  MemoryImage image;
  String? caption;
  StoryCreatorResult({required this.image, this.caption});
}

///Allows users to edit a WhatsApp story by adding captions and stickers to an image.
class StoryCreator extends StatefulWidget {
  const StoryCreator({Key? key}) : super(key: key);

  @override
  State<StoryCreator> createState() => _StoryCreatorState();
}

class _StoryCreatorState extends State<StoryCreator> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ImagePickerPlus picker = ImagePickerPlus(context);

      SelectedImagesDetails? details =
      await picker.pickImage(
          source: ImageSource.gallery,
        galleryDisplaySettings: GalleryDisplaySettings(
          appTheme: AppTheme(
            primaryColor: Theme.of(context).colorScheme.surface,
            focusColor: Theme.of(context).colorScheme.inverseSurface,
            shimmerHighlightColor: Theme.of(context).colorScheme.primary,
            shimmerBaseColor: Theme.of(context).colorScheme.secondary,
          )
        ),
      );
      if (details == null || details.selectedFiles.isEmpty) return;
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainControllerView(
              file: details.selectedFiles[0].selectedFile,
            ),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: EditingBinding(),
      debugShowCheckedModeBanner: false,
      home: TextButton(onPressed: (){
        Navigator.pop(context);//Used to go back if WillPopScope doesn't work.
      },child: const Text("Go back"),)
    );
  }
}
