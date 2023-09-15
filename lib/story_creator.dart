library whatsapp_story_editor;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker_plus/image_picker_plus.dart';
import 'package:whatsapp_story_editor/src/controller/editing_binding.dart';
import 'package:whatsapp_story_editor/src/views/main_view.dart';

///To encapsulate the result of editing a WhatsApp story.
///The image property contains the edited image,
///and the caption property contains the caption (if any) that was added to the image.
class WhatsappStoryEditorResult {
  MemoryImage image;
  String? caption;
  WhatsappStoryEditorResult({required this.image, this.caption});
}

///Allows users to edit a WhatsApp story by adding captions and stickers to an image.
class WhatsappStoryEditor extends StatefulWidget {
  const WhatsappStoryEditor({Key? key}) : super(key: key);

  @override
  State<WhatsappStoryEditor> createState() => _WhatsappStoryEditorState();
}

class _WhatsappStoryEditorState extends State<WhatsappStoryEditor> {
  @override
  void initState() {
    //Switch to WhatsappCamera
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ImagePickerPlus picker = ImagePickerPlus(context);

      SelectedImagesDetails? details =
      await picker.pickImage(source: ImageSource.gallery);
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
      home: Container(),
    );
  }
}
