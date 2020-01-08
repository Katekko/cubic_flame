import 'package:cubic_flame/core/blocs/rank.bloc.dart';
import 'package:cubic_flame/core/utils/snackbar.dart';
import 'package:flutter/material.dart';

class ChooseNameModal extends StatelessWidget {
  final TextEditingController _nickController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RankBloc rankBloc;
  ChooseNameModal({@required this.rankBloc});

  Future<bool> _checkNameExist() async {
    var nickExists = await rankBloc.checkNickExist(nick: _nickController.text);
    return nickExists;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_formKey.currentState.validate()) {
          return _nickController.text.isNotEmpty;
        }
        return false;
      },
      child: AlertDialog(
        title: Text('Criando seu Nome:'),
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _nickController,
                  validator: (val) => val.isNotEmpty && val.length > 2
                      ? null
                      : 'Seu nick precisa ter pelo menos 3 letras!',
                ),
              ),
              SizedBox(height: 30),
              RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    if (await _checkNameExist()) {
                      SnackBarLib.showWarningSnackBar(
                        context: context,
                        text: 'Este nick já está sendo utilizado!',
                      );
                    } else {
                      Navigator.of(context).pop(_nickController.text);
                    }
                  }
                },
                child: Text('Enviar nome'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
