import 'package:flutter/material.dart';

enum Priority { high, medium, low }

extension PriorityExtension on Priority {
  Color get primary => switch (this) {
    .high => Colors.red,
    .medium => Colors.orange,
    .low => Colors.green,
  };

  Color get secondary => switch (this) {
    .high => const Color(0xFFFEE2E2),
    .medium => const Color(0xFFFEF3C7),
    .low => const Color(0xFFDCFCE7),
  };

  String get title => switch (this) {
    .high => '높음',
    .medium => '중간',
    .low => '낮음',
  };
}
