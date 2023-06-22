import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:antoh/screens/homepage.dart';
import 'package:antoh/utils/InputValidator.dart';
import 'package:antoh/provider/UserProvider.dart';
import 'package:fluttertoast/fluttertoast.dart';
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  
 @override
    void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).initFirebase();
    });
  }

  // ouur form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //editing controller
  final Map<String, dynamic> _userRegistration = {
    'email': null,
    'password': null,
    'firstname': null,
    'lastname': null,
    'confirmpassword': null,
  };
  bool passwordVisible = true;
  bool confpasswordVisible = true;

  void _submitForm(Function register) async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    _formKey.currentState!.save();
    final Map<String, dynamic> successInformation = await register(_userRegistration);
    if (successInformation['success']) {
		   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        HomePage()), (Route<dynamic> route) => false);

        AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.SCALE,
        headerAnimationLoop: true,
        title: 'SUCCESS',
        desc:
        successInformation['message'])
        .show();

    }  
    else{
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.SCALE,
        headerAnimationLoop: true,
        title: 'Error',
        desc:
        successInformation['message'])
        .show();
    }
    }
        
    

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    //first name field
    final firstNameField = TextFormField(
        autofocus: false,
        keyboardType: TextInputType.text,
        validator: InputValidator.firstName,
        onSaved: (input) {
        _userRegistration['firstname'] = input;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          focusColor: Theme.of(context).primaryColor,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.circular(10)),
            prefixIcon:  Icon(Icons.account_circle,color: Colors.black,),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Firstname",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));

    //second name field
    final secondNameField = TextFormField(
        autofocus: false,
        keyboardType: TextInputType.text,
        validator: InputValidator.lastName,
        onSaved: (input) {
        _userRegistration['lastname'] = input;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          focusColor: Theme.of(context).primaryColor,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color:  Colors.black, width: 2.0),
                borderRadius: BorderRadius.circular(10)),
            prefixIcon:  Icon(Icons.account_circle ,color: Colors.black,),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Lastname",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));

    //email field
    final emailField = TextFormField(
        autofocus: false,
        keyboardType: TextInputType.emailAddress,
        validator: InputValidator.email,
        onSaved: (input) {
        _userRegistration['email'] = input;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          focusColor: Theme.of(context).primaryColor,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(10)),
            prefixIcon:  Icon(Icons.mail,color: Colors.black,),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Email",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        validator: InputValidator.password,
        onSaved: (input) {
        _userRegistration['password'] = input;
        },
        textInputAction: TextInputAction.next,
        obscureText: passwordVisible,
        decoration: InputDecoration(
          focusColor: Theme.of(context).primaryColor,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(10)),
          prefixIcon:  Icon(Icons.vpn_key,color: Colors.black,),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border:OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          suffixIcon: IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(
              // Based on passwordVisible state choose the icon
              passwordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Colors.black,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                passwordVisible = !passwordVisible;
              });
            },
            ),
          ),);

    //confirm password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        validator: InputValidator.password,
        onSaved: (input) {
        _userRegistration['confirmpassword'] = input;
        },
        textInputAction: TextInputAction.done,
        obscureText: confpasswordVisible,
        decoration: InputDecoration(
          focusColor: Theme.of(context).primaryColor,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(10)),
          prefixIcon:  Icon(Icons.vpn_key,color: Colors.black,),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border:OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          suffixIcon: IconButton(
            color: Colors.black,
            icon: Icon(
              // Based on passwordVisible state choose the icon
              passwordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,

              color: Colors.black,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                confpasswordVisible = !confpasswordVisible;
              });
            },
            ),
          ),);

    // sign up button
    final signupButton = Material(
       elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.black,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          _submitForm(userProvider.register);
        },
        child: const Text(
          "Sign Up",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon:  Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            //passing this to ouur root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 15,
                    ),


                    new Image.asset(
                      'assets/images/antohlogo.png',
                      width: 600.0,
                      height: 240.0,
                      fit: BoxFit.cover,
                    ),

                    const SizedBox(
                      height: 45,
                    ),
                    firstNameField,
                    const SizedBox(
                      height: 20,
                    ),
                    secondNameField,
                    const SizedBox(
                      height: 20,
                    ),
                    emailField,
                    const SizedBox(
                      height: 20,
                    ),
                    passwordField,
                    const SizedBox(
                      height: 20,
                    ),
                    confirmPasswordField,
                    const SizedBox(
                      height: 30,
                    ),
                    signupButton,
                    const SizedBox(
                      height: 35,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
displayToast(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
