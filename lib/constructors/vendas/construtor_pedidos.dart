class ListaPedidos {
  int id;
  String dataVenda;
  String horaVenda;
  int idCliente;
  String clienteNome;
  String vendedorNome;
  String fpagtoDescricao;
  dynamic totBruto;
  dynamic totDescPrc;
  dynamic totDescVlr;
  dynamic totLiquido;

  ListaPedidos(
      this.id,
      this.dataVenda,
      this.horaVenda,
      this.idCliente,
      this.clienteNome,
      this.vendedorNome,
      this.fpagtoDescricao,
      this.totBruto,
      this.totDescPrc,
      this.totDescVlr,
      this.totLiquido);
}
