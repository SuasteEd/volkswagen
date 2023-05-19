import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:quickalert/quickalert.dart';
import 'package:team_prot1/firebase/firebase_maq.dart';
import 'package:team_prot1/firebase/firebase_piezas.dart';
import 'package:team_prot1/firebase/firebase_solicitudes.dart';
import 'package:team_prot1/firebase/firebase_solicitudes_maqu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Tools(),
    Materials(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Volkswagen',
            style: TextStyle(color: Colors.black),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.build),
              label: 'Maquinas',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'piezas'),
          ],
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: _children,
        ));
  }
}

class Tools extends StatelessWidget {
  Tools({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final _reporte = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Center(
      child: Column(
        children: [
          Expanded(
              child: Container(
            //color: Colors.amber,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Herramientas'),
              ],
            ),
          )),
          Expanded(
              child: StreamBuilder(
                  stream: FireStoreSolicitudesMaq().getAllonProces(),
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
                                      FireStoreSolicitudesMaq()
                                          .recibirSolicitur(solicitud.id);
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
                                          FireStoreSolicitudesMaq()
                                              .reportarSolicitud(
                                                  solicitud.id, _reporte.text);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content:
                                                    Text('Reporte enviado')),
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
                                      stream: FireStoreMaq()
                                          .get(solicitud["id_maquina"]),
                                      builder: (context, maquina) {
                                        if (maquina.hasError)
                                          return Text("maquina no encontrada");
                                        if (!maquina.hasData)
                                          return Container();
                                        if (!maquina.data!.exists)
                                          return Text("maquina no existe.");
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("${maquina.data!['nombre']}"),
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
                  })),
        ],
      ),
    );
  }
}

class Materials extends StatelessWidget {
  Materials({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final _reporte = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Materiales'),
              ],
            ),
          )),
          Expanded(
              child: StreamBuilder(
                  stream: FireStoreSolicitudes().getAllonProces(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError)
                      return Text("No se pudo obtener información.");
                    if (!snapshot.hasData) return Container();
                    return ListView(
                      children: snapshot.data!.docs
                          .map<Widget>((solicitud) => Slidable(
                              startActionPane: ActionPane(
                                motion: ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      FireStoreSolicitudes()
                                          .recibirSolicitur(solicitud.id);
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
                                          FireStoreSolicitudes()
                                              .reportarSolicitud(
                                                  solicitud.id, _reporte.text);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content:
                                                    Text('Reporte enviado')),
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
                                  title:
                                      Text("id pieza ${solicitud["id_pieza"]}"),
                                  subtitle: StreamBuilder(
                                      stream: FireStorePiezas()
                                          .get(solicitud["id_pieza"]),
                                      builder: (context, pieza) {
                                        if (pieza.hasError)
                                          return Text("Pieza no encontrada");
                                        if (!pieza.hasData) return Container();
                                        if (!pieza.data!.exists)
                                          return Text("Pieza no existe.");
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("${pieza.data!['nombre']}"),
                                            Text(
                                                "Cantidad: ${solicitud['cantidad']}")
                                          ],
                                        );
                                      }),
                                  leading: const Icon(Icons.settings),
                                ),
                              )))
                          .toList(),
                    );
                  })),
        ],
      ),
    );
  }
}
