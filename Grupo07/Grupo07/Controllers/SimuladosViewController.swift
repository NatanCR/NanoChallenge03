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
        recuperacao()
        UserDefaults.standard.synchronize()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recuperacao()
        UserDefaults.standard.synchronize()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        recuperacao()
        UserDefaults.standard.synchronize()
    }

    func recuperacao (){
        
        //var nameReup: String!
        var acertouRe: [Int]?
        var resolveuRe: [Int]?
        var dataRe: [String]?
        
        //nameReup = UserDefaults.standard.string(forKey: "names")
        acertouRe = UserDefaults.standard.object(forKey: "acertou") as? [Int]
        resolveuRe = UserDefaults.standard.object(forKey: "resolveu") as? [Int]
        dataRe = UserDefaults.standard.object(forKey: "data") as? [String]
        
        
        if let a = acertouRe{
            acertou = a
        }
        if let r = resolveuRe{
            resolveu = r
        }
        
        if let d = dataRe{
            dataSimulados = d
        }
        
        myTable.reloadData()
        UserDefaults.standard.synchronize()
        
    }
    
         
    @IBAction func LimparHistorico(_ sender: UIButton) {
        
        
        if resolveu.isEmpty{ // alerta caso o usuario aperte o lixo com a lista vazia
            
            let alerta = UIAlertController(title: nil, message: "Seu historico está vazio.", preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: {[weak self](_)in }))
            present(alerta, animated: true, completion: nil)
            
        }
        
        //Criando o alerta
        
        let alertController = UIAlertController(title: nil, message: "Deseja excluir todo o historico?", preferredStyle: .alert)
                
            
               //Criando o botao de Excluir, com a exclusao do historico
        
        let OKAction = UIAlertAction(title: "Excluir", style: .default) { [self] (action:UIAlertAction!) in
                    
                   
                    print("Sim button tapped");
                        
                    acertou = [Int]()
                    resolveu = [Int]()
                    dataSimulados = [String]()
            
            UserDefaults.standard.removeObject(forKey: "resolveu")
            UserDefaults.standard.removeObject(forKey: "acertou")
            UserDefaults.standard.removeObject(forKey: "data")
            
            UserDefaults.standard.set(acertou, forKey: "acertou")
            UserDefaults.standard.set(resolveu, forKey: "resolveu")
            UserDefaults.standard.set(dataSimulados, forKey: "data")
                    
            UserDefaults.standard.synchronize()
            recuperacao()
                
        }
        
                
        
        alertController.addAction(OKAction)
                
                
        // Criando o botao de Cancelar
        
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { (action:UIAlertAction!) in
                    print("Não button tapped");
                }
                alertController.addAction(cancelAction)
                
                // Present Dialog message
                self.present(alertController, animated: true, completion:nil)
   
        
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
        cell.dataLabel.text = "\(dataSimulados[indexPath.row])"
        cell.dataLabel.sizeToFit()
        
        return cell
    }
    
    
    //OPCIONAL - EXCLUSAO DE LINHAS, PORÉM AS VEZES BUGA
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            
            resolveu.remove(at: indexPath.row)
            acertou.remove(at: indexPath.row)
            dataSimulados.remove(at: indexPath.row)
            
            UserDefaults.standard.removeObject(forKey: "resolveu")
            UserDefaults.standard.removeObject(forKey: "acertou")
            UserDefaults.standard.removeObject(forKey: "data")
            
            UserDefaults.standard.set(resolveu, forKey: "resolveu")
            UserDefaults.standard.set(acertou, forKey: "acertou")
            UserDefaults.standard.set(dataSimulados, forKey: "data")
            
            UserDefaults.standard.synchronize()
            viewWillAppear(true)
            myTable.reloadData()
            
        }
    }
    
    
    
    
    
}
