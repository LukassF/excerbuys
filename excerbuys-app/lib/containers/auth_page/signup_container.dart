import 'package:excerbuys/components/input_with_icon.dart';
import 'package:excerbuys/components/shared/buttons/main_button.dart';
import 'package:excerbuys/utils/constants.dart';
import 'package:excerbuys/utils/utils.dart';
import 'package:flutter/material.dart';

enum SIGNUP_FIELD_TYPE { USERNAME, EMAIL, PASSWORD, PASSWORD_REPEAT }

class SignupContainer extends StatefulWidget {
  final Future<Map<SIGNUP_FIELD_TYPE, String?>?> Function(
      String, String, String) signUp;

  const SignupContainer({super.key, required this.signUp});

  @override
  State<SignupContainer> createState() => _SignupContainerState();
}

class _SignupContainerState extends State<SignupContainer> {
  final Map<SIGNUP_FIELD_TYPE, String> _formFieldsState = {
    SIGNUP_FIELD_TYPE.USERNAME: '',
    SIGNUP_FIELD_TYPE.EMAIL: '',
    SIGNUP_FIELD_TYPE.PASSWORD: '',
    SIGNUP_FIELD_TYPE.PASSWORD_REPEAT: ''
  };
  Map<SIGNUP_FIELD_TYPE, String?> _formErrorsState = {
    SIGNUP_FIELD_TYPE.USERNAME: null,
    SIGNUP_FIELD_TYPE.EMAIL: null,
    SIGNUP_FIELD_TYPE.PASSWORD: null,
    SIGNUP_FIELD_TYPE.PASSWORD_REPEAT: null
  };

  bool _loading = false;

  void setErrors() {
    setState(() {
      final String username = _formFieldsState[SIGNUP_FIELD_TYPE.USERNAME]!;
      final String email = _formFieldsState[SIGNUP_FIELD_TYPE.EMAIL]!;
      final String password = _formFieldsState[SIGNUP_FIELD_TYPE.PASSWORD]!;
      final String passwordRepeat =
          _formFieldsState[SIGNUP_FIELD_TYPE.PASSWORD_REPEAT]!;

      _formErrorsState = {
        SIGNUP_FIELD_TYPE.USERNAME: username.isEmpty
            ? 'Username is required'
            : username.length < 5
                ? 'Has to have at least 5 characters'
                : null,
        SIGNUP_FIELD_TYPE.EMAIL: email.isEmpty
            ? 'Email is required'
            : !EMAIL_REGEX.hasMatch(email)
                ? 'Email invalid'
                : null,
        SIGNUP_FIELD_TYPE.PASSWORD: password.isEmpty
            ? 'Password is required'
            : password.length < 5
                ? 'Has to have at least 5 characters'
                : null,
        SIGNUP_FIELD_TYPE.PASSWORD_REPEAT:
            password.length >= 5 && password != passwordRepeat
                ? 'Passwords do not match'
                : null
      };
    });
  }

  void submitForm(BuildContext context) async {
    try {
      if (_loading) {
        return; // Don't submit if we are loading
      }
      setErrors();
      if (_formErrorsState.values.any((error) => error != null)) {
        return; // Don't submit if there are errors
      }

      setState(() {
        _loading = true;
      });

      final Map<SIGNUP_FIELD_TYPE, String?>? serverResponse =
          await widget.signUp(
              _formFieldsState[SIGNUP_FIELD_TYPE.USERNAME]!,
              _formFieldsState[SIGNUP_FIELD_TYPE.EMAIL]!,
              _formFieldsState[SIGNUP_FIELD_TYPE.PASSWORD]!);

      if (serverResponse != null) {
        serverResponse.forEach((key, val) {
          setState(() {
            _formErrorsState[key] = val;
          });
        });
        return;
      }

      if (context.mounted) {
        navigateWithClear(route: '/', context: context);
      }
    } catch (error) {
      return;
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    final bool isButtonDisabled = _formErrorsState.values
            .any((value) => value != null && value.isNotEmpty) ||
        _formFieldsState.values.any((value) => value.isEmpty);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(children: [
          InputWithIcon(
            leftIcon: 'assets/svg/profile.svg',
            placeholder: 'Username',
            onChange: (String val) {
              setState(() {
                _formFieldsState[SIGNUP_FIELD_TYPE.USERNAME] = val;
                _formErrorsState[SIGNUP_FIELD_TYPE.USERNAME] = null;
              });
            },
            error: _formErrorsState[SIGNUP_FIELD_TYPE.USERNAME],
          ),
          InputWithIcon(
            leftIcon: 'assets/svg/email.svg',
            placeholder: 'Email',
            onChange: (String val) {
              setState(() {
                _formFieldsState[SIGNUP_FIELD_TYPE.EMAIL] = val;
                _formErrorsState[SIGNUP_FIELD_TYPE.EMAIL] = null;
              });
            },
            error: _formErrorsState[SIGNUP_FIELD_TYPE.EMAIL],
          ),
          InputWithIcon(
            leftIcon: 'assets/svg/padlock.svg',
            placeholder: 'Password',
            onChange: (String val) {
              setState(() {
                _formFieldsState[SIGNUP_FIELD_TYPE.PASSWORD] = val;
                _formErrorsState[SIGNUP_FIELD_TYPE.PASSWORD] = null;
              });
            },
            error: _formErrorsState[SIGNUP_FIELD_TYPE.PASSWORD],
            isPassword: true,
          ),
          InputWithIcon(
            leftIcon: 'assets/svg/padlock.svg',
            placeholder: 'Repeat password',
            onChange: (String val) {
              setState(() {
                _formFieldsState[SIGNUP_FIELD_TYPE.PASSWORD_REPEAT] = val;
                _formErrorsState[SIGNUP_FIELD_TYPE.PASSWORD_REPEAT] = null;
              });
            },
            error: _formErrorsState[SIGNUP_FIELD_TYPE.PASSWORD_REPEAT],
            isPassword: true,
          ),
        ]),
        MainButton(
            label: 'Sign up',
            backgroundColor: colors.secondary,
            textColor: colors.primary,
            isDisabled: isButtonDisabled,
            loading: _loading,
            onPressed: () {
              submitForm(context);
            })
      ],
    );
  }
}
