import 'package:equatable/equatable.dart';

import '../tasks.dart';

class TaskList extends Equatable {
  final String id;

  final List<Task> items;

  final String title;

  /// Last modification time of the task list (as a RFC 3339 timestamp).
  final String updated;

  const TaskList({
    required this.id,
    required this.items,
    required this.title,
    required this.updated,
  });

  @override
  List<Object> get props => [id, items, title, updated];

  TaskList copyWith({
    String? id,
    List<Task>? items,
    String? title,
    String? updated,
  }) {
    return TaskList(
      id: id ?? this.id,
      items: items ?? this.items,
      title: title ?? this.title,
      updated: updated ?? this.updated,
    );
  }
}
