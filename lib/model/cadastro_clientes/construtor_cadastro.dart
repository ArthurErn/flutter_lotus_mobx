//CONSTRUTOR DO RETORNO DA API RECEITAWS QUE PEDE CNPJ
//PARA RETORNAR CEP, LOGRADOURO, NUMERO, BAIRRO E COMPLEMENTO
class Cnpj {
  dynamic cep;
  String logradouro;
  String numero;
  String bairro;
  String complemento;

  Cnpj(this.cep, this.logradouro, this.numero, this.bairro, this.complemento);
}
