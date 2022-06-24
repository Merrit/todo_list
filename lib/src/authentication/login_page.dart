import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:todo_list/src/authentication/cubit/authentication_cubit.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/login_page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SignInButton(
                  Buttons.GoogleDark,
                  onPressed: () async {
                    await authCubit.login();

                    if (state.signedIn) {
                      print('signed in!');
                    } else {
                      print('sign in failed!');
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
