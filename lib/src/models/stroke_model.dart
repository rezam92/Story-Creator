import 'package:perfect_freehand/perfect_freehand.dart';
import 'package:flutter/material.dart';
import 'package:story_creator_plus/src/models/stroke_options_model.dart';

class Stroke {
  final List<Point> points;
  final Color color;
  final StrokeOptions options;
  const Stroke(this.points, this.color, this.options);
}
