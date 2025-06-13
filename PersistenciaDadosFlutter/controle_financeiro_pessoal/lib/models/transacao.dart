class Transacao {
  int? id;
  int idCategoria;
  double valor;
  String descricao;
  String data;
  String tipo; // 'receita' ou 'despesa'

  Transacao({
    this.id,
    required this.idCategoria,
    required this.valor,
    required this.descricao,
    required this.data,
    required this.tipo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idCategoria': idCategoria,
      'valor': valor,
      'descricao': descricao,
      'data': data,
      'tipo': tipo,
    };
  }

  factory Transacao.fromMap(Map<String, dynamic> map) {
    return Transacao(
      id: map['id'],
      idCategoria: map['idCategoria'],
      valor: map['valor'],
      descricao: map['descricao'],
      data: map['data'],
      tipo: map['tipo'],
    );
  }
}
