// Copyright 2025 Seth Ladd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/enums/widget_style.dart';

class LoginScenario extends StatefulWidget {
  final WidgetStyle style;

  const LoginScenario({super.key, required this.style});

  @override
  State<LoginScenario> createState() => _LoginScenarioState();
}

class _LoginScenarioState extends State<LoginScenario> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  final GlobalKey<FormState> _formKeyMaterial = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyCupertino = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  static String? _emailValidator(String? value) {
    return value != null &&
            RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
            ).hasMatch(value)
        ? null
        : 'Please enter a valid email address.';
  }

  static String? _passwordValidator(String? value) {
    return value != null && value.length > 5
        ? null
        : 'Passwords must be at least 6 characters.';
  }

  Widget _buildMaterialVersion() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Form(
            key: _formKeyMaterial,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: _emailValidator,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                  ),
                  obscureText: _obscurePassword,
                  validator: _passwordValidator,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () {
              if (_formKeyMaterial.currentState?.validate() ?? false) {
                Navigator.of(context).pop();
              }
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }

  Widget _buildCupertinoVersion() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Form(
            key: _formKeyCupertino,
            child: Column(
              children: <Widget>[
                _CupertinoFormField(
                  validator: _emailValidator,
                  controller: _emailController,
                  placeholder: 'Email',
                  prefixIcon: CupertinoIcons.mail,
                  autocorrect: false,
                ),
                const SizedBox(height: 16),
                _CupertinoFormField(
                  validator: _passwordValidator,
                  controller: _passwordController,
                  placeholder: 'Password',
                  obscureText: _obscurePassword,
                  prefixIcon: CupertinoIcons.lock,
                  suffix: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                    child: Icon(
                      _obscurePassword
                          ? CupertinoIcons.eye
                          : CupertinoIcons.eye_slash,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                CupertinoButton.filled(
                  onPressed: () {
                    if (_formKeyCupertino.currentState?.validate() ?? false) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:
          widget.style == WidgetStyle.material
              ? _buildMaterialVersion()
              : _buildCupertinoVersion(),
    );
  }
}

class _CupertinoFormField extends FormField<String> {
  _CupertinoFormField({
    required this.controller,
    this.placeholder,
    super.validator,
    bool obscureText = false,
    IconData? prefixIcon,
    Widget? suffix,
    bool autocorrect = true,
  }) : super(
         builder: (FormFieldState<String> state) {
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               CupertinoTextField(
                 style: TextStyle(
                   color:
                       state.hasError
                           ? CupertinoColors.destructiveRed
                           : CupertinoColors.black,
                 ),
                 autocorrect: autocorrect,
                 controller: controller,
                 obscureText: obscureText,
                 onChanged: state.didChange,
                 placeholder: placeholder,
                 prefix:
                     prefixIcon == null
                         ? null
                         : Padding(
                           padding: EdgeInsets.only(left: 8),
                           child: Icon(
                             prefixIcon,
                             color:
                                 state.hasError
                                     ? CupertinoColors.destructiveRed
                                     : null,
                           ),
                         ),
                 suffix: suffix,
                 decoration: BoxDecoration(
                   border: Border.all(
                     color:
                         state.hasError
                             ? CupertinoColors.destructiveRed
                             : CupertinoColors.systemGrey,
                     width: 1.0,
                   ),
                   borderRadius: BorderRadius.circular(8.0),
                 ),
               ),
               if (state.hasError)
                 Padding(
                   padding: const EdgeInsets.only(top: 5.0),
                   child: Text(
                     state.errorText!,
                     style: TextStyle(color: CupertinoColors.destructiveRed),
                   ),
                 ),
             ],
           );
         },
       );

  final String? placeholder;
  final TextEditingController controller;

  @override
  FormFieldState<String> createState() => _CupertinoFormFieldState();
}

class _CupertinoFormFieldState extends FormFieldState<String> {
  @override
  _CupertinoFormField get widget => super.widget as _CupertinoFormField;
}
