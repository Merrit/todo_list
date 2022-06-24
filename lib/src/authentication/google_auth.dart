import 'package:googleapis/tasks/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleAuth {
  final _clientId = ClientId(
    '766300722492-1ojenkugmp1abfqlo2ugesvi39fpqqp6.apps.googleusercontent.com',
    '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',
  );

  final _scopes = [TasksApi.tasksScope];

  Future<AccessCredentials?> login() async {
    AutoRefreshingAuthClient? client;
    try {
      client = await clientViaUserConsent(
        _clientId,
        _scopes,
        launchAuthUrl,
      );
    } catch (e) {
      print('Unable to login: $e');
    }

    return client?.credentials;

    var end;

/*     final tasksApi = TasksApi(client);
    final taskListsResource = tasksApi.tasklists;
    final tasks = tasksApi.tasks;
    final taskLists = await taskListsResource.list();
    var end; */
  }

  Future<void> launchAuthUrl(String url) async {
    final authUrl = Uri.parse(url);
    if (await canLaunchUrl(authUrl)) launchUrl(authUrl);
  }
}
