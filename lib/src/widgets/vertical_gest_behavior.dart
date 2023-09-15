import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:story_creator_plus/src/controller/editing_controller.dart';
import 'package:story_creator_plus/src/enums/editing_mode.dart';

GestureDetector verticalGestureBehavior({required Widget child}) {
  final EditingController editingController = Get.find<EditingController>();
  late DragStartDetails? startVerticalDragDetails;
  late DragUpdateDetails? updateVerticalDragDetails;
  return GestureDetector(
      onVerticalDragStart: (dragDetails) {
        startVerticalDragDetails = dragDetails;
      },
      onVerticalDragUpdate: (dragDetails) {
        updateVerticalDragDetails = dragDetails;
      },
      onVerticalDragEnd: (endDetails) {
        double dy = updateVerticalDragDetails!.globalPosition.dy -
            startVerticalDragDetails!.globalPosition.dy;

        if (dy < 0) {
          editingController.editingModeSelected = EDITINGMODE.FILTERS;
        } else {
          editingController.editingModeSelected = EDITINGMODE.NONE;
        }
      },
      child: child);
}
