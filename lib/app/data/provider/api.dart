// @dart=2.9
import 'package:flutter/foundation.dart';
import 'package:shopend/app/domain/commands/_commands.dart';

enum Endpoint {
  masterProducto,
  posts,
  user_getAll,
  user_post,
  user_delete,
  user_put,
  user_getByEmail,
  user_getByNick,
  product_getAll,
  product_post,
  product_put,
  product_delete,
  hilo,
  hilo_getbyid,
  mensajes,
  mensaje,
  comprar,
  addFavorito
}

class API {
  API({@required this.hostUrl}) {
    _uriBase = Uri.parse(hostUrl);
  }

  final String hostUrl;
  Uri _uriBase;

  Uri tokenUri() => Uri(
        scheme: _uriBase.scheme,
        host: _uriBase.host,
        port: _uriBase.port,
        path: 'token',
      );

  Uri _createUri({@required String path}) {
    return Uri(
      scheme: _uriBase.scheme,
      host: _uriBase.host,
      port: _uriBase.port,
      path: path,
    );
  }

/*  Uri endpointUriCommand(Endpoint endpoint,String command CommandBase command ) {
    if (command is JournalStartCommand) {
      _createUri(path: '${_uriBase.path}${_paths[endpoint]}/${ejerId}/${socioId}',)
    }
  }*/
  Uri endpointUriMaster(Endpoint endpoint, {String id = null}) {
    //Si id==null, se quiere obtener todos los elementos
    String path =
        (id != null) ? '${_paths[endpoint]}/$id' : '${_paths[endpoint]}All';

    return Uri(
        scheme: _uriBase.scheme,
        host: _uriBase.host,
        port: _uriBase.port,
        path: '${_uriBase.path}$path');
  }

  Uri endpointUriMasterPrueba(Endpoint endpoint, {String id = null}) {
    //Si id==null, se quiere obtener todos los elementos
    String path =
        (id != null) ? '${_paths[endpoint]}/$id' : '${_paths[endpoint]}';

    return Uri(
        scheme: _uriBase.scheme,
        host: _uriBase.host,
        port: _uriBase.port,
        path: '${_uriBase.path}$path');
  }

  Uri endpointUriCommand(Endpoint endpoint,
      {CommandBase cmd,
      String fecha,
      double importe,
      int unidades,
      int id_usuario,
      int id_producto}) {
    String path = '${_uriBase.path}${_paths[endpoint]}/';

    return Uri(
        scheme: _uriBase.scheme,
        host: _uriBase.host,
        port: _uriBase.port,
        path: path);
  }

  Uri endpointUriComprar(Endpoint endpoint,
      {String fecha,
      double importe,
      int unidades,
      int id_usuario,
      int id_producto}) {
    String path = '${_uriBase.path}${_paths[endpoint]}';

    final Map<String, String> _queryParameters = <String, String>{
      'Fecha': fecha,
      'Id_Producto': id_producto.toString(),
      'Id_Usuario': id_usuario.toString(),
      'Importe': importe.toString(),
      'Unidades': unidades.toString()
    };

    return Uri(
        scheme: _uriBase.scheme,
        host: _uriBase.host,
        port: _uriBase.port,
        path: path,
        queryParameters: _queryParameters);
  }
  Uri endpointUriHiloMensaje(Endpoint endpoint, bool isMensaje,
      {String fecha, int id_Creador, String titulo, int id_Hilo}) {
    String path = '${_uriBase.path}${_paths[endpoint]}';
    Map<String, String> _queryParameters;
    if(!isMensaje){
    _queryParameters = <String, String>{
      'Fecha': fecha,
      'Id_Creador': id_Creador.toString(),
      'Titulo': titulo,
    };}else{
      _queryParameters = <String, String>{
        'Fecha': fecha,
        'Id_Creador': id_Creador.toString(),
        'Id_Hilo': id_Hilo.toString(),
      };
    }

    return Uri(
        scheme: _uriBase.scheme,
        host: _uriBase.host,
        port: _uriBase.port,
        path: path,
        queryParameters: _queryParameters);
  }

  Uri endpointUriId(Endpoint endpoint,bool isMensaje, {int id}) {
    String path = '${_uriBase.path}${_paths[endpoint]}';
    Map<String, String> _queryParameters;
    if(isMensaje){
    _queryParameters = <String, String>{
      'Id_Hilo': id.toString(),
    };}else{
      _queryParameters = <String, String>{
        'Id_Usuario': id.toString(),
      };
    }

    return Uri(
        scheme: _uriBase.scheme,
        host: _uriBase.host,
        port: _uriBase.port,
        path: path,
        queryParameters: _queryParameters);
  }

  Uri endpointUriFavorito(Endpoint endpoint,
      {int id_usuario, int id_producto}) {
    String path = '${_uriBase.path}${_paths[endpoint]}';

    final Map<String, String> _queryParameters = <String, String>{
      'id_Producto': id_producto.toString(),
      'id_Usuario': id_usuario.toString()
    };

    return Uri(
        scheme: _uriBase.scheme,
        host: _uriBase.host,
        port: _uriBase.port,
        path: path,
        queryParameters: _queryParameters);
  }

  static Map<Endpoint, String> _paths = {
    Endpoint.masterProducto: 'master/producto/',
    Endpoint.posts: 'todos/',
    Endpoint.user_getAll: 'latiendadelinfinito/user/getAll',
    Endpoint.user_post: 'latiendadelinfinito/user',
    Endpoint.user_delete: 'latiendadelinfinito/user/delete',
    Endpoint.user_getByEmail: 'latiendadelinfinito/user/email',
    Endpoint.user_getByNick: 'latiendadelinfinito/user/nick',
    Endpoint.user_put: 'latiendadelinfinito/user/update',
    Endpoint.product_getAll: 'latiendadelinfinito/product/getAll',
    Endpoint.product_post: 'latiendadelinfinito/product',
    Endpoint.product_put: 'latiendadelinfinito/product/update',
    Endpoint.product_delete: 'latiendadelinfinito/product/delete',
    Endpoint.comprar: 'latiendadelinfinito/shop/buy',
    Endpoint.addFavorito: 'latiendadelinfinito/shop/fav',
    Endpoint.hilo: 'latiendadelinfinito/foro/hilo',
    Endpoint.hilo_getbyid: 'latiendadelinfinito/foro/hilo/get',
    Endpoint.mensajes: 'latiendadelinfinito/foro/hilo/mensajes',
    Endpoint.mensaje: 'latiendadelinfinito/foro/hilo/mensaje',

  };
}
