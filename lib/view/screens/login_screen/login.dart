/* import 'package:flutter/material.dart';



class UserRegister extends StatefulWidget {
  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  bool hidePassword = true;
  bool hideConfirmPassword = true;

 

  @override
  void initState() {
    super.initState();
   // userModel = new UserModel();
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        key: _scaffoldKey,
        body: Container(
          child: loginUISetup(),
         
        ),
      ),
    );
  }

  Widget loginUISetup() {
    return new SingleChildScrollView(
      child: new Container(
        child: new Form(
          key: globalFormKey,
          child: _loginUI(context),
        ),
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
    return new SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.red, Colors.green],
              ),
              borderRadius: BorderRadius.only(
                // topLeft: Radius.circular(500),
                //topRight: Radius.circular(150),
                bottomRight: Radius.circular(150),
                //bottomLeft: Radius.circular(150),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: Text('Admin Login',style: TextStyle(color:Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)
                ),
                Spacer(),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20, top: 40),
              child: Text(
                "",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
          ),
          /* FormHelper.inputFieldWidget(
            context,
            Icon(Icons.email),
            "name",
            "Email Id",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return 'Email can\'t be empty.';
              }

              bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(onValidateVal);

              if (!emailValid) {
                return 'Email Invalid!';
              }

              return null;
            },
            (onSavedVal) => {
              this.userModel.emailId = onSavedVal.toString().trim(),
            },
            initialValue: "",
            paddingBottom: 20,
          ), */
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 0,
              bottom: 20,
            ),
            child: TextFormField(
              initialValue: '',
              key: new Key(''.toString()),
              obscureText: false,
              maxLines: 1,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Email can\'t be empty.';
                }

                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(val);

                if (!emailValid) {
                  return 'Email Invalid!';
                }

                return null;
              },
             /*  onSaved: (onSavedVal) => {
                this.userModel.emailId = onSavedVal.toString().trim(),
              }, */
              onChanged: (val) {},
              style: TextStyle(
                fontSize: 18,
              ),
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  hintText: 'Email Id',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  suffixIcon: null,
                  prefixIcon: Padding(
                    child: IconTheme(
                      data: IconThemeData(color: Colors.red),
                      child: Icon(Icons.email),
                    ),
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 10,
                      // top: prefixIconPaddingTop,
                      // bottom: prefixIconPaddingBottom,
                    ),
                  )),
            ),
          ),
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 0,
              bottom: 20,
            ),
            child: TextFormField(
              initialValue: '',
              obscureText: hidePassword,
              key: new Key(''.toString()),
             // obscureText: false,
              maxLines: 1,
              validator:  (onValidateVal) {
              if (onValidateVal!.isEmpty) {
                return 'Password can\'t be empty.';
              }

              return null;
            },
             /*  onSaved:(onSavedVal) => {
              this.userModel.password = onSavedVal.toString().trim(),
            }, */
              onChanged: (val) {},
              style: TextStyle(
                fontSize: 18,
              ),
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  hintText: 'Password',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
              color: Colors.redAccent.withOpacity(0.4),
              icon: Icon(
                hidePassword ? Icons.visibility_off : Icons.visibility,
              ),
            ),
                  prefixIcon: Padding(
                    child: IconTheme(
                      data: IconThemeData(color: Colors.red),
                      child: Icon(Icons.lock),
                    ),
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 10,
                      // top: prefixIconPaddingTop,
                      // bottom: prefixIconPaddingBottom,
                    ),
                  )),
            ),
          ),
          /*  FormHelper.inputFieldWidget(
            context,
            Icon(Icons.lock),
            "password",
            "Password",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return 'Password can\'t be empty.';
              }

              return null;
            },
            (onSavedVal) => {
              this.userModel.password = onSavedVal.toString().trim(),
            },
            initialValue: "",
            obscureText: hidePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
              color: Colors.redAccent.withOpacity(0.4),
              icon: Icon(
                hidePassword ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            paddingBottom: 20,
            onChange: (val) {
              this.userModel.password = val;
            },
          ), */
          SizedBox(
            height: 20,
          ),
          new Center(
            child: Container(
      height: 50,
      width: 150,
      child: GestureDetector(
       /*  onTap: () {
          onTap();
        }, */
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.redAccent,
              style: BorderStyle.solid,
              width: 1.0,
            ),
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    )
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
 */
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:samudra_bilash_hotel/data/database_helper.dart';
import 'package:samudra_bilash_hotel/model/user.dart';
import 'package:samudra_bilash_hotel/view/screens/login_screen/login_screen_presenter.dart';

import '../../../auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen>
    implements LoginScreenContract, AuthStateListener {
  late BuildContext _ctx;

  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  late String _username, _password;

  late LoginScreenPresenter _presenter;

  LoginScreenState() {
    _presenter = new LoginScreenPresenter(this);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);
  }

  void _submit() {
    final form = formKey.currentState;

    if (form!.validate()) {
      setState(() => _isLoading = true);
      form.save();
      _presenter.doLogin(_username, _password);
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState!
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  onAuthStateChanged(AuthState state) {
    if (state == AuthState.LOGGED_IN) print(state);
   
    Navigator.of(_ctx).pushReplacementNamed("/home");
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = new RaisedButton(
      onPressed: _submit,
      child: new Text("LOGIN"),
      color: Colors.primaries[0],
    );
    var loginForm = new Column(
      children: <Widget>[
        new Text(
          "Login App",
          textScaleFactor: 2.0,
        ),
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  onSaved: (val) => _username = val!,
                  validator: (val) {
                    return val!.length < 10
                        ? "Username must have atleast 10 chars"
                        : null;
                  },
                  decoration: new InputDecoration(labelText: "Username"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  onSaved: (val) => _password = val!,
                  decoration: new InputDecoration(labelText: "Password"),
                ),
              ),
            ],
          ),
        ),
        _isLoading ? new CircularProgressIndicator() : loginBtn
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
    );

    return new Scaffold(
      appBar: null,
      key: scaffoldKey,
      body: new Container(
        decoration: new BoxDecoration(),
        child: new Center(
          child: new ClipRect(
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: new Container(
                child: loginForm,
                height: 300.0,
                width: 300.0,
                decoration: new BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.5)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onLoginError(String errorTxt) {
    _showSnackBar(errorTxt);
    setState(() => _isLoading = false);
  }

  @override
  void onLoginSuccess(User user) async {
    _showSnackBar(user.toString());
    setState(() => _isLoading = false);
    var db = new DatabaseHelper();
    await db.saveUser(user);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.notify(AuthState.LOGGED_IN);
  }
}
