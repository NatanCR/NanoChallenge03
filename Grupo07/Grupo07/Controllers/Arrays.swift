//
//  Arrays.swift
//  Grupo07
//
//  Created by Sarah dos Santos Silva on 10/05/22.
//

import Foundation
import UIKit

var resolveu = [Int]()
var acertou = [Int]()
var dataSimulados = [String]()
var pomodorosNum = [Int]()

var pomodoroTableView = PomodoroTableViewController()
var primeiraTableView = PrimeiraTableViewController()

class PomodoroConcluido: Codable{
    
    private var data: String?
    private var quantidade_pomodoros_concluidos: Int?
    
    init(){
        data = "10/10/2021"
        quantidade_pomodoros_concluidos = 1
    }
    init(_ data: String, _ quantidade: Int){
        self.data = data
        self.quantidade_pomodoros_concluidos = quantidade
    }

    func obter_pomodoros() -> Int{
       
        return quantidade_pomodoros_concluidos!
        
    }
    
    func obter_data() -> String{
      
        guard let data = data else {return ""}
        return data
    }
    
}

var quimicaMateria = [Materia("Funções orgânicas", []),
                      Materia("Reações químicas", []),
                      Materia("Soluções", []),
                      Materia("Eletroquímica", []),
                      Materia("Estequiometria", []),
                      Materia("Relações numéricas", []),
                      Materia("Solubilidade", []),
                      Materia("Termoquímica", []),
                      Materia("Equilíbrio iônico", []),
                      Materia("Problemas ambientais", []),
                      Materia("Atomisitica", []),
                      Materia("Introdução à química orgânica", []),
                      Materia("Isomeria", []),
                      Materia("Ligações químicas", []),
                      Materia("Propriedades coligativas", []),
                      Materia("Estrutura molecular", []),
                      Materia("Hidrolise", []),
                      Materia("Unidade de concentração", [])]

class Materia: Codable {

    private var titulo: String?
    private var lista_pomodoros_concluidos: [PomodoroConcluido] = [PomodoroConcluido]()
    init(_ titulo: String){
        self.titulo = titulo
    }

    init(_ titulo: String, _ pomodoro: [PomodoroConcluido]){
        self.titulo = titulo
        for p in pomodoro{
            lista_pomodoros_concluidos.append(p) //append em cada item da classe de cima
        }
    }
    

    func obter_titulo() -> String?{
        return titulo
    }
    
    //usada na PrimeiraTableViewController
    //usada na cellForRowAt
    //funcao que soma todos os pomodoros concluidos da lista
   
    func obter_pomodoro() -> Int{
       
        var total :Int = 0
        for pc in lista_pomodoros_concluidos{
            total += pc.obter_pomodoros()
        }
                
        return total
    }
    
    //usada na PomodoroTableViewContoller
    //usada para data e string cellForRowAt
    //usada na numbersOfSection
    //funcao so para pegar a data e os pomodoros feitos
    func obter_lista_pomodoros_concluidos() -> [PomodoroConcluido]{
        return lista_pomodoros_concluidos
        //obtem o pomodoro e data apos passar por todas as outras funcoes
        
    }
    
    //usada na PrimeiraTableViewController
    //usada na cellForRowAt
    func obter_titulo() -> String {
        guard let titulo = titulo else { return "" }
        return titulo
    }
    
    //usada na PomodoroTableViewController
    //usada na func inserir pomodoros
  
    func adicionar_pomodoro_concluido(_ p : PomodoroConcluido){
        lista_pomodoros_concluidos.append(p)
        
    }
}



func saveQuimicaMateria(){
    let encoder = PropertyListEncoder()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Qui.plist")
    //esta gravando os itens do array na pasta do diretorio
    do{
        let data = try encoder.encode(quimicaMateria)
        try data.write(to: dataFilePath!)
    } catch {
        print("Error encoding item array, \(error)")
    }
    
    print("save: \(quimicaMateria)")
    print(dataFilePath ?? "")

}

func loadQuimicaMateria(){
    //recupera os itens salvos na pasta
    
    //cria um caminho para uma pasta no diretorio da maquina
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Qui.plist")
    
    if let data = try? Data(contentsOf: dataFilePath!){
        let decoder = PropertyListDecoder()
        do {
            quimicaMateria = try decoder.decode([Materia].self, from: data)
        } catch {
            print("Error decoding item array, \(error)")
        }
    }
    
    print("load: \(quimicaMateria)")
    print(dataFilePath ?? "")
}
