// @dart=2.9
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:shopend/app/common/GeneralToast.dart';
import 'package:shopend/app/common/constants.dart';
import 'package:shopend/app/data/repository/_repositorys.dart';
import 'package:shopend/app/domain/model/_models.dart';
import 'package:shopend/app/ui/widgets/indicator/loading_indicator.dart';

import '../../../locator.dart';

class RegistrarProducto extends StatefulWidget {
  RegistrarProducto();

  @override
  RegistrarProductoState createState() => RegistrarProductoState();
}

class RegistrarProductoState extends State<RegistrarProducto> {
  ProductRepository _repoProduct = locator<ProductRepository>();
  FirebaseStorage storageReference = FirebaseStorage.instance;
  DocumentReference sightingRef = Firestore.instance.collection("TDI").doc();
  Producto _product;
  Producto _comprobar_product;
  final descripcion = TextEditingController();
  final nombre = TextEditingController();
  final precio = TextEditingController();
  final stockDisponible = TextEditingController();
  final url_imagen = TextEditingController();
  bool _isloading = false;
  bool _isError = false;
  bool _isValidatebad = false;
  File _image = null;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    descripcion.dispose();
    nombre.dispose();
    precio.dispose();
    stockDisponible.dispose();
    url_imagen.dispose();
    super.dispose();
  }

  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile;
    if (gallery) {
      pickedFile = await picker.getImage(
        source: ImageSource.gallery,
      );
    } else {
      pickedFile = await picker.getImage(
        source: ImageSource.camera,
      );
    }
    setState(() {
      if (pickedFile != null) {
/*        _images.add(File(pickedFile.path));*/
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        print('Imagen no seleccionada.');
      }
    });
  }

  Future<String> uploadFile(File _image) async {
    storageReference.ref().child('TDI/${p.basename(_image.path)}');
    StorageUploadTask uploadTask = storageReference
        .ref()
        .child('TDI/${p.basename(_image.path)}')
        .putFile(_image);
    await uploadTask.onComplete;
    print('Archivo Subido.');
    String returnURL;
    await storageReference
        .ref()
        .child('TDI/${p.basename(_image.path)}')
        .getDownloadURL()
        .then((fileURL) {
      returnURL = fileURL;
    });
    return returnURL;
  }

  Future<void> _saveImage(File _image, DocumentReference ref) async {
    String imageURL = await uploadFile(_image);
    setState(() {
      url_imagen.text = imageURL;
    });
    ref.update({
      "images": FieldValue.arrayUnion([imageURL])
    });
  }

  void _subirProducto() {
    if (!_isValidatebad) {
      _saveImage(_image, sightingRef)
          .then((value) => _subirProductoBD())
          .catchError((Object error) {
        SuccessToast(
            "Ha ocurrido un error al subir la imagen, por favor vuelve a subirla.");
        return error;
      });
    } else {
      setState(() {
        _isloading = false;
        _isError = true;
      });
    }
  }

  void _subirProductoBD() {
    final producto = Producto(
        descripcion: descripcion.text,
        nombre: nombre.text,
        precio: precio.text,
        stockDisponible: int.parse(stockDisponible.text),
        fechaCreacion: DateTime.now(),
        imagen: url_imagen.text);
    _repoProduct
        .postProduct(producto: producto)
        .then((product) => setState(() {
              _product = product;
              _isloading = false;
            }))
        .then((value) => SuccessToast('Producto añadido correctamente.'))
        .then((value) => Navigator.pop(context))
        .catchError((Object error) {
      SuccessToast('Ocurrio un error al añadir el producto, revise los datos.');
      return error;
    });
  }

  void _comprobar_Campos() {
    setState(() {
      _isloading = true;
      _isError = false;
      descripcion.text.isEmpty ||
              nombre.text.isEmpty ||
              precio.text.isEmpty ||
              stockDisponible.text.isEmpty
          ? _isValidatebad = true
          : _isValidatebad = false;
    });
    _subirProducto();
  }

  Widget _buildFotoPerfilshow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
              width: 200,
              height: 200,
              child: Image.file(
                _image,
                fit: BoxFit.contain,
              )),
        ],
      ),
    );
  }

  Widget _buildFotoPerfil() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Foto Perfil: ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text('Galería'),
                color: Color.fromRGBO(240, 165, 165, 4.0),
                hoverColor: Color.fromRGBO(246, 237, 203, 4.0),
                onPressed: () {
                  getImage(true);
                },
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text('Cámara'),
                color: Color.fromRGBO(240, 165, 165, 4.0),
                hoverColor: Color.fromRGBO(246, 237, 203, 4.0),
                onPressed: () {
                  getImage(false);
                },
              ),
            ],
          )
        ]);
  }

  Widget _buildDescripcion() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
          Column(children: <Widget>[
            Text('Descripción: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ]),
          Column(children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              child: Text('*',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
            ),
          ]),
        ]),
        SizedBox(height: 10.0),
        Container(
          width: 500.0,
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: descripcion,
            style: TextStyle(color: Colors.black, fontFamily: 'OpenSans'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 15.0),
              prefixIcon: Icon(
                Icons.description,
                color: Colors.black,
              ),
              hintText: 'Descripción',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
        _isValidatebad && descripcion.text.isEmpty
            ? Text('Campo obligatorio.',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red))
            : SizedBox(height: 0),
      ],
    );
  }

  Widget _buildNombre() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
          Column(children: <Widget>[
            Text('Nombre: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ]),
          Column(children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              child: Text('*',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
            ),
          ]),
        ]),
        SizedBox(height: 10.0),
        Container(
          width: 500.0,
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: nombre,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.text_fields,
                color: Colors.black,
              ),
              hintText: 'Nombre',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
        _isValidatebad && nombre.text.isEmpty
            ? Text('Campo obligatorio.',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red))
            : SizedBox(height: 0),
      ],
    );
  }

  Widget _buildPrecio() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
          Column(children: <Widget>[
            Text('Precio: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ]),
          Column(children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              child: Text('*',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
            ),
          ]),
        ]),
        SizedBox(height: 10.0),
        Container(
          width: 500.0,
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: precio,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.euro,
                color: Colors.black,
              ),
              hintText: 'Precio',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
        _isValidatebad && precio.text.isEmpty
            ? Text('Campo obligatorio.',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red))
            : SizedBox(height: 0),
      ],
    );
  }

  Widget _buildStockDisponible() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
          Column(children: <Widget>[
            Text('Stock Disponible: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ]),
          Column(children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              child: Text('*',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
            ),
          ]),
        ]),
        SizedBox(height: 10.0),
        Container(
          width: 500.0,
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: stockDisponible,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.house_sharp,
                color: Colors.black,
              ),
              hintText: 'Stock Disponible',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
        _isValidatebad && stockDisponible.text.isEmpty
            ? Text('Campo obligatorio.',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red))
            : SizedBox(height: 0),
      ],
    );
  }

  Widget _buildObligatorio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('* OBLIGATORIO',
            style: TextStyle(
              color: Colors.red,
              fontFamily: 'OpenSans',
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(180, 226, 248, 4.0),
        appBar: AppBar(
          title: Image.asset('assets/images/Logo.png',
              fit: BoxFit.cover, width: 170.0, height: 230.0),
          centerTitle: true,
        ),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF61A4A6),
                Color(0xFF61A4D8),
                Color(0xFF11FAD1),
                Color(0xFF398AE5),
              ],
              stops: [0.1, 0.4, 0.7, 0.9],
            ),
          ),
          child: _isloading
              ? Center(
                  child: LoadingIndicator(),
                )
              : SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 30.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Registro de producto',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildObligatorio(),
                      SizedBox(height: 20.0),
                      _image != null
                          ? _buildFotoPerfilshow()
                          : SizedBox(
                              height: 0,
                            ),
                      SizedBox(height: 20.0),
                      _buildFotoPerfil(),
                      _buildNombre(),
                      SizedBox(height: 20.0),
                      _buildDescripcion(),
                      _buildPrecio(),
                      _buildStockDisponible(),
                      SizedBox(height: 20.0),
                      _isError
                          ? Text('ERROR, comprueba los datos.',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red))
                          : SizedBox(height: 0),
                      SizedBox(height: 20.0),
                      RaisedButton(
                        padding: EdgeInsets.all(20.0),
                        color: Color.fromRGBO(240, 165, 165, 4.0),
                        hoverColor: Color.fromRGBO(246, 237, 203, 4.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "Añadir producto",
                          style: TextStyle(
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        onPressed: () {
                          _comprobar_Campos();
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                      ),
                      RaisedButton(
                        padding: EdgeInsets.all(20.0),
                        color: Color.fromRGBO(240, 165, 165, 4.0),
                        hoverColor: Color.fromRGBO(246, 237, 203, 4.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "Volver",
                          style: TextStyle(
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
        ));
  }
}
