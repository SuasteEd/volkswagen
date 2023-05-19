import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:team_prot1/firebase/firebase_piezas.dart';
import 'package:team_prot1/firebase/firebase_solicitudes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const Tools(),
    const Materials(),
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
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Image.asset('assets/logo.png', width: 200, height: 200),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: const Text('Confirmar'),
                  leading: const Icon(Icons.person),
                  onTap: () {
                    Navigator.of(context).pushNamed('second');
                  },
                ),
              ],
            ),
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
              label: 'Herramientas',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'Materiales'),
          ],
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: _children,
        ));
  }
}

class Tools extends StatelessWidget {
  const Tools({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            flex: 8,
            child: StreamBuilder(
                stream: FireStorePiezas().getAllHerramientas(),
                builder: (context, snapshot) {
                  if (snapshot.hasError)
                    return Text("No se pudo obtener información.");
                  if (!snapshot.hasData) return Container();
                  return ListView(
                      children: snapshot.data!.docs.map((e) {
                    return Card(
                      child: ListTile(
                        title: Text('Id: ${e.id}'),
                        subtitle: Text('${e["nombre"]}'),
                        leading: const Icon(Icons.build),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          var controller = TextEditingController();
                          showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    // child: Container(
                                    //   width: 400,
                                    //   height: 600,
                                    //   decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(20),
                                    //   ),
                                    // ),
                                    child: SizedBox(
                                      width: 400,
                                      height: 600,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            e["nombre"],
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "¿Cuántos se requieren?",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.black54),
                                                ),
                                                TextField(
                                                  controller: controller,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          MaterialButton(
                                            onPressed: () {
                                              FireStoreSolicitudes().create(
                                                  int.tryParse(
                                                          controller.text) ??
                                                      0,
                                                  "1",
                                                  "",
                                                  e.id);
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Enviar",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.blue),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                        },
                      ),
                    );
                  }).toList());
                }),
          ),
        ],
      ),
    );
  }
}

class Materials extends StatelessWidget {
  const Materials({Key? key}) : super(key: key);

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
            flex: 8,
            child: StreamBuilder(
                stream: FireStorePiezas().getAllMaterial(),
                builder: (context, snapshot) {
                  if (snapshot.hasError)
                    return Text("No se pudo obtener información.");
                  if (!snapshot.hasData) return Container();
                  return ListView(
                      children: snapshot.data!.docs.map((e) {
                    return Card(
                      child: ListTile(
                        title: Text('Id: ${e.id}'),
                        subtitle: Text('${e["nombre"]}'),
                        leading: const Icon(Icons.build),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          var controller = TextEditingController();
                          showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    // child: Container(
                                    //   width: 400,
                                    //   height: 600,
                                    //   decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(20),
                                    //   ),
                                    // ),
                                    child: SizedBox(
                                      width: 400,
                                      height: 600,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            e["nombre"],
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "¿Cuántos se requieren?",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.black54),
                                                ),
                                                TextField(
                                                  controller: controller,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          MaterialButton(
                                            onPressed: () {
                                              FireStoreSolicitudes().create(
                                                  int.tryParse(
                                                          controller.text) ??
                                                      0,
                                                  "1",
                                                  "",
                                                  e.id);
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Enviar",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.blue),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                        },
                      ),
                    );
                  }).toList());
                }),
          ),
        ],
      ),
    );
  }
}
