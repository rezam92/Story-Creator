import 'package:example/saved_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:story_creator_plus/story_creator.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  runApp( const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(useMaterial3: true),
        theme: ThemeData.light(useMaterial3: true),
        themeMode: ThemeMode.system,
        home: const StoryApp(),
    );
  }
}

class StoryApp extends StatelessWidget {
  const StoryApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 130,
              height: 50,
              child: TextButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StoryCreator(),
                  ));
                  if (result != null&&context.mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SavedImageView(
                            image: result.image,
                            caption: result.caption,
                          )),
                    );
                  }
                },
                child: const Row(
                  children: [
                    Icon(Icons.image),
                    Text("Create story"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
