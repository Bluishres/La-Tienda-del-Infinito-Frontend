// @dart=2.9
import 'package:flutter/material.dart';
import 'package:shopend/app/common/GeneralToast.dart';
import 'package:shopend/app/data/repository/_repositorys.dart';
import 'package:shopend/app/domain/model/_models.dart';
import 'package:shopend/app/locator.dart';
import 'package:shopend/app/ui/widgets/indicator/loading_indicator.dart';

import 'Componentes/CustomAppBar.dart';
import 'Componentes/body.dart';

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
  int _cantidad = 1;

  void Actualizarcantidad(int cantidad) {
    setState(() {
      _cantidad = cantidad;
    });
  }

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
    _repoProduct
        .putProduct(producto: productoNuevo)
        .then((value) =>
            SuccessToast('Has comprado este producto correctamente.'))
        .then((value) => Navigator.pop(context))
        .catchError((Object error) {
      setState(() {
        _isloading = false;
      });
      SuccessToast('Error al actualizar este producto.');
      return error;
    });
  }

  void retirarProducto() {
    setState(() {
      _isloading = true;
    });
    _repoProduct
        .deleteProduct(id: _producto.id)
        .then((ticket) => setState(() {
              _isloading = false;
            }))
        .then((value) => SuccessToast("Producto eliminado."))
        .then((value) => Navigator.pop(context))
        .catchError((Object error) {
      setState(() {
        _isloading = false;
      });
      SuccessToast('Error al comprar este producto.');
      return error;
    });
  }

  void comprar() {
    setState(() {
      _isloading = true;
    });
    _repoTienda.Comprar(
            fecha: DateTime.now().toString(),
            importe: (double.parse(_producto.precio) * _cantidad),
            unidades: _cantidad,
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
    _repoTienda
        .addFavorito(id_producto: _producto.id, id_usuario: _userActivo.id)
        .then((favorito) => setState(() {
              _favorito = favorito;
              _isloading = false;
            }))
        .then((value) => SuccessToast('Añadido a favorito correctamente.'))
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
      backgroundColor: Color.fromRGBO(194, 232, 248, 4.0),
      appBar: CustomAppBar(),
      body: _isloading
          ? Center(
              child: LoadingIndicator(),
            )
          : Body(
              product: _producto,
              Actualizarcantidad: Actualizarcantidad,
              Comprar: comprar,
              userActivo: _userActivo,
              Addfavorito: addFavorito,
              Retirarproducto: retirarProducto,
            ),
    );
  }
}
