//
//  PrimeiraTableViewController.swift
//  Grupo07
//
//  Created by Sarah dos Santos Silva on 20/04/22.
//

import UIKit

protocol Atualizavel{

    func aumentarValorPomodoro()
}

class PrimeiraTableViewController: UIViewController {

    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var viewSimulados: UIView!
    
    var materia: Materia?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib (nibName: "PrimeiraTableViewCell", bundle: nil) // linkando a celula personalizada
        
        myTable.register(nib, forCellReuseIdentifier: "PrimeiraTableViewCell") // registrando a celula personalizada
        
        
        // implementando o dataSource e o delegate
        myTable.delegate = self
        myTable.dataSource = self
        
        viewSimulados.layer.cornerRadius = 20 // arredondando a view que está a Label e o Buttom do simulados

    }
    
    override func viewDidAppear(_ animated: Bool) {
    
        myTable.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveQuimicaMateria()
    }
    
}

extension PrimeiraTableViewController: UITableViewDataSource, UITableViewDelegate, Atualizavel{
    
    func aumentarValorPomodoro() {

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return quimicaMateria.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrimeiraTableViewCell", for: indexPath) as! PrimeiraTableViewCell
        
        //PASSO 4 - RETORNA PASSO 6 - PASSO 13 - RETORNA PASSO 16
        cell.materiasLabel.text = quimicaMateria[indexPath.row].obter_titulo()
        //PASSO 8 - PASSO 14 - RETORNA PASSO 18 (CARREGA A PAGINA INICIAL)
        //PASSO 5.4 - RETORNA PASSO 7.4
        cell.pomodorosLabel.text = "\(quimicaMateria[indexPath.row].obter_pomodoro())"
        
        
        return cell
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadQuimicaMateria()
        myTable.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //APOS INICIAL CARREGADA CLICA NA CELULA - PASSO 1.2
        if let vc = storyboard?.instantiateViewController(withIdentifier: "PomodoroTableViewController") as? PomodoroTableViewController{
            vc.materia = quimicaMateria[indexPath.row]
            //PASSO 2.2
            self.navigationController?.pushViewController(vc, animated: true)
        }
 
        //faz uma breve marcação na hora do click
        tableView.deselectRow(at: indexPath, animated: true)

        
    }
    
    
    
    
    
}




