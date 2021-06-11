// @dart=2.9
import 'package:shopend/app/domain/model/_models.dart';

abstract class TiendaRepository {
  /// Comprar
  Future<Ticket> Comprar(
      {String fecha,
      double importe,
      int unidades,
      int id_usuario,
      int id_producto});

  /// Consultar tickets
  Future<List<Ticket>> getAllTickets();

  /// Consultar tickets de un usuario
  Future<List<Ticket>> getAllticketsByUser({int id_user});

  /// añadir favorito
  Future<ListaUsuariosDeseado> addFavorito({int id_usuario, int id_producto});

  /// consultar favoritos
  Future<List<ListaUsuariosDeseado>> getAllFavoritos();

  /// Consultar favoritos por usuario
  Future<List<ListaUsuariosDeseado>> getAllfavoritossByUser({int id_user});
}
