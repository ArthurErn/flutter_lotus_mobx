//PRODUTOS DE UM BALANÇO
class ProdutosBalanco {
  dynamic idBalanco;
  dynamic idProduto;
  String descricao;
  String refFabrica;
  String gtin;
  dynamic saldoNovo;
  dynamic saldoAnterior;
  dynamic vlrCusto;
  dynamic vlrCompra;
  dynamic vlrVenda;
  String grade;

  ProdutosBalanco(
      this.idBalanco,
      this.idProduto,
      this.descricao,
      this.refFabrica,
      this.gtin,
      this.saldoNovo,
      this.saldoAnterior,
      this.vlrCusto,
      this.vlrCompra,
      this.vlrVenda,
      this.grade);
}
