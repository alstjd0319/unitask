import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:unitask/app/theme/preview.dart';
import 'package:unitask/ui/pages/common/subject_label.dart';

@AppThemePreview(group: 'Items', name: 'TaskCard')
Widget preview() {
  return TaskCard(
    onChecked: (value) {},
    onSelected: () {},
    checked: true,
    title: 'Unitask 끝내기',
    date: DateTime.now().copyWith(month: 6, day: 4),
    category: const SubjectLabel(text: 'flutter'),
  );
}

class TaskCard extends StatelessWidget {
  final bool checked;
  final String title;
  final DateTime date;
  final VoidCallback? onSelected;
  final Function(bool? value)? onChecked;
  final Widget category;

  const TaskCard({
    super.key,
    required this.checked,
    required this.title,
    required this.date,
    this.onSelected,
    this.onChecked,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    //TODO: 아이콘 색상 설정은 아래와 같음
    //  =< D-3 : 빨강
    //  =< D-7 : 주황
    // > D-7 : 검정
    final dDay = DateTime.now().difference(date).inDays;

    final dDayColor = switch (dDay) {
      <= 3 => Colors.red,
      <= 7 => Colors.orange,
      _ => Colors.black,
    };
    return Card(
      child: Container(
        height: 120,
        padding: const .symmetric(vertical: 6, horizontal: 12),
        child: Column(
          mainAxisAlignment: .spaceBetween,
          crossAxisAlignment: .stretch,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                //과목 라벨 / 체크박스
                category,
                Checkbox(
                  value: checked,
                  onChanged: onChecked,
                  visualDensity: .compact,
                  checkColor: Colors.blue,
                  fillColor: WidgetStateProperty.resolveWith(
                    (states) => states.contains(WidgetState.selected)
                        ? Colors.blue
                        : const Color(0xFFF3F4F6),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  side: const BorderSide(color: Colors.transparent),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            ),
            Text(
              title,
              overflow: .ellipsis, // ...처리
              maxLines: 1, //몇줄부터 ...처리할것인지
              style: TextStyle(fontSize: 15, fontWeight: .bold),
            ),
            Row(
              spacing: 5,
              children: [
                Icon(LucideIcons.calendarRange, size: 12),
                Text(
                  DateFormat('yyyy.MM.dd').format(date),
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
