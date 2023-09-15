import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:story_creator_plus/src/controller/editing_controller.dart';
import 'package:story_creator_plus/src/enums/editable_item_type.dart';
import 'package:story_creator_plus/src/models/sticker_data.dart';
import 'package:story_creator_plus/src/models/graphic_info.dart';
import 'package:story_creator_plus/src/widgets/circle_widget.dart';
import 'package:story_creator_plus/src/widgets/icon_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Allows to add Graphic (Stickers/Emojie)
class GraphicView extends StatefulWidget {
  const GraphicView({Key? key}) : super(key: key);

  @override
  State<GraphicView> createState() => _GraphicViewState();
}

class _GraphicViewState extends State<GraphicView> {
  late StickerData stickerData;
  bool isStickersLoading = true;
  bool isSearchSelected = false;
  int switchSelected = 0;
  final EditingController editingController = Get.find<EditingController>();

  _loadStickers() async {
    var data = await rootBundle.loadString(
        "packages/story_creator_plus/assets/stickers/sticker_packs.json");
    stickerData = StickerData.fromJson(jsonDecode(data.toString()));
    setState(() {
      isStickersLoading = false;
    });
  }

  @override
  void initState() {
    _loadStickers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 18.0),
            _topBar(context),
            const SizedBox(height: 10.0),
            isSearchSelected ? _searchBar() : _switchBar(),
            const SizedBox(height: 35),
            switchSelected == 0
                ? const Text("Shapes",
                    style: TextStyle(color: Colors.grey, fontSize: 13))
                : const SizedBox(),
            switchSelected == 0
                ? SizedBox(
                    height: 200,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: EditableItem.getSvgShapes().length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          alignment: (index + 1) % 4 == 0
                              ? Alignment.centerRight
                              : index % 4 == 0
                                  ? Alignment.centerLeft
                                  : Alignment.center,
                          margin: (index + 1) % 4 == 0
                              ? const EdgeInsets.only(left: 14)
                              : index % 4 == 0
                                  ? const EdgeInsets.only(right: 14)
                                  : const EdgeInsets.only(
                                      right: 8, left: 8),
                          child: GestureDetector(
                              onTap: () {
                                editingController.addToEditableItemList(
                                    EditableItem(
                                        editableItemType:
                                            EditableItemType.shape,
                                        shapeSvg:
                                            EditableItem.changeSvgColor(
                                                EditableItem.getSvgShapes()
                                                    .elementAt(index),
                                                editingController
                                                    .hueController.value
                                                    .toColor()),
                                        matrixInfo: Matrix4.identity()));

                                Navigator.pop(context);
                              },
                              child: Container(
                                color: Colors.transparent,
                                height: 65,
                                width: 65,
                                child: SvgPicture.string(
                                  EditableItem.changeSvgColor(
                                      EditableItem.getSvgShapes()
                                          .elementAt(index),
                                      editingController.hueController.value
                                          .toColor()),
                                ),
                              )),
                        );
                      },
                    ),
                  )
                : const SizedBox.shrink(),
            Text(switchSelected == 0 ? "Stickers" : "Smileys & People",
                style: const TextStyle(color: Colors.grey, fontSize: 13)),
            isStickersLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: switchSelected == 0
                          ? stickerData.stickerPacks!.first.stickers!
                              .length //stickers
                          : 88, //out of 300+ available emojies in asset
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          alignment: (index + 1) % 4 == 0
                              ? Alignment.centerRight
                              : index % 4 == 0
                                  ? Alignment.centerLeft
                                  : Alignment.center,
                          margin: (index + 1) % 4 == 0
                              ? const EdgeInsets.only(left: 14)
                              : index % 4 == 0
                                  ? const EdgeInsets.only(right: 14)
                                  : const EdgeInsets.only(
                                      right: 8, left: 8),
                          child: switchSelected == 0
                              ? GestureDetector(
                                  onTap: () {
                                    editingController.addToEditableItemList(
                                        EditableItem(
                                            editableItemType:
                                                EditableItemType.graphic,
                                            graphicImagePath:
                                                "packages/story_creator_plus/assets/stickers/2/${stickerData.stickerPacks!.first.stickers![index].imageFile}",
                                            matrixInfo:
                                                Matrix4.identity()));

                                    Navigator.pop(context);
                                  },
                                  child: SizedBox(
                                    height: 65,
                                    width: 65,
                                    child: Image.asset(
                                      "packages/story_creator_plus/assets/stickers/2/${stickerData.stickerPacks!.first.stickers![index].imageFile}",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    editingController.addToEditableItemList(
                                        EditableItem(
                                            editableItemType:
                                                EditableItemType.graphic,
                                            graphicImagePath:
                                                "packages/story_creator_plus/assets/emojies/e15${index + 11}.png",
                                            matrixInfo:
                                                Matrix4.identity()));
                                    Navigator.pop(context);
                                  },
                                  child: SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Image.asset(
                                      "packages/story_creator_plus/assets/emojies/e15${index + 11}.png",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                        );
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }

  _topBar(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      buildIcon(
          icon: Icons.arrow_back,
          onTap: () => Navigator.pop(context),
          theme: Theme.of(context),
      ),
      Obx(() => circleWidget(
          radius: 40,
          bgColor: Get.find<EditingController>().hueController.value.toColor(),
          child: Icon(
            Icons.emoji_emotions_outlined,
            color: Theme.of(context).colorScheme.surface,
          )))
    ]);
  }

  _searchBar() {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        style: Theme.of(context).textTheme.titleMedium,
        decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isSearchSelected = false;
                  });
                },
                child: Icon(Icons.close, color: Theme.of(context).colorScheme.background)),
            prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.background),
            labelText: 'Search',
        ),
      ),
    );
  }

  _switchBar() => Row(children: [
        buildIcon(
            icon: Icons.search,
            onTap: () => setState(() => isSearchSelected = true),
          theme: Theme.of(context),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => setState(() => switchSelected = 0),
          child: Container(
              height: 35,
              width: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: switchSelected == 0
                      ? Colors.white.withOpacity(0.9)
                      : Colors.white.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Text(
                "Stickers",
                style: TextStyle(
                    color: switchSelected == 0
                        ? Colors.black.withOpacity(0.8)
                        : Colors.white.withOpacity(0.7),
                    fontSize: 15),
              )),
        ),
        GestureDetector(
          onTap: () => setState(() => switchSelected = 1),
          child: Container(
            height: 35,
            width: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: switchSelected == 1
                    ? Colors.white.withOpacity(0.9)
                    : Colors.white.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Text(
              "Emoji",
              style: TextStyle(
                  color: switchSelected == 1
                      ? Colors.black.withOpacity(0.7)
                      : Colors.white.withOpacity(0.8),
                  fontSize: 15),
            ),
          ),
        ),
        const Spacer(),
      ]);
}
