import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  final Color textColor;
  final bool visible;

  const Error(
      {Key key,
      this.errorMessage,
      this.onRetryPressed,
      this.textColor = Colors.white,
      this.visible = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(8),
        color: Colors.grey.shade300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              errorMessage,
              //AppLocalizations.of(context).translate('progress_something'),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            if (visible)
              Column(
                children: [
                  RaisedButton(
                    color: Colors.white,
                    child: Text("Retry", style: TextStyle(color: Colors.black)),
                    onPressed: onRetryPressed,
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
