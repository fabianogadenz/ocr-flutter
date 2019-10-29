import 'package:diacritic/diacritic.dart';
import 'package:tcc_fabiano/models/medicamento.dart';

class Utils {
  static List<String> limpaAcentos(List<String> resultados) {
    List<String> resultados_limpos = [];
    for (String r in resultados) resultados_limpos.add(removeDiacritics(r));
    return resultados_limpos;
  }
  static List<String> formata_para_minuscula(List<String> resultados){
    List<String> resultados_minusculos = [];

    for (String r in resultados)
      resultados_minusculos.add(r.toLowerCase());
    return resultados_minusculos;
  }

  static List<String> removePalavrasPadrao(List<String> resultados) {
    List<String> resultados_limpos = [];

    for (String r in resultados) {
      if(!contemLixo(r))
        resultados_limpos.add(r);
    }
    print("removePalavrasPadrao " + resultados_limpos.length.toString());
    return resultados_limpos;
  }

  static bool contemLixo(String dado) {
    List<String> lixo = [
      " mg",
      " ml",
      "comprimidos",
      "venda",
      "medica",
      "medico",
      " oral",
      " idade",
      "adulto",
      "empresa",
      "tratamento"
    ];
    for (String l in lixo) {
      if (dado.contains(l)) return true;
    }
    return false;
  }

  Medicamento contemMedicamento(String dado, List<Medicamento> listMedicamentos) {
    for (Medicamento medicamento in listMedicamentos) {
      if (removeDiacritics(medicamento.nome.toLowerCase()).contains(dado)) return medicamento;
    }
    return null;
  }
  Medicamento igualMedicamento(String dado, List<Medicamento> listMedicamentos) {
    for (Medicamento medicamento in listMedicamentos) {
      if (dado == removeDiacritics(medicamento.nome.toLowerCase())) return medicamento;
    }
    return null;
  }
}
