import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'authentication/cubit/authentication_cubit.dart';
import 'authentication/login_page.dart';
import 'constants.dart';
import 'tasks/pages/tasks_page.dart';
import 'tasks/tasks.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        final bool signedIn = state.signedIn;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.system,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                if (!signedIn) return const LoginPage();

                switch (routeSettings.name) {
                  case LoginPage.routeName:
                    return const LoginPage();
                  case TasksPage.routeName:
                  default:
                    return BlocProvider(
                      create: (context) => TasksCubit(
                        GoogleTasks(
                          clientId: GoogleTasksAPI.clientId,
                          credentials: state.accessCredentials!,
                        ),
                      ),
                      lazy: false,
                      child: const TasksPage(),
                    );
                }
              },
            );
          },
        );
      },
    );
  }
}
