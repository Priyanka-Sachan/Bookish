import 'package:bookish/models/bookish_pages.dart';
import 'package:bookish/providers/app_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: BookishPages.loginPath,
      key: ValueKey(BookishPages.loginPath),
      child: LoginScreen(),
    );
  }

  LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _page = 0;
  bool _isLoading = false;
  String _email = '';
  String _password = '';
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void login() async {
    setState(() {
      _isLoading = true;
    });
    try {
      Provider.of<AppStateProvider>(context, listen: false)
          .login(_email, _password);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  void signup() async {
    setState(() {
      _isLoading = true;
    });
    try {
      Provider.of<AppStateProvider>(context, listen: false)
          .signup(_email, _password);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  @override
  void initState() {
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/images/splash_screen_logo.png',
                  ),
                ),
                const SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.none,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Email Required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Password Required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _page == 0
                          ? ElevatedButton(
                              onPressed: login, child: Text('Login'))
                          : ElevatedButton(
                              onPressed: signup, child: Text('Sign Up')),
                      _page == 0
                          ? OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  _page = 1;
                                });
                              },
                              child: Text('Create an account'),
                            )
                          : OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  _page = 0;
                                });
                              },
                              child: Text('Already have a account?'),
                            )
                    ],
                  ),
                ),
              ],
            ),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
