import 'package:flutter/foundation.dart';
import 'package:shopend/app/domain/commands/_commands.dart';

enum Endpoint {
  masterProducto,
  posts,
}

class API {
  API({@required this.hostUrl}){
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
  Uri endpointUriMaster(Endpoint endpoint,{String id=null}) {
    //Si id==null, se quiere obtener todos los elementos
    String path = (id!=null)
    ? '${_paths[endpoint]}/$id'
    : '${_paths[endpoint]}All';

    return Uri(
        scheme: _uriBase.scheme,
        host: _uriBase.host,
        port: _uriBase.port,
        path: '${_uriBase.path}$path');
  }

  Uri endpointUriMasterPrueba(Endpoint endpoint,{String id=null}) {
    //Si id==null, se quiere obtener todos los elementos
    String path = (id!=null)
        ? '${_paths[endpoint]}/$id'
        : '${_paths[endpoint]}';

    return Uri(
        scheme: _uriBase.scheme,
        host: _uriBase.host,
        port: _uriBase.port,
        path: '${_uriBase.path}$path');
  }

  Uri endpointUriCommand(Endpoint endpoint,{CommandBase cmd}) {

    String path = '${_uriBase.path}${_paths[endpoint]}/${cmd.methodName}';

    return Uri(
        scheme: _uriBase.scheme,
        host: _uriBase.host,
        port: _uriBase.port,
        path: path);
  }

  static Map<Endpoint, String> _paths = {
    Endpoint.masterProducto: 'master/producto/',
    Endpoint.posts: 'todos/',

  };
}