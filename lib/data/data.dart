import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:tcc_fabiano/models/medicamento.dart';
import 'package:tcc_fabiano/utils.dart';

class Data {
  Future<List<Medicamento>> buscaMedicamentos(context) async {
    List<Medicamento> medicamentos = [];
    String data = await DefaultAssetBundle.of(context).loadString("assets/remedios.json");
    final jsonResult = json.decode(data);

    for (var u in jsonResult["medicamentos"]) medicamentos.add(new Medicamento.fromJson(u));

    return medicamentos;
  }

  Future<List<Medicamento>> buscaMedicamentoIgual(List<String> resultados, context) async {
    List<Medicamento> medicamentos = await buscaMedicamentos(context);
    List<Medicamento> medicamentos_encontrados = [];
    Utils util = new Utils();
    for (var resultado in resultados) {
      if (util.igualMedicamento(resultado, medicamentos) != null) {
        medicamentos_encontrados.add(util.igualMedicamento(resultado, medicamentos));
      }
    }
    print("buscaMedicamentoIgual " + medicamentos_encontrados.length.toString());
    return medicamentos_encontrados;
  }

  Future<List<Medicamento>> buscaMedicamentoEsq(List<String> resultados, context) async {
    List<Medicamento> medicamentos = await buscaMedicamentos(context);
    List<Medicamento> medicamentos_encontrados = [];
    Utils util = new Utils();
    for (var resultado in resultados) {
      if (resultado.length > 3) {
        resultado = resultado.substring(0, resultado.length ~/ 2 + 1);
        if (util.contemMedicamento(resultado, medicamentos) != null) {
          medicamentos_encontrados.add(util.contemMedicamento(resultado, medicamentos));
          print(util.contemMedicamento(resultado, medicamentos).nome);
        }
      }
    }
    print("buscaMedicamentoEsq " + medicamentos_encontrados.length.toString());
    return medicamentos_encontrados;
  }

  Future<List<Medicamento>> buscaMedicamentoDir(List<String> resultados, context) async {
    List<Medicamento> medicamentos = await buscaMedicamentos(context);
    List<Medicamento> medicamentos_encontrados = [];
    Utils util = new Utils();
    for (var resultado in resultados) {
      if (resultado.length > 3) {
        resultado = resultado.substring(resultado.length ~/ 2 - 1, resultado.length);
        if (util.contemMedicamento(resultado, medicamentos) != null)
          medicamentos_encontrados.add(util.contemMedicamento(resultado, medicamentos));
      }
    }
    print("buscaMedicamentoDir " + medicamentos_encontrados.length.toString());
    return medicamentos_encontrados;
  }
}
