import 'package:doctor/api/api.dart';
import 'package:doctor/components/navigation_bar.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String _messageOldPassword = "";
  String _messageNewPassword = "";
  String _messageReNewPassword = "";
  final TextEditingController _controllerOldPassword = TextEditingController();
  final TextEditingController _controllerNewPassword = TextEditingController();
  final TextEditingController _controllerReNewPassword = TextEditingController();

  ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              (widget.title)
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildTextFieldOldPassword(),
                    _buildTextFieldNewPassword(),
                    _buildTextFieldReNewPassword(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: FloatingActionButton.extended(
                        label: Text(
                          "change passowrd".toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          String oldPassword = _controllerOldPassword.text;
                          String newPassword = _controllerNewPassword.text;
                          String newPasswordConfirm = _controllerReNewPassword.text;
                          _apiService.changePassword(oldPassword, newPassword, newPasswordConfirm).then((response) {
                            if(response["status"] == "success"){
                              final snackBar = SnackBar(
                                content: const Text('Change Password Successfully!'),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                            if(response["status"] == "error"){
                              final snackBar = SnackBar(
                                content: const Text('Something went wrong!'),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        drawer:  Navbar(title: widget.title)
    );
  }

  Widget _buildTextFieldOldPassword() {
    return TextField(
      controller: _controllerOldPassword,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        labelText: "Old Password",
        errorText: _messageOldPassword == ""? null : _messageOldPassword,
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (!isFieldValid) {
          setState(() => _messageOldPassword = "This Field is required.");
        }else{
          setState(() => _messageOldPassword = "");
        }
      },
    );
  }

  Widget _buildTextFieldNewPassword() {
    return TextField(
      controller: _controllerNewPassword,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        labelText: "New Password",
        errorText: _messageNewPassword == ""? null : _messageNewPassword,
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (!isFieldValid) {
          setState(() => _messageNewPassword = "This Field is required.");
        }else{
          setState(() => _messageNewPassword = "");
        }
      },
    );
  }

  Widget _buildTextFieldReNewPassword() {
    return TextField(
      controller: _controllerReNewPassword,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        labelText: "Re-type Password",
        errorText: _messageReNewPassword == ""? null : _messageReNewPassword,
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (!isFieldValid) {
          setState(() => _messageReNewPassword = "This Field is required.");
        }else{
          setState(() => _messageReNewPassword = "");
        }
      },
    );
  }
}