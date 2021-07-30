class ProdutoOS {
  int item;
  int idProduto;
  String produtoNome;
  String unidade;
  String refFabrica;
  String gtin;
  int servico;
  String complemento;
  dynamic vlrVendido;
  int qtde;
  dynamic vlrBruto;
  dynamic vlrDescPrc;
  dynamic vlrDescVlr;
  dynamic vlrLiquido;
  int idTecnico;
  String tecnicoNome;

  ProdutoOS(
      this.item,
      this.idProduto,
      this.produtoNome,
      this.unidade,
      this.refFabrica,
      this.gtin,
      this.servico,
      this.complemento,
      this.vlrVendido,
      this.qtde,
      this.vlrBruto,
      this.vlrDescPrc,
      this.vlrDescVlr,
      this.vlrLiquido,
      this.idTecnico,
      this.tecnicoNome);
}
