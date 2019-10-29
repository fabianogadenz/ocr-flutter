import 'package:tcc_fabiano/data/data.dart';
import 'package:tcc_fabiano/models/medicamento.dart';
import 'package:tcc_fabiano/utils.dart';

class PosProcessamento {
  static Future<List<Medicamento>> buscaMedicamentos(List<String> dados_ocr, context) async {
    List<String> dados_limpos = [];
    dados_limpos = Utils.formata_para_minuscula(dados_ocr);
    dados_limpos = Utils.limpaAcentos(dados_limpos);
    dados_limpos = Utils.removePalavrasPadrao(dados_limpos);

    print("listmedicamento " + dados_ocr.length.toString());
    print("listmedicamento " + dados_limpos.length.toString());
    Data data = new Data();
    List<Medicamento> listMedicamento = [];
    listMedicamento = await data.buscaMedicamentoIgual(dados_limpos, context);
    print("listmedicamento" + listMedicamento.length.toString());
    if (listMedicamento.length > 1)
      listMedicamento = await data.buscaMedicamentoEsq(dados_limpos, context);
    print("listmedicamento2" + listMedicamento.length.toString());
    return listMedicamento;
  }
}
