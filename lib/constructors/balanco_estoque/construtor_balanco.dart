//CONSTRUTOR DO BALANÇO
class Balanco {
  int id;
  String data;
  String balanco_motivo;

  Balanco(this.id, this.data, this.balanco_motivo);

  Balanco.fromMap(Map map)
      : this.id = map['id'],
        this.data = map['data'],
        this.balanco_motivo = map['balanco_motivo'];

  Map toMap() {
    return {
      'id': this.id,
      'data': this.data,
      'balanco_motivo': this.balanco_motivo
    };
  }
}
