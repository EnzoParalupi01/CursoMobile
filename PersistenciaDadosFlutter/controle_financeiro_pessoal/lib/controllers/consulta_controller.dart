import 'package:controle_financeiro_pessoal/models/consulta_model.dart';
import 'package:controle_financeiro_pessoal/services/petshop_dbhelper.dart';

class ConsultaController {
  final _dbHelper = PetShopDBHelper();

  //métodos do Crud

  //retorna o nº do id que foi inserido
  Future<int> createConsulta(Consulta consulta) async{
    return _dbHelper.insertConsulta(consulta);
  }

  Future<List<Consulta>> readConsultaForPet(int petId) async{
    return _dbHelper.getConsultasForPet(petId);
  }
  //retorna o id da consulta que foi deletada
  Future<Future<int>> deleteConsulta(int id) async{
    return _dbHelper.deleteConsulta(id);
  }
}