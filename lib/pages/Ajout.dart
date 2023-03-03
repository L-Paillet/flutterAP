import 'package:flutter/material.dart';
import 'package:flutterapp/livre.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class Ajout extends StatefulWidget {
  const Ajout({Key? key}) : super(key: key);

  @override
  State<Ajout> createState() => _AjoutState();
}

class _AjoutState extends State<Ajout> {
  bool isAPIcallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? title;
  String? body;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Nouveau Produit"),
        ),
        backgroundColor: Colors.white,
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _AjoutUI(context),
          ),
          inAsyncCall: isAPIcallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget _AjoutUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 70, bottom: 30),
              child: Text(
                "Nom du produit :",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black),
              ),
            ),
            FormHelper.inputFieldWidget(context, "Nom", "Nom", (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Le nom ne peut pas être vide";
              }
              return null;
            }, (onSaved) {
              title = onSaved;
            },
                borderFocusColor: Colors.black,
                borderColor: Colors.black,
                textColor: Colors.black,
                hintColor: Colors.black.withOpacity(0.8),
                borderRadius: 10),
            const Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
              ),
              child: Text(
                "Description :",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: FormHelper.inputFieldWidget(
                context,
                "body",
                "Description",
                (onValidateVal) {
                  if (onValidateVal.isEmpty) {
                    return "La description ne peut pas être vide";
                  }
                  return null;
                },
                (onSaved) {
                  body = onSaved;
                },
                borderFocusColor: Colors.red,
                borderColor: Colors.black,
                textColor: Colors.black,
                hintColor: Colors.black.withOpacity(0.8),
                borderRadius: 10,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: FormHelper.submitButton("Valider", () {
                dynamic validate = globalFormKey.currentState?.validate();
                if (validate != null && validate) {
                  globalFormKey.currentState?.save();
                  Livre.ajout(context, title, body);
                }
              },
                  btnColor: Colors.black,
                  borderColor: Colors.white,
                  txtColor: Colors.white,
                  borderRadius: 10),
            )
          ]),
    );
  }
}
