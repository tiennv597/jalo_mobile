import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinro_int2/constant/app_properties.dart';
import 'package:shinro_int2/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:shinro_int2/models/user/user_model.dart';
import 'package:shinro_int2/network/api_service.dart';
import 'package:shinro_int2/constant/shared_preferences.dart'
    as SHARED_PREFERNCES;
import 'package:shinro_int2/constant/network_constant.dart' as NETWORK_CONSTANT;
import 'package:shinro_int2/screens/main/main_screen.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import '../register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoggedIn = false;
  Map userProfile;
  //loading when login
  bool loading;
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  final facebookLogin = FacebookLogin();

  _loginWithFB() async {
    final result = await facebookLogin.logIn(['email']);
    setState(() {
      loading = true;
    });
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token');
        final profile = JSON.jsonDecode(graphResponse.body);
        setState(() {
          userProfile = profile;
          isLoggedIn = true;
        });
        final api = Provider.of<ApiService>(context, listen: false);
        api.authFacebook(token).then((it) async {
          print(it.headers.value('authorization'));
          final user = User.fromJson(it.data);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool(SHARED_PREFERNCES.logined, true);
          prefs.setString(SHARED_PREFERNCES.user_id, user.sId);
          prefs.setString(
              SHARED_PREFERNCES.fullName, user.firstName + " " + user.lastName);
          prefs.setString(SHARED_PREFERNCES.userAvatar,
              userProfile["picture"]["data"]["url"]);
          prefs.setString(
              SHARED_PREFERNCES.token,
              NETWORK_CONSTANT.bearer +
                  ' ' +
                  it.headers.value('authorization'));
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => MainPage()));
        }).catchError((onError) {
          print("error" + onError.toString());
        });
        break;
      case FacebookLoginStatus.cancelledByUser:
        setState(() => isLoggedIn = false);
        break;
      case FacebookLoginStatus.error:
        setState(() => isLoggedIn = false);
        print(result.errorMessage);
        break;
    }
  }

// loading when login
  Future _loading() async => await Future.delayed(Duration(seconds: 1), () {
        return loading;
      });

  @override
  void initState() {
    super.initState();
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 8.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 36.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            controller: _userController,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 8, top: -8),
              hintText: 'Enter your Email',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 8.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 36.0,
          child: TextField(
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            controller: _passController,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 8, top: -8.0),
              // prefixIcon: Icon(
              //   Icons.lock,
              //   color: Colors.grey,
              // ),
              hintText: 'Enter your Password',
              //hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  // Widget _buildRememberMeCheckbox() {
  //   return Container(
  //     height: 16.0,
  //     child: Row(
  //       children: <Widget>[
  //         Theme(
  //           data: ThemeData(unselectedWidgetColor: Colors.grey),
  //           child: Checkbox(
  //             value: _rememberMe,
  //             checkColor: Colors.blue,
  //             activeColor: Colors.white,
  //             onChanged: (value) {
  //               setState(() {
  //                 _rememberMe = value;
  //               });
  //             },
  //           ),
  //         ),
  //         Text(
  //           'Remember me',
  //           style: kLabelStyle,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: loginCheck,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          'Sign in with',
          style: kLabelStyle,
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48.0,
        width: 48.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            _loginWithFB,
            AssetImage(
              'assets/icons/facebook.jpg',
            ),
          ),
          _buildSocialBtn(
            () => print('Login with Google'),
            AssetImage(
              'assets/icons/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => RegisterPage()));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loading(),
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                brightness: Brightness.light,
                backgroundColor: Colors.white,
                title: Text(
                  'Sign in',
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'OpenSans',
                  ),
                ),
                elevation: 0,
              ),
              backgroundColor: Colors.white,
              body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light,
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                      ),
                      Container(
                        height: double.infinity,
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.0,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              _buildEmailTF(),
                              SizedBox(
                                height: 8.0,
                              ),
                              _buildPasswordTF(),
                              _buildForgotPasswordBtn(),
                              _buildLoginBtn(),
                              _buildSignInWithText(),
                              _buildSocialBtnRow(),
                              _buildSignupBtn(),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }

  void loginCheck() {
    final api = Provider.of<ApiService>(context, listen: false);
    api.signIn(_userController.text, _passController.text).then((it) async {
      print(it.headers.value('authorization'));
      final user = User.fromJson(it.data);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(SHARED_PREFERNCES.logined, true);
      prefs.setString(SHARED_PREFERNCES.user_id, user.sId);
      prefs.setString(
          SHARED_PREFERNCES.fullName, user.firstName + " " + user.lastName);
      prefs.setString(SHARED_PREFERNCES.token,
          NETWORK_CONSTANT.bearer + ' ' + it.headers.value('authorization'));
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => MainPage()));
    }).catchError((onError) {
      print("error" + onError.toString());
    });
  }
}
