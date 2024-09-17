import 'package:easy_localization/easy_localization.dart';
import 'package:firesafe_vnex/components/resources/resources.dart';
import 'package:firesafe_vnex/components/widgets/image.dart';
import 'package:firesafe_vnex/components/widgets/progress_indicator.dart';
import 'package:firesafe_vnex/components/widgets/text_field.dart';
import 'package:firesafe_vnex/routes/app_routes.dart';
import 'package:firesafe_vnex/utils/extensions/scope.ext.dart';
import 'package:firesafe_vnex/utils/extensions/state.ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import 'sign_in.cubit.dart';
import 'sign_in.state.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _LoginPageSate();
}

class _LoginPageSate extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool visiblePassword = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (BuildContext context, state) {
        switch (state.runtimeType) {
          case SignedInState:
            context.goNamed(routes.home);
            break;
          case SignInError:
            Fluttertoast.showToast(
              msg: R.string.signInScreen.invalidCredentials.tr(),
              toastLength: Toast.LENGTH_LONG,
            );
            break;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: buildAppbar(),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildForms(),
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: buildButtons(state),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Divider(
                      color: R.color.mainColor.withOpacity(0.25),
                    ),
                  ),
                  buildExternals(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      title: Text(
        R.string.signInScreen.signIn,
      ).tr(),
    );
  }

  Widget buildForms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(R.string.signInScreen.enterEmail).tr(),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 4,
            bottom: 16,
          ),
          child: FSTextField(
            controller: emailController,
            hint: R.string.signInScreen.email.tr(),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onChanged: (value) => setState(() {}),
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'\s')),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(R.string.signInScreen.enterPassword).tr(),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 4,
          ),
          child: FSTextField(
            controller: passwordController,
            hint: R.string.signInScreen.password.tr(),
            suffix: FSImage.asset(
              imageResource: visiblePassword ? R.image.vector.visibilityOff : R.image.vector.visibility,
            ),
            onSuffixTap: () {
              setState(() {
                visiblePassword = !visiblePassword;
              });
            },
            obscureText: !visiblePassword,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            onSubmitted: (value) {
              if (validate()) {
                onSignIn();
              }
            },
            onChanged: (value) => setState(() {}),
          ),
        ),
      ],
    );
  }

  Widget buildButtons(SignInState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (state is SigningInState)
          FilledButton(
            onPressed: null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FSProgressIndicator(),
                const SizedBox(width: 8),
                Text(R.string.signInScreen.signingIn).tr(),
              ],
            ),
          )
        else
          FilledButton(
            onPressed: validate()
                ? () {
                    onSignIn();
                  }
                : null,
            child: Text(R.string.signInScreen.signIn).tr(),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: GestureDetector(
            onTap: () {
              // TODO: Forgot password
            },
            child: Text(
              R.string.signInScreen.forgotPassword,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
              textAlign: TextAlign.end,
            ).tr(),
          ),
        ),
        FilledButton.tonal(
          onPressed: () {
            context.pushNamed(routes.signUp);
          },
          style: ButtonStyle(
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            backgroundColor: MaterialStateProperty.all(R.color.secondaryColor.withOpacity(0.2)),
            foregroundColor: MaterialStateProperty.all(R.color.secondaryColor),
            overlayColor: MaterialStateProperty.all(R.color.secondaryColor.withOpacity(0.2)),
          ),
          child: Text(R.string.signInScreen.signUp).tr(),
        ),
      ],
    );
  }

  Widget buildExternals() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(R.string.signInScreen.continueWith).tr(),
        ),
        FilledButton.tonal(
          onPressed: () {
            getCubit<SignInCubit>().signInWithGoogle();
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all(const CircleBorder()),
          ),
          child: FSImage.asset(imageResource: R.image.vector.google),
        ),
      ],
    );
  }

  bool validate() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      return false;
    }
    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text)) {
      return false;
    }
    if (!passwordController.text.let((it) {
      if (it.length < 8) {
        return false;
      }
      return true;
    })) {
      return false;
    }
    return true;
  }

  void onSignIn() {
    getCubit<SignInCubit>().signIn(emailController.text, passwordController.text);
  }
}
