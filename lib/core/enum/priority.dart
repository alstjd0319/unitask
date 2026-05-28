import 'package:flutter/material.dart';

enum Priority { high, mid, low }

extension PriorityExtension on Priority {
  Color get primary => switch (this) {
    .high => Colors.red,
    .mid => Colors.orange,
    .low => Colors.green,
  };

  Color get secondary => switch (this) {
    .high => const Color(0xFFFEE2E2),
    .mid => const Color(0xFFFEF3C7),
    .low => const Color(0xFFDCFCE7),
  };

  String get title => switch (this) {
    .high => '높음',
    .mid => '중간',
    .low => '낮음',
  };
}
