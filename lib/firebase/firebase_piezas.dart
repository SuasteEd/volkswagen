import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireStorePiezas {
  final CollectionReference _maquinaCollection =
      FirebaseFirestore.instance.collection('maquinas');
  Stream<QuerySnapshot<Object?>> getAll() {
    return _maquinaCollection.snapshots();
  }

  Stream<DocumentSnapshot<Object?>> get(String id) {
    return _maquinaCollection.doc(id).snapshots();
  }
  /*get mensajes {
    return chatCollection
        .doc(userid)
        .collection('mensajes')
        .where('visto', isEqualTo: 0)
        .where('emisor', isEqualTo: 'v')
        .snapshots();
  }*/

  //////////////////////////////
}
