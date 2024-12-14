import 'package:danilee/resources/text_styles.dart';
import 'package:danilee/shared/widgets/appbar/app_bar_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../clients/login/models/login_response.dart';
import '../../resources/app_colors.dart';
import '../../resources/styles.dart';
import '../../shared/app_utils.dart';
import '../../shared/constants.dart';
import '../../shared/widgets/buttons/primary_button.dart';
import '../../shared/widgets/formfield/form_field.dart';
import 'bloc/login_bloc.dart';
import 'dart:developer';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoginDisabled = true;

  @override
  Future<void> dispose() async {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHeader(
        title: 'Login',
        showDefaultBackButton: false,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppUIColors.white,
          child: _loginForm(),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SafeArea(
          child: AutofillGroup(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 60),
                      Image.asset(
                        Constants.appLogo,
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                      const SizedBox(height: 50),
                      AppFormField(
                        keyName: const Key('email'),
                        textEditingController: _emailController,
                        hintText: 'E-mail',
                        formFieldStyle: Styles.formFieldStyle(context),
                        validate: (String? str) =>
                            (AppUtils.isValidEmail(_emailController.text))
                                ? null
                                : 'Enter valid email',
                        onChanged: (String value) => <void>{
                          setState(() {
                            _updateLoginButtonState();
                          }),
                        },
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const <String>[
                          AutofillHints.email,
                        ],
                      ),
                      const SizedBox(height: 25),
                      AppFormField(
                        keyName: const Key('password'),
                        textEditingController: _passwordController,
                        hintText: 'Password',
                        isPasswordField: true,
                        formFieldStyle: Styles.formFieldStyle(context),
                        validate: (String? str) =>
                            (AppUtils.isValidEmail(_emailController.text))
                                ? null
                                : 'Enter valid email',
                        onChanged: (String value) => <void>{
                          setState(() {
                            _updateLoginButtonState();
                          }),
                        },
                        keyboardType: TextInputType.visiblePassword,
                        autofillHints: const <String>[
                          AutofillHints.password,
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            foregroundColor: AppUIColors.grey,
                            textStyle: AppTextStyles.heading3),
                        child: const Text('Forgot Password'),
                      ),
                      const SizedBox(height: 30),
                      _getLoginButton(),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            foregroundColor: AppUIColors.black,
                            textStyle: AppTextStyles.heading3.bold),
                        child: const Text('Create Account'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BlocConsumer<LoginBloc, LoginState> _getLoginButton() {
    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (LoginState previous, LoginState current) =>
          previous != current,
      listener: (BuildContext context, LoginState state) async {
        switch (state) {
          case LoginFailed(:final String errorMessage):
            return AppUtils.showCustomToast(context, errorMessage);
          case LoginSuccess(:final LoginData loginData):
            await Navigator.pushReplacementNamed(
              context,
              '/patients',
              arguments: loginData,
            );
          default:
        }
      },
      builder: (BuildContext context, LoginState state) {
        final bool loading = state is LoginLoading;

        return loading
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppUIColors.white,
                ),
              )
            : SizedBox(
                width: double.infinity,
                height: 52.0,
                child: PrimaryButton(
                  style: Styles.primaryButtonStyle(context,
                      disabled: isLoginDisabled),
                  title: 'Login',
                  disabled: isLoginDisabled,
                  onTap: () {
                    log('click on login btn');
                    context.read<LoginBloc>().add(
                          LoginSubmitted(
                            email: _emailController.value.text,
                            password: _passwordController.value.text,
                          ),
                        );
                  },
                ),
              );
      },
    );
  }

  void _updateLoginButtonState() {
    if (_emailController.value.text.length > 3 &&
        _passwordController.value.text.length > 3) {
      isLoginDisabled = false;
    } else {
      isLoginDisabled = true;
    }
  }
}
