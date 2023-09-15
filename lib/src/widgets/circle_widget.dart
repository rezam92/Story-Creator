import 'package:flutter/material.dart';

circleWidget(
        {double? radius = 50,
        Color? bgColor,
        EdgeInsetsGeometry? padding,
        Function? onTap,
        Widget? child}) =>
    GestureDetector(
      onTap: (() {
        if (onTap != null) onTap();
      }),
      child: Container(
          padding: padding,
          height: radius,
          width: radius,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor ?? Colors.transparent,),
          child: child),
    );
