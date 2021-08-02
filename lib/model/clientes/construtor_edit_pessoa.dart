//CONSTRUTOR DE CLIENTE, SERVE TANTO PARA CADASTRO QUANTO PARA EDIÇÃO (MESMA ROTA)
class EditPessoa {
  int id;
  int tpPessoa;
  String cpfCnpj;
  String rgInsc;
  String nomeRazao;
  String apelidoFantasia;
  String fone1;
  String fone2;
  String fone3;
  String endereco;
  String enderecoNumero;
  String bairro;
  int municipioId;
  String municipioNome;
  String municipioEstado;
  int statusId;
  String statusNome;
  String cep;
  String complemento;
  String email;
  String statusBloqueado;

  EditPessoa(
      this.id,
      this.tpPessoa,
      this.cpfCnpj,
      this.rgInsc,
      this.nomeRazao,
      this.apelidoFantasia,
      this.fone1,
      this.fone2,
      this.fone3,
      this.endereco,
      this.enderecoNumero,
      this.bairro,
      this.municipioId,
      this.municipioNome,
      this.municipioEstado,
      this.statusId,
      this.statusNome,
      this.cep,
      this.complemento,
      this.email,
      this.statusBloqueado);
}
