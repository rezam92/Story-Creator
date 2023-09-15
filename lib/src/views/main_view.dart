import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hsv_color_pickers/hsv_color_pickers.dart';
import 'package:story_creator_plus/src/controller/editing_controller.dart';
import 'package:story_creator_plus/src/enums/editing_mode.dart';
import 'package:story_creator_plus/src/views/basic_view.dart';
import 'package:story_creator_plus/src/views/paint_view.dart';
import 'package:story_creator_plus/src/views/text_view.dart';
import 'package:story_creator_plus/src/helper/background_image.dart';


class MainControllerView extends StatefulWidget {
  final File file;
  const MainControllerView({super.key, required this.file});

  @override
  State<MainControllerView> createState() => _MainControllerViewState();
}

class _MainControllerViewState extends State<MainControllerView> {
  final EditingController controller = Get.put(EditingController());
  HueController huecontroller = HueController(HSVColor.fromColor(Colors.purple));

  final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Exit"),
              content: const Text("Are you sure you want to exit?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No"),
                ),
                TextButton(
                  onPressed: () {
                    Get.deleteAll();
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text("Yes"),
                ),
              ],
            );
          },
        );
        return false;
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Obx(
              () => Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                                  Center(
                                      child: BackgroundImage(
                                          context: context, file: widget.file)),

                              controller.editingModeSelected ==
                                      EDITINGMODE.DRAWING
                                  ? const PaintView(shouldShowControls: true)
                                  : controller.editingModeSelected ==
                                          EDITINGMODE.TEXT
                                      ? const TextView()
                                      : BasicView(file: widget.file)
                            ],
                          ),
                        )
                      ],
                    ),
            )),
      ),
    );
  }
}
