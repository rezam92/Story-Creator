import 'package:story_creator_plus/src/models/stroke_model.dart';
import 'package:story_creator_plus/src/models/stroke_options_model.dart';

class PaintInfo {
  final List<Stroke> lines;
  final StrokeOptions options;
  PaintInfo({required this.lines, required this.options});
}
