import 'package:googleapis/tasks/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart';

import 'models/models.dart' as models;

class GoogleTasks {
  final TasksApi _api;
  final Client _client;

  GoogleTasks._(this._api, this._client) {
    getAll();
  }

  factory GoogleTasks({
    required ClientId clientId,
    required AccessCredentials credentials,
  }) {
    final client = autoRefreshingClient(
      clientId,
      credentials,
      Client(),
    );

    return GoogleTasks._(TasksApi(client), client);
  }

  Future<List<models.TaskList>> getAll() async {
    final taskListsResource = _api.tasklists;
    final apiTaskLists = await taskListsResource.list();

    final taskLists = <models.TaskList>[];
    for (var apiTaskList in apiTaskLists.items!) {
      taskLists.add(await apiTaskList.toModel(_api));
    }

    return taskLists;
  }
}

extension on TaskList {
  Future<models.TaskList> toModel(TasksApi api) async {
    final apiTasks = await api.tasks.list(
      id!,
      showCompleted: true,
      showHidden: true,
    );

    return models.TaskList(
      id: id!,
      items: apiTasks.items!.map((e) => e.toModel()).toList(),
      title: title!,
      updated: updated!,
    );
  }
}

extension on Task {
  models.Task toModel() => models.Task(
        completed: (completed == null) ? false : true,
        deleted: (deleted == null) ? false : true,
        due: due,
        etag: etag!,
        hidden: (hidden == null) ? false : true,
        id: id!,
        notes: notes,
        parent: parent,
        position: position!,
        status: status!,
        title: title!,
        updated: updated!,
      );
}
