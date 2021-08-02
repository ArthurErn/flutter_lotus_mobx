class ListVenda {
  int idVenda;
  int item;
  int idProduto;
  String produtoDescricao;
  String unidade;
  String refFabrica;
  String gtin;
  dynamic vlrVendido;
  int qtde;
  dynamic vlrBruto;
  dynamic vlrDescPrc;
  dynamic vlrDescVlr;
  dynamic vlrLiquido;
  String grade;
  dynamic vlrVendidoOriginal;
  String complemento;

  ListVenda(
      this.idVenda,
      this.item,
      this.idProduto,
      this.produtoDescricao,
      this.unidade,
      this.refFabrica,
      this.gtin,
      this.vlrVendido,
      this.qtde,
      this.vlrBruto,
      this.vlrDescPrc,
      this.vlrDescVlr,
      this.vlrLiquido,
      this.grade,
      this.vlrVendidoOriginal,
      this.complemento);
}
