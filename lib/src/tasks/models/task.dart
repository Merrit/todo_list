import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final bool completed;

  /// Flag indicating whether the task has been deleted.
  ///
  /// The default is False.
  final bool deleted;

  /// Due date of the task (as a RFC 3339 timestamp).
  ///
  /// Optional. The due date only records date information; the time portion of
  /// the timestamp is discarded when setting the due date. It isn't possible to
  /// read or write the time that a task is due via the API.
  final String? due;

  /// ETag of the resource.
  final String etag;

  /// Flag indicating whether the task is hidden.
  ///
  /// This is the case if the task had been marked completed when the task list
  /// was last cleared. The default is False. This field is read-only.
  final bool hidden;

  /// Task identifier.
  final String id;

  /// Notes describing the task.
  ///
  /// Optional.
  final String? notes;

  /// Parent task identifier.
  ///
  /// This field is omitted if it is a top-level task. This field is read-only.
  /// Use the "move" method to move the task under a different parent or to the
  /// top level.
  final String? parent;

  /// String indicating the position of the task among its sibling tasks under
  /// the same parent task or at the top level.
  ///
  /// If this string is greater than another task's corresponding position
  /// string according to lexicographical ordering, the task is positioned after
  /// the other task under the same parent task (or at the top level). This
  /// field is read-only. Use the "move" method to move the task to another
  /// position.
  final String position;

  /// Status of the task.
  ///
  /// This is either "needsAction" or "completed".
  final String status;

  /// Title of the task.
  final String title;

  /// Last modification time of the task (as a RFC 3339 timestamp).
  final String updated;

  Task({
    required this.completed,
    required this.deleted,
    required this.due,
    required this.etag,
    required this.hidden,
    required this.id,
    required this.notes,
    required this.parent,
    required this.position,
    required this.status,
    required this.title,
    required this.updated,
  });

  @override
  List<Object?> get props {
    return [
      completed,
      deleted,
      due,
      etag,
      hidden,
      id,
      notes,
      parent,
      position,
      status,
      title,
      updated,
    ];
  }

  Task copyWith({
    bool? completed,
    bool? deleted,
    String? due,
    String? etag,
    bool? hidden,
    String? id,
    String? notes,
    String? parent,
    String? position,
    String? status,
    String? title,
    String? updated,
  }) {
    return Task(
      completed: completed ?? this.completed,
      deleted: deleted ?? this.deleted,
      due: due ?? this.due,
      etag: etag ?? this.etag,
      hidden: hidden ?? this.hidden,
      id: id ?? this.id,
      notes: notes ?? this.notes,
      parent: parent ?? this.parent,
      position: position ?? this.position,
      status: status ?? this.status,
      title: title ?? this.title,
      updated: updated ?? this.updated,
    );
  }
}
