import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:reown_test/core/validator.dart';
import 'package:reown_test/models/user.dart';
import 'package:reown_test/theme/input.dart';
import 'package:reown_test/viewmodels/auth.dart';
import 'package:reown_test/views/auth/login.dart';
import 'package:reown_test/core/extensions.dart';

class Signup extends StatefulWidget {
  Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _form = GlobalKey<FormState>();

  String name = "";

  String email = "";

  String password = "";

  void register() async {
    if (_form.currentState!.validate()) {
      _form.currentState!.save();
      final authVM = Provider.of<AuthViewModel>(context, listen: false);
      try {
        final resp = await authVM.register(name, email, password);
        if (resp) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: Colors.green[400],
                content: Text('Registration successful!, please login')),
          );
          context.push(Login());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: Colors.red[400],
                content: Text('Invalid form, please try again')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red[400], content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<AuthViewModel>(context).isLoading;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _form,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.translate(
                  offset: Offset(-18, 0),
                  child: Icon(
                    Icons.chevron_left_outlined,
                    size: 45,
                  ).onTap(() => context.pop()),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sign Up',
                            style: GoogleFonts.inter().copyWith(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                              width: 300,
                              child: Text(
                                'Fill out the fields below to register on GChat',
                                style: TextStyle(fontSize: 14),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          TextFormField(
                            style: TextStyle(fontSize: 15),
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: appInputDecoration('Name', context),
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                return null;
                              } else {
                                return "Please enter your name";
                              }
                            },
                            onSaved: (value) => name = value!,
                          ),
                          SizedBox(height: 24),
                          TextFormField(
                            style: TextStyle(fontSize: 15),
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: appInputDecoration('Email', context),
                            validator: validateEmail,
                            onSaved: (value) => email = value!,
                          ),
                          SizedBox(height: 24),
                          TextFormField(
                            style: TextStyle(fontSize: 15),
                            obscureText: true,
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: appInputDecoration('Password', context),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                            onSaved: (value) => password = value!,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          child: Text(
                            isLoading ? 'Loading...' : 'REGISTER',
                            style: TextStyle(fontSize: 14),
                          ),
                          onPressed: isLoading ? null : () => {register()},
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: GoogleFonts.roboto().copyWith(fontSize: 15),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () => context.push(Login()),
                            child: Text(
                              'Login',
                              style: GoogleFonts.roboto().copyWith(
                                  fontSize: 15,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
