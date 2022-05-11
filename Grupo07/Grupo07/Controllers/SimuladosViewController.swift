//
//  SimuladosViewController.swift
//  Grupo07
//
//  Created by Sarah dos Santos Silva on 10/05/22.
//

import UIKit

class SimuladosViewController: UIViewController {

    @IBOutlet weak var simuladosView: UIView!
    @IBOutlet weak var myTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        simuladosView.layer.cornerRadius = 20
        
        myTable.delegate = self
        myTable.dataSource = self
        
        let nib = UINib(nibName: "SimuladosTableViewCell", bundle: nil)
        myTable.register(nib, forCellReuseIdentifier: "SimuladosTableViewCell")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
       myTable.reloadData()
   }
}

extension SimuladosViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return acertou.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SimuladosTableViewCell", for: indexPath) as! SimuladosTableViewCell
        
        cell.acertouLabel.text = String(acertou[indexPath.row])
        cell.resolveuLabel.text = String(resolveu[indexPath.row])
        cell.dataLabel.text = "Data: \(dataSimulados[indexPath.row])"
        cell.dataLabel.sizeToFit()
        
        return cell
    }
    
    
    
    
    
}
