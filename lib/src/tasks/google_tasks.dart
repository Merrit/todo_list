import 'package:googleapis/tasks/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart';

import 'models/models.dart' as models;

class GoogleTasks {
  // final clientId = ClientId(
  //   '766300722492-1ojenkugmp1abfqlo2ugesvi39fpqqp6.apps.googleusercontent.com',
  //   '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',
  // );

  // final scopes = [
  //   // 'https://www.googleapis.com/auth/tasks',
  //   TasksApi.tasksScope,
  // ];

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
    // final AutoRefreshingAuthClient client = await clientViaUserConsent(
    //   clientId,
    //   scopes,
    //   userPrompt,
    // );

    // autoRefreshingClient(GoogleTasksAPI.clientId, credentials, baseClient);

    // var end;

    // final tasksApi = TasksApi(_client);
    final taskListsResource = _api.tasklists;
    final apiTaskLists = await taskListsResource.list();

    final taskLists = <models.TaskList>[];
    for (var apiTaskList in apiTaskLists.items!) {
      taskLists.add(await apiTaskList.toModel(_api));
    }

    return taskLists;
    // final tasks = _api.tasks;

    // if (taskLists.items == null) return [];

    // final lists = <models.TaskList>[];

    // for (var taskList in taskLists.items!) {
    //   lists.add(await tasks.list(taskList.id!));
    // }

    var end;
  }
}

Future<String> otherprompt(String thing) async {
  print('thing: $thing');
  var end;
  return '';
}

void userPrompt(String value) {
  print(value);
  var end;
}

extension on TaskList {
  Future<models.TaskList> toModel(TasksApi api) async {
    final apiTasks = await api.tasks.list(id!);

    // final items = apiTasks.items!.map((e) => e.toModel()).toList();

    // final items = <models.Task>[];
    // for (var task in apiTasks.items!) {}

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
