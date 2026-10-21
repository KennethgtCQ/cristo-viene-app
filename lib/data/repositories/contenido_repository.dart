import '../models/contenido.dart';

abstract class ContenidoRepository {
  Future<List<Evento>> eventos();
  Future<List<Predica>> predicas();
  Future<List<Ministerio>> ministerios();
  Future<Ministerio?> ministerio(String id);
  Future<List<Publicacion>> publicaciones();
  Future<Publicacion?> publicacion(String id);
  Future<List<Peticion>> peticiones();
  Future<List<Peticion>> misPeticiones();
  Future<void> crearPeticion({required String texto, required bool anonima});
  Future<List<Notificacion>> notificaciones();
}
