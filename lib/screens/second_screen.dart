import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:quickalert/quickalert.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final _reporte = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Confirmar', style: TextStyle(color: Colors.black)),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                  child: AnimatedList(
                key: _listKey,
                initialItemCount: 1,
                itemBuilder: (context, index, animation) => Slidable(
                    startActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Aceptado')),
                            );
                            _listKey.currentState!.removeItem(
                              index,
                              (context, animation) => Container(),
                            );
                          },
                          label: 'Recibido',
                          backgroundColor: Colors.green,
                          icon: Icons.check,
                        ),
                      ],
                    ),
                    endActionPane:
                        ActionPane(motion: ScrollMotion(), children: [
                      SlidableAction(
                        onPressed: (context) {
                          QuickAlert.show(
                            context: context,
                            customAsset: 'assets/logo.png',
                            backgroundColor: Colors.black12,
                            // barrierDismissible: false,
                            confirmBtnText: 'Enviar',
                            title: 'Reporte',
                            type: QuickAlertType.warning,
                            text: 'Ingresa la razón del reporte',
                            widget: Form(
                              key: _formKey,
                              child: TextFormField(
                                keyboardType: TextInputType.name,
                                controller: _reporte,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length < 3) {
                                    return 'Ingrese una razón válida';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            onConfirmBtnTap: () async {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Reporte enviado')),
                                );
                                _listKey.currentState!.removeItem(
                                  index,
                                  (context, animation) => Container(),
                                );
                              }
                            },
                          );
                        },
                        label: 'Reportar',
                        backgroundColor: Colors.red,
                        icon: Icons.close,
                      ),
                    ]),
                    child: const Card(
                      child: ListTile(
                        title: Text('dato'),
                      ),
                    )),
              ))
            ],
          ),
        ));
  }
}
