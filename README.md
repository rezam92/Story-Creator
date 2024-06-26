# Story creator
### Better version of [Whatsapp Story Editor](https://pub.dev/packages/story_creator_plus)

[![pub package](https://img.shields.io/pub/v/story_creator_plus.svg)](https://pub.dev/packages/story_creator_plus)
## Flutter package to create and edit stories like Whatsapp, Facebook, Instagram and Snapchat.

## Features
- [x] Add image from gallery
- [ ] Add image from camera(Soon)
- [x] Add text
- [x] Add emojis
- [x] Add stickers
- [x] Paint on image
- [x] Crop image
- [x] Rotate image
- [x] Scale text,stickers and emojis
- [x] Move stickers,emojis and text
- [x] Change text color
- [ ] Change text font(Soon)
- [ ] Change text size(Soon)

## How to Use
To use story_creator_plus, follow the following steps:

### Step1: Adding plugin dependency
add the plugin to your pubspec.yaml file:

```yaml
story_creator_plus: [latest_version]
```

### Step2: Importing the package.
import the plugin in [your_file].dart

```dart
import 'package:story_creator_plus/story_creator.dart';
```

```dart
 Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StoryCreator()),
);
```
this opens the image_picker which picks story image

this returns an Object containing the edited photo and caption as Future<WhatsappStoryEditorResult> as:

```dart
  Navigator.push(
                context,
                MaterialPageRoute(
                      builder: (context) => const StoryCreator()),
                ).then((result) {
                  if (result != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SavedImageView(
                                image: result.image,
                                caption: result.caption,
                              )),
                    );
                }
                });
);
```

Note that the result could be null if the user doesn't makes any edit on the photo and leaves. [SavedImageView](https://pub.dev/packages/story_creator_plus/example/saved_image_view.dart) is the page where you could show the edited photo and caption. You may change as you need it to be.


### Example
Please refer to the example file for detailed usage and example [here](https://pub.dev/packages/story_creator_plus/example)

## Example Images:
 
<img src="https://i.imgur.com/oXEBt40.jpg" width="160" /> 
<img src="https://i.imgur.com/n1y6dXu.jpeg" width="160" /> 
<img src="https://i.imgur.com/XJBtqff.jpg" width="160" />
 

# Credits
Whatsapp_story_editor is Created by [Javeria Iffat](https://www.linkedin.com/in/javeria-iffat/)
Edited and modified by [Ritom Ghosh](https://twitter.com/mister_ritom)

## TODOS
There are some major bugs while scaling, so they need to be fixed
The ui needs more changes, so it doesn't look like just a copy of whatsapp
Find a way to make it use less ram and make it faster.

## Contributions
Contributions are welcome and appreciated. Open an issue first if you want to make major changes.

THANK YOU!