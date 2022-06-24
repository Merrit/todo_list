import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../tasks.dart';

class TasksPage extends StatelessWidget {
  static const routeName = '/';

  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Scaffold(
            body: Row(
              children: [
                BlocBuilder<TasksCubit, TasksState>(
                  builder: (context, state) {
                    // Currently a ListView because NavigationRail doesn't allow
                    // having fewer than 2 items.
                    // https://github.com/flutter/flutter/pull/104914
                    return SizedBox(
                      width: 250,
                      child: Card(
                        child: ListView(
                          children: state.taskLists
                              .map((e) => ListTile(
                                    title: Text(e.title),
                                    selected: (state.activeList == e),
                                    onTap: () => tasksCubit.setActiveList(e.id),
                                  ))
                              .toList(),
                        ),
                      ),
                    );
                  },
                ),
                const TaskListView(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TaskListView extends StatelessWidget {
  const TaskListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        if (state.activeList == null) return const SizedBox();

        return SizedBox(
          width: 500,
          child: ListView(
            children: state.activeList!.items
                .map((e) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(e.title),
                      ),
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}
