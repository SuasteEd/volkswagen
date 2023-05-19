import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:quickalert/quickalert.dart';
import 'package:team_prot1/firebase/firebase_piezas.dart';
import 'package:team_prot1/firebase/firebase_solicitudes.dart';

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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Confirmar', style: TextStyle(color: Colors.black)),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                  child: StreamBuilder(
                      stream: FireStoreSolicitudes().getAllonProces(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError)
                          return Text("No se pudo obtener información.");
                        if (!snapshot.hasData) return Container();
                        return ListView(
                          children: snapshot.data!.docs
                              .map((solicitud) => Slidable(
                                  startActionPane: ActionPane(
                                    motion: ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          FireStoreSolicitudes()
                                              .recibirSolicitur(solicitud.id);
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text('Aceptado')),
                                          );
                                        },
                                        label: 'Recibido',
                                        backgroundColor: Colors.green,
                                        icon: Icons.check,
                                      ),
                                    ],
                                  ),
                                  endActionPane: ActionPane(
                                      motion: ScrollMotion(),
                                      children: [
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
                                              text:
                                                  'Ingresa la razón del reporte',
                                              widget: Form(
                                                key: _formKey,
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.name,
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
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  FireStoreSolicitudes()
                                                      .reportarSolicitud(
                                                          solicitud.id,
                                                          _reporte.text);
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                        content: Text(
                                                            'Reporte enviado')),
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
                                  child: Card(
                                    child: ListTile(
                                      title: Text(
                                          "id maquina ${solicitud["id_maquina"]}"),
                                      subtitle: StreamBuilder(
                                          stream: FireStorePiezas()
                                              .get(solicitud["id_maquina"]),
                                          builder: (context, maquina) {
                                            if (maquina.hasError)
                                              return Text(
                                                  "maquina no encontrada");
                                            if (!maquina.hasData)
                                              return Container();
                                            if (!maquina.data!.exists)
                                              return Text("maquina no existe.");
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    "${maquina.data!['nombre']}"),
                                                Text(
                                                    "Problema: ${solicitud['problema']}")
                                              ],
                                            );
                                          }),
                                      leading: const Icon(Icons.settings),
                                    ),
                                  )))
                              .toList(),
                        );
                      }))
            ],
          ),
        ));
  }
}
