//CONSTRUTOR PRODUTOS DO BALANÇO E DA CONSULTA

class Produtos {
  // ignore: non_constant_identifier_names
  dynamic id_empresa;
  // ignore: non_constant_identifier_names
  dynamic id_produto;
  // ignore: non_constant_identifier_names
  String id_produto_formatado;
  String descricao;
  String unidade;
  // ignore: non_constant_identifier_names
  String ref_fabrica;
  String gtin;
  // ignore: non_constant_identifier_names
  String fabricante_nome;
  // ignore: non_constant_identifier_names
  dynamic produto_pcompra;
  // ignore: non_constant_identifier_names
  dynamic produto_pcusto;
  // ignore: non_constant_identifier_names
  dynamic produto_pvenda;
  // ignore: non_constant_identifier_names
  dynamic produto_saldo;
  // ignore: non_constant_identifier_names
  dynamic grupo_id;
  // ignore: non_constant_identifier_names
  String grupo_descricao;
  dynamic servico;

  Produtos(
      this.id_empresa,
      this.id_produto,
      this.id_produto_formatado,
      this.descricao,
      this.unidade,
      this.ref_fabrica,
      this.gtin,
      this.fabricante_nome,
      this.produto_pcompra,
      this.produto_pcusto,
      this.produto_pvenda,
      this.produto_saldo,
      this.grupo_id,
      this.grupo_descricao,
      this.servico);
}
