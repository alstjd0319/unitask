// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:unitask/core/enum/assignment_status.dart';
import 'package:unitask/core/enum/priority.dart';
import 'package:unitask/core/models/subject.dart';

class Assignment {
  final String id;
  final String subjectId;
  final String title;
  final String? description;
  final DateTime dueDate;
  final Priority priority;
  final AssignmentStatus status;
  final DateTime? completedAt;
  final DateTime? createdAt;
  final DateTime? updateAt;
  //과목
  final Subject? subject;
  Assignment({
    required this.id,
    required this.subjectId,
    required this.title,
    this.description,
    required this.dueDate,
    required this.priority,
    required this.status,
    this.completedAt,
    this.createdAt,
    this.updateAt,
    this.subject,
  });

  Assignment copyWith({
    String? id,
    String? subjectId,
    String? title,
    String? description,
    DateTime? dueDate,
    Priority? priority,
    AssignmentStatus? status,
    DateTime? completedAt,
    DateTime? createdAt,
    DateTime? updateAt,
    Subject? subject,
  }) {
    return Assignment(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
      subject: subject ?? this.subject,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'subjectId': subjectId,
      'title': title,
      'description': description,
      'dueDate': dueDate.millisecondsSinceEpoch,
      'priority': priority.name,
      'status': status.name,
      'completedAt': completedAt?.millisecondsSinceEpoch,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updateAt': updateAt?.millisecondsSinceEpoch,
      'subject': subject?.toMap(),
    };
  }

  factory Assignment.fromMap(Map<String, dynamic> map) {
    return Assignment(
      id: map['id'] as String,
      subjectId: map['subjectId'] as String,
      title: map['title'] as String,
      description: map['description'] != null
          ? map['description'] as String
          : null,
      dueDate: DateTime.parse(map['dueDate']),
      priority: Priority.values.firstWhere(map['priority']),
      status: AssignmentStatus.fromApi(map['status']),
      completedAt: map['completedAt'] != null
          ? DateTime.parse(map['completedAt'])
          : null,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : null,
      updateAt: map['updateAt'] != null
          ? DateTime.parse(map['updateAt'])
          : null,
      subject: map['subject'] != null
          ? Subject.fromMap(map['subject'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Assignment.fromJson(String source) =>
      Assignment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Assignment(id: $id, subjectId: $subjectId, title: $title, description: $description, dueDate: $dueDate, priority: $priority, status: $status, completedAt: $completedAt, createdAt: $createdAt, updateAt: $updateAt, subject: $subject)';
  }

  @override
  bool operator ==(covariant Assignment other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.subjectId == subjectId &&
        other.title == title &&
        other.description == description &&
        other.dueDate == dueDate &&
        other.priority == priority &&
        other.status == status &&
        other.completedAt == completedAt &&
        other.createdAt == createdAt &&
        other.updateAt == updateAt &&
        other.subject == subject;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        subjectId.hashCode ^
        title.hashCode ^
        description.hashCode ^
        dueDate.hashCode ^
        priority.hashCode ^
        status.hashCode ^
        completedAt.hashCode ^
        createdAt.hashCode ^
        updateAt.hashCode ^
        subject.hashCode;
  }
}
