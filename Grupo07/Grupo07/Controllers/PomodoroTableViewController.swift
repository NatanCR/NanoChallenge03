//
//  PomodoroTableViewController.swift
//  Grupo07
//
//  Created by Sarah dos Santos Silva on 11/05/22.
//

import UIKit

protocol ListaPomodorosConcluidosProtocol {
    func inserir_pomodoro_concluido(data: String, pomodoros: Int)
}

class PomodoroTableViewController: UIViewController, ListaPomodorosConcluidosProtocol {

    let date = Date()
    let dateFormatter = DateFormatter()
    var dataTempo = [Date]()

    var materia: Materia?
    var pomodoroConcluido = PomodoroConcluido()
    var materiaArray = [Materia]()
    
    @IBOutlet weak var pomodoroView: UIView!
    @IBOutlet weak var myTablePomodoro: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "PomodoroTableViewCell", bundle: nil)
        myTablePomodoro.register(nib, forCellReuseIdentifier: "PomodoroTableViewCell")
        
        pomodoroView.layer.cornerRadius = 20
        myTablePomodoro.delegate = self
        myTablePomodoro.dataSource = self
        
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        dateFormatter.string(from: date)
        print(dateFormatter.string(from: date))
    }
    
    func inserir_pomodoro_concluido(data: String, pomodoros: Int) {
        guard let materia = materia else {return}
        
        //pega a data e quantidade de PomodoroConcluido como parametro
        // e usa a a func adicionar
        materia.adicionar_pomodoro_concluido(PomodoroConcluido(data, pomodoros))
        saveQuimicaMateria()
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        myTablePomodoro.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else { return }
        
        if id == "seguePomodoro"{
            let vc = (segue.destination as! PomodoroViewController)
            vc.delegate = self
        }
    }
}



extension PomodoroTableViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let materia = materia else { return 0 }
        return materia.obter_lista_pomodoros_concluidos().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PomodoroTableViewCell", for: indexPath) as! PomodoroTableViewCell
        
        guard let materia = materia else { return cell }
     
        cell.dataLabel.text =  "\(materia.obter_lista_pomodoros_concluidos()[indexPath.row].obter_data())"
        cell.pomodoLabel.text = String(materia.obter_lista_pomodoros_concluidos()[indexPath.row].obter_pomodoros())
        
        return cell
    }
    
    
}
