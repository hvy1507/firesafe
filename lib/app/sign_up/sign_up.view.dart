import 'package:easy_localization/easy_localization.dart';
import 'package:firesafe_vnex/components/resources/resources.dart';
import 'package:firesafe_vnex/components/widgets/back_button.dart';
import 'package:firesafe_vnex/components/widgets/buttons.dart';
import 'package:firesafe_vnex/components/widgets/image.dart';
import 'package:firesafe_vnex/components/widgets/progress_indicator.dart';
import 'package:firesafe_vnex/components/widgets/text_field.dart';
import 'package:firesafe_vnex/routes/app_routes.dart';
import 'package:firesafe_vnex/utils/extensions/state.ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import 'sign_up.cubit.dart';
import 'sign_up.state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  String get name => nameController.text;

  String get email => emailController.text;

  String get password => passwordController.text;

  String get rePassword => rePasswordController.text;

  bool visiblePassword = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case SignedUpState:
            context.goNamed(routes.home);
            break;
          case SignUpErrorState:
            Fluttertoast.showToast(
              msg: (state as SignUpErrorState).error ?? 'Error',
              toastLength: Toast.LENGTH_SHORT,
            );
            break;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: buildAppBar(),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(R.string.signUpScreen.description).tr(),
                ),
                buildForms(state),
                const SizedBox(height: 32),
                buildButtons(state),
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        R.string.signUpScreen.signUpNewAccount,
      ).tr(),
    );
  }

  Widget buildForms(SignUpState state) {
    final cubit = getCubit<SignUpCubit>();

    Widget textFieldLabel(String text) {
      return Padding(
        padding: const EdgeInsets.only(left: 16, bottom: 4),
        child: Text(text),
      );
    }

    Widget validationString(String text, {required bool valid}) {
      return Padding(
        padding: const EdgeInsets.only(
          top: 2,
          bottom: 2,
          left: 8,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FSImage.asset(
              imageResource: valid ? R.image.vector.check : R.image.vector.close,
              color: valid ? Colors.green : Colors.red,
              width: 16,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }

    final repeatPassword = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        textFieldLabel(R.string.signUpScreen.repeatPassword.tr()),
        FSTextField(
          controller: rePasswordController,
          hint: R.string.signUpScreen.enterPassword.tr(),
          error: (rePasswordController.text.isNotEmpty && passwordController.text != rePasswordController.text)
              ? R.string.signUpScreen.passwordNotMatch.tr()
              : null,
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          onChanged: (value) => setState(() {}),
          onSubmitted: (value) {
            if (validate()) {
              onSignUp();
            }
          },
        ),
      ],
    );

    final passwordValidation = Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              R.string.signUpScreen.passwordRequirement,
              style: const TextStyle(
                fontSize: 12,
              ),
            ).tr(),
          ),
          validationString(
            R.string.signUpScreen.passwordLengthValidation.tr(),
            valid: !cubit.validPassword(passwordController.text).contains(PasswordValidation.length),
          ),
          validationString(
            R.string.signUpScreen.passwordCharacterValidation.tr(),
            valid: !cubit.validPassword(passwordController.text).contains(PasswordValidation.character),
          ),
          validationString(
            R.string.signUpScreen.passwordSpecialCharacterValidation.tr(),
            valid: !cubit.validPassword(passwordController.text).contains(PasswordValidation.specialCharacter),
          ),
        ],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        textFieldLabel(R.string.signUpScreen.yourEmail.tr()),
        FSTextField(
          controller: emailController,
          hint: R.string.signUpScreen.enterEmail.tr(),
          error: state is EmailExistState ? R.string.signUpScreen.emailExist.tr() : null,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onChanged: (value) => setState(() {}),
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'\s')),
          ],
        ),
        const SizedBox(height: 16),
        textFieldLabel(R.string.signUpScreen.password.tr()),
        FSTextField(
          controller: passwordController,
          hint: R.string.signUpScreen.enterPassword.tr(),
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
          textInputAction: TextInputAction.next,
          onChanged: (value) => setState(() {}),
        ),
        const SizedBox(height: 16),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: cubit.validPassword(passwordController.text).isEmpty ? repeatPassword : passwordValidation,
        ),
      ],
    );
  }

  Widget buildButtons(SignUpState state) {
    return Column(
      children: [
        FilledButton(
          onPressed: (validate() && passwordController.text == rePasswordController.text)
              ? () {
                  onSignUp();
                }
              : null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state is SigningUpState)
                const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: FSProgressIndicator(),
                ),
              Text(
                state is SigningUpState ? R.string.signUpScreen.signingUp : R.string.signUpScreen.signUpNewAccount,
              ).tr(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Divider(
            color: R.color.mainColor.withOpacity(0.25),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(R.string.signInScreen.continueWith).tr(),
        ),
        FilledButton.tonal(
          onPressed: () {
            getCubit<SignUpCubit>().signUpWithGoogle();
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
    final cubit = getCubit<SignUpCubit>();
    return cubit.validName(name) && cubit.validEmail(email) && cubit.validPassword(password).isEmpty;
  }

  void onSignUp() {
    getCubit<SignUpCubit>().signUp(
      name: name.trim(),
      email: email.trim(),
      password: password,
    );
  }
}
