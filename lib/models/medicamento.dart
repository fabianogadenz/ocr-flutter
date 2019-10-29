class Medicamento {
  int id;
  String nome;
  String principiosAtivos;
  String contraIndicacoes;
  String tipoMedicamento;
  String data;

  Medicamento(
      {this.id,
        this.nome,
        this.principiosAtivos,
        this.contraIndicacoes,
        this.tipoMedicamento,
        this.data});

  Medicamento.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    principiosAtivos = json['principios_ativos'];
    contraIndicacoes = json['contra_indicacoes'];
    tipoMedicamento = json['tipo_medicamento'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['principios_ativos'] = this.principiosAtivos;
    data['contra_indicacoes'] = this.contraIndicacoes;
    data['tipo_medicamento'] = this.tipoMedicamento;
    data['data'] = this.data;
    return data;
  }
}