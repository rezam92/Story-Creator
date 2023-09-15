import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:story_creator_plus/src/controller/editing_controller.dart';
import 'package:story_creator_plus/src/widgets/bars/caption_bar.dart';
import 'package:story_creator_plus/src/widgets/bars/deletion_bar.dart';
import 'package:story_creator_plus/src/widgets/bars/editing_bar.dart';

/// the basic skeleton of all editing bars
class BasicView extends StatelessWidget {
  final File file;
  const BasicView({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Get.find<EditingController>().isDeletionEligible
              ? deletionBar(context: context)
              : editingBar(file: file, context: context),
        ),
        const Spacer(),
        captionBar(context: context),
      ],
    );
  }
}
