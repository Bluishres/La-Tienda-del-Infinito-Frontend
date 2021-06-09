// @dart=2.9
import 'package:flutter/material.dart';
import 'package:shopend/app/common/GeneralToast.dart';
import 'package:shopend/app/common/constants.dart';
import 'package:shopend/app/data/repository/_repositorys.dart';
import 'package:shopend/app/domain/model/_models.dart';
import 'package:shopend/app/locator.dart';
import 'package:shopend/app/ui/widgets/indicator/loading_indicator.dart';

class DetalleProducto extends StatefulWidget {
  final Producto producto;
  final Usuario getUsuarioActivo;

  const DetalleProducto({Key key, this.producto, this.getUsuarioActivo})
      : super(key: key);

  @override
  _DetalleProductoState createState() => _DetalleProductoState();
}

class _DetalleProductoState extends State<DetalleProducto> {
  Producto _producto;
  double _screenWidth;
  Usuario _userActivo;
  Usuario _getUsuarioActivo;
  TiendaRepository _repoTienda = locator<TiendaRepository>();
  ProductRepository _repoProduct = locator<ProductRepository>();
  Ticket _ticket;
  ListaUsuariosDeseado _favorito;
  bool _isloading = false;

  @override
  void initState() {
    super.initState();
    _producto = Producto(
        descripcion: widget.producto.descripcion,
        nombre: widget.producto.nombre,
        precio: widget.producto.precio,
        stockDisponible: widget.producto.stockDisponible,
        fechaCreacion: widget.producto.fechaCreacion,
        imagen: widget.producto.imagen,
        id: widget.producto.id);
    _getUsuarioActivo = widget.getUsuarioActivo;
    _userActivo = _getUsuarioActivo;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenWidth = MediaQuery.of(context).size.width;
  }

  void ActualizarStock(Ticket ticket) {
    final productoNuevo = Producto(
        descripcion: _producto.descripcion,
        nombre: _producto.nombre,
        precio: _producto.precio,
        stockDisponible: _producto.stockDisponible - 1,
        fechaCreacion: _producto.fechaCreacion,
        imagen: _producto.imagen,
        id: _producto.id);
    _repoProduct.putProduct(producto: productoNuevo).then((value) =>
        SuccessToast('Has comprado este producto correctamente.'))
        .then((value) => Navigator.pop(context)).catchError((Object error) {
      setState(() {
        _isloading = false;
      });
      SuccessToast('Error al actualizar este producto.');
      return error;
    });
  }

  void comprar() {
       setState(() {
         _isloading = true;
       });
       _repoTienda.Comprar(
               fecha: DateTime.now().toString(),
               importe: double.parse(_producto.precio),
               unidades: 1,
               id_producto: _producto.id,
               id_usuario: _userActivo.id)
           .then((ticket) => setState(() {
                 _ticket = ticket;
                 _isloading = false;
               }))
           .then((value) => ActualizarStock(_ticket))
           .catchError((Object error) {
         setState(() {
           _isloading = false;
         });
         SuccessToast('Error al comprar este producto.');
         return error;
       });
     }

     void addFavorito() {
         setState(() {
           _isloading = true;
         });
         _repoTienda.addFavorito(
                 id_producto: _producto.id,
                 id_usuario: _userActivo.id)
             .then((favorito) => setState(() {
                   _favorito = favorito;
                   _isloading = false;
                 })).then((value) => SuccessToast('Añadido a favorito correctamente.'))
             .catchError((Object error) {
           setState(() {
             _isloading = false;
           });
           SuccessToast('Error al añadir a favorito este producto.');
           return error;
         });
       }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_producto.nombre}'),
        backgroundColor: Colors.white,
      ),
      body: _isloading
          ? Center(
              child: LoadingIndicator(),
            )
          : SafeArea(
              child: Stack(
                children: <Widget>[
                  Hero(
                    tag: 'background' + _producto.nombre,
                    child: Container(
                      color: KColor,
                    ),
                  ),
                  Positioned(
                      top: 12.0,
                      left: 0.0,
                      width: _screenWidth,
                      height: 230.0,
                      child: Hero(
                          tag: 'image' + _producto.nombre,
                          child: Image.network(
                            _producto.imagen,
                            fit: BoxFit.contain,
                          ))),
                  Positioned(
                      top: 250.0,
                      left: 32.0,
                      width: _screenWidth - 64,
                      child: Hero(
                          tag: 'text' + _producto.nombre,
                          child: Material(
                              color: Colors.transparent,
                              child: Text(
                                '${_producto.nombre}',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )))),
                  Positioned(
                      top: 450.0,
                      left: 240,
                      width: _screenWidth - 64,
                      child: Hero(
                          tag: 'price' + _producto.nombre,
                          child: Material(
                              color: Colors.transparent,
                              child: Text(_producto.precio + "€",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 40.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))))),
                  Positioned(
                      top: 310.0,
                      left: 32.0,
                      width: _screenWidth - 64,
                      child: Hero(
                          tag: 'subtitle' + _producto.nombre,
                          child: Material(
                              color: Colors.transparent,
                              child: Text(
                                _producto.descripcion,
                              )))),
                  _userActivo != null
                      ? Positioned(
                          top: 550.0,
                          left: 32.0,
                          width: _screenWidth - 64,
                          child: RaisedButton(
                            color: Color.fromRGBO(240, 165, 165, 4.0),
                            hoverColor: Color.fromRGBO(246, 237, 203, 200.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "Comprar",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            onPressed: () {
                              comprar();
                            },
                          ))
                      : Positioned(
                          top: 525.0,
                          left: 32.0,
                          width: _screenWidth - 64,
                          child: Text(
                              "Debes estar registrado para comprar un producto.",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 18),
                              textAlign: TextAlign.center)),
                  _userActivo != null
                      ? Positioned(
                          top: 500.0,
                          left: 32.0,
                          width: _screenWidth - 64,
                          child: RaisedButton(
                            color: Color.fromRGBO(240, 165, 165, 4.0),
                            hoverColor: Color.fromRGBO(246, 237, 203, 200.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "Añadir a la lista de deseados",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            onPressed: () {addFavorito();},
                          ))
                      : SizedBox(width: 0),
                  Positioned(
                      top: 480.0,
                      left: 40.0,
                      width: _screenWidth - 64,
                      child: Hero(
                          tag: 'stock' + _producto.nombre,
                          child: Row(children: <Widget>[
                            Column(
                              children: [
                                Text(
                                  'Stock Disponible: ',
                                  style: TextStyle(
                                      fontFamily: "OpenSans",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  _producto.stockDisponible.toString(),
                                  style: TextStyle(
                                      fontFamily: "OpenSans",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                          ])))
                ],
              ),
            ),
    );
  }
}
