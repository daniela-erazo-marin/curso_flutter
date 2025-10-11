/// Modelo para representar un CDT con información bancaria
class CDT {
  String nombreEntidad;
  String descripcion;
  double tasa;
  double monto;

  // Constructor de la clase CDT con los atributos requeridos
  CDT({
    required this.nombreEntidad,
    required this.descripcion,
    required this.tasa,
    required this.monto,
  });

  // Factory para convertir un JSON en una instancia de CDT
  factory CDT.fromJson(Map<String, dynamic> json) {
    return CDT(
      nombreEntidad: json['nombreentidad'],
      descripcion: json['descripcion'],
      tasa: double.parse(json['tasa'].toString()),
      monto: double.parse(json['monto'].toString()),
    );
  }
}
