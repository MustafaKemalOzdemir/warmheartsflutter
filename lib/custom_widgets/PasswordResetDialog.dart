import 'package:flutter/material.dart';

typedef SendPressed = void Function(String, BuildContext);

class PasswordResetDialog extends StatefulWidget {
  final BuildContext context;
  final SendPressed sendPressed;
  const PasswordResetDialog({this.context, this.sendPressed});

  @override
  _PasswordResetDialogState createState() => _PasswordResetDialogState();
}

class _PasswordResetDialogState extends State<PasswordResetDialog> {
  final _resetKey = GlobalKey<FormState>();
  final _resetEmailController = TextEditingController();
  String _resetEmail;
  bool _resetValidate = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: new Text('Şifremi Kurtar'),
        content: new SingleChildScrollView(
          child: Form(
            key: _resetKey,
            autovalidate: _resetValidate,
            child: ListBody(
              children: <Widget>[
                new Text(
                  'Lütfen E-Mail adresinizi girin.',
                  style: TextStyle(fontSize: 14.0),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  controller: _resetEmailController,
                  autofocus: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail, color: Colors.blue),
                    labelText: 'E-Posta',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 1,
                  validator: (String value) {
                    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                    if (emailValid && value.length < 35) {
                      return null;
                    } else {
                      return 'Lütfen Geçerli E-Posta Adresi Girin';
                    }
                  },
                  onSaved: (String val) {
                    _resetEmail = val;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text(
              'VAZGEÇ',
              style: TextStyle(color: Colors.grey[800]),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          new FlatButton(
            child: new Text(
              'GÖNDER',
              style: TextStyle(color: Colors.green[800]),
            ),
            onPressed: () {
              widget.sendPressed(_resetEmailController.text, context);
            },
          ),
          SizedBox(width: 5)
        ],
      ),
    );
  }
}

String validateEmail(String value) {
  String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Email is required";
  } else if (!regExp.hasMatch(value)) {
    return "Invalid Email";
  } else {
    return null;
  }

}
