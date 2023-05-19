import 'package:flutter/material.dart';

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
            color: Colors.amber,
          )),
          Expanded(
            flex: 8,
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Item $index'),
                      subtitle: Text('Subtitulo $index'),
                      leading: const Icon(Icons.build),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        showAboutDialog(
                          context: context,
                        );
                      },
                    ),
                  );
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
            color: Colors.amber,
          )),
          Expanded(
            flex: 8,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text('Item $index'),
                    subtitle: Text('Subtitulo $index'),
                    leading: const Icon(Icons.person),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
