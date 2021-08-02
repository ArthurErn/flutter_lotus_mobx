import 'dart:convert';
//CONSTRUTOR DO LOGIN
List<BuilderApi> builderApiFromMap(String str) => List<BuilderApi>.from(json.decode(str).map((x) => BuilderApi.fromMap(x)));

String builderApiToMap(List<BuilderApi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class BuilderApi {
    BuilderApi({
        this.id,
        this.razao,
        this.fantasia,
        this.cnpj,
        this.versaoLiberacao,
        this.tipoOs,
        this.ramo,
        this.versao,
        this.codigoDescricao,
    });

    final int id;
    final String razao;
    final String fantasia;
    final String cnpj;
    final String versaoLiberacao;
    final int tipoOs;
    final String ramo;
    final String versao;
    final String codigoDescricao;

    factory BuilderApi.fromMap(Map<String, dynamic> json) => BuilderApi(
        id: json["id"],
        razao: json["razao"],
        fantasia: json["fantasia"],
        cnpj: json["cnpj"],
        versaoLiberacao: json["versao_liberacao"],
        tipoOs: json["tipo_os"],
        ramo: json["ramo"],
        versao: json["versao"],
        codigoDescricao: json["codigo_descricao"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "razao": razao,
        "fantasia": fantasia,
        "cnpj": cnpj,
        "versao_liberacao": versaoLiberacao,
        "tipo_os": tipoOs,
        "ramo": ramo,
        "versao": versao,
        "codigo_descricao": codigoDescricao,
    };
}
