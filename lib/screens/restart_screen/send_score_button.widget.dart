import 'package:cubic_flame/core/blocs/rank.bloc.dart';
import 'package:cubic_flame/core/models/enviar_score.model.dart';
import 'package:cubic_flame/core/models/exceptions/nome_existente.exception.dart';
import 'package:cubic_flame/core/utils/snackbar.dart';
import 'package:flutter/material.dart';

class SendScoreButtonWidget extends StatefulWidget {
  final RankBloc bloc;
  final EnviarScoreModel enviarScoreModel;
  const SendScoreButtonWidget({
    @required this.bloc,
    @required this.enviarScoreModel,
  });

  @override
  _SendScoreButtonWidgetState createState() => _SendScoreButtonWidgetState();
}

class _SendScoreButtonWidgetState extends State<SendScoreButtonWidget> {
  bool scoreEnviado = false;

  void _sendScoreToRank({@required BuildContext ct}) {
    widget.bloc.sendScore(model: widget.enviarScoreModel).then(
      (sucesso) {
        if (sucesso) {
          SnackBarLib.showSuccessSnackBar(
            context: ct,
            text: 'Score enviado!',
          );
          setState(() {
            scoreEnviado = true;
          });
        } else {
          SnackBarLib.showErrorSnackBar(
            context: ct,
            text: 'Falha ao enviar score',
          );
        }
      },
    ).catchError(
      (err) {
        if (err is NomeExistenteException) {
          SnackBarLib.showErrorSnackBar(
            context: ct,
            text: 'Este nome já está sendo utilizado!',
          );
          return;
        }
        SnackBarLib.showErrorSnackBar(
          context: ct,
          text: 'Falha ao enviar score',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: scoreEnviado ? null : () => _sendScoreToRank(ct: context),
      color: scoreEnviado ? Colors.blue : Colors.yellow[800],
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: AnimatedContainer(
        duration: Duration(seconds: 2),
        width: scoreEnviado
            ? MediaQuery.of(context).size.width * .5
            : MediaQuery.of(context).size.width * .7,
        height: 30,
        child: Center(
          child: AnimatedDefaultTextStyle(
            child: scoreEnviado
                ? Text(
                    'SCORE SENT',
                    style: TextStyle(fontFamily: 'GameFont'),
                  )
                : Text(
                    'SUBMIT SCORE',
                    style: TextStyle(fontFamily: 'GameFont'),
                  ),
            duration: Duration(seconds: 2),
            style: scoreEnviado
                ? TextStyle(
                    fontSize: 17,
                    color: Colors.purpleAccent,
                  )
                : TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  ),
          ),
        ),
      ),
    );
  }
}
