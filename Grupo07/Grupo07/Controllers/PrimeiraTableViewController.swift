//
//  PrimeiraTableViewController.swift
//  Grupo07
//
//  Created by Sarah dos Santos Silva on 20/04/22.
//

import UIKit

class PrimeiraTableViewController: UIViewController {

    @IBOutlet weak var myTable: UITableView!
    
    @IBOutlet weak var viewSimulados: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib (nibName: "PrimeiraTableViewCell", bundle: nil) // linkando a celula personalizada
        
        myTable.register(nib, forCellReuseIdentifier: "PrimeiraTableViewCell") // registrando a celula personalizada
        
        
        // implementando o dataSource e o delegate
        myTable.delegate = self
        myTable.dataSource = self
        
        viewSimulados.layer.cornerRadius = 20 // arredondando a view que está a Label e o Buttom do simulados

    }
    
}

extension PrimeiraTableViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrimeiraTableViewCell", for: indexPath) as! PrimeiraTableViewCell
        
        return cell
   
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "PomodoroTableViewController") as? PomodoroTableViewController{
            
            self.navigationController?.pushViewController(vc, animated: true)
        
        }
        
    }
    
    
    
    
    
}




