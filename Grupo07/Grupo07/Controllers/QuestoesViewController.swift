//
//  QuestoesViewController.swift
//  Grupo07
//
//  Created by Sarah dos Santos Silva on 10/05/22.
//

import UIKit

class QuestoesViewController: UIViewController {

    @IBOutlet weak var resolveuView: UIView!
    @IBOutlet weak var acertouView: UIView!
    
    @IBOutlet weak var resolveuField: UITextField!
    @IBOutlet weak var acertouField: UITextField!
    
    let date = Date()
    let dateFormatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resolveuView.layer.cornerRadius = 20
        acertouView.layer.cornerRadius = 20
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.string(from: date)
        print(dateFormatter.string(from: date))
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        resolveu = UserDefaults.standard.object(forKey: "resolveu") as! [Int]
        acertou = UserDefaults.standard.object(forKey: "acertou") as! [Int]
        dataSimulados = UserDefaults.standard.object(forKey: "data") as! [String]

    }
    
    func saveData(){
        
        UserDefaults.standard.set(resolveu, forKey: "resolveu")
        UserDefaults.standard.set(acertou, forKey: "acertou")
        UserDefaults.standard.set(dataSimulados, forKey: "data")
    }
    
    @IBAction func DoneButtom(_ sender: UIBarButtonItem) {
        
        let resolveuInt = Int (resolveuField.text!)
        let acertouInt = Int (acertouField.text!)

        if Int(resolveuInt ?? 0) > Int(acertouInt ?? 0){ // If principal

            
            if Int(acertouInt ?? 0) > 0{

                
                let resolveuInt = Int (resolveuField.text!)
                let acertouInt = Int (acertouField.text!)
                
                resolveu.append(resolveuInt!)
                acertou.append(acertouInt!)
                dataSimulados.append(dateFormatter.string(from: date))
                saveData()

                if (storyboard?.instantiateViewController(withIdentifier: "SimuladosViewController") as? SimuladosViewController) != nil {

                        self.navigationController?.popViewController(animated: true)

                    }
                
            }
            
            else if Int(resolveuInt!) > 0{
                
                let alerta = UIAlertController(title: nil, message: "Insira o número de questões acertadas.", preferredStyle: .alert)
                alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: {[weak self](_)in }))
                present(alerta, animated: true, completion: nil)
                
                let resolveuInt = Int (resolveuField.text!)
                let acertouInt = Int (acertouField.text!)

            }
            
            
        }
        
        else if Int(resolveuInt ?? 0) < Int(acertouInt ?? 0){
            
            let alerta = UIAlertController(title: nil, message: "O número de questões acertadas não pode ser maior que as resolvidas!", preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: {[weak self](_)in }))
            present(alerta, animated: true, completion: nil)
            
            
        }
    
        
        else if (resolveuInt) == (acertouInt){
            
            if resolveuField.text == ""{
               
                let alerta = UIAlertController(title: nil, message: "Por favor, preencha os campos.", preferredStyle: .alert)
                alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: {[weak self](_)in }))
                present(alerta, animated: true, completion: nil)
                print("aqui")
                
            }
            
            
                        
            else{
                
                resolveu.append(resolveuInt!)
                acertou.append(acertouInt!)
                dataSimulados.append(dateFormatter.string(from: date))
                saveData()
                
                
                if let vc = storyboard?.instantiateViewController(withIdentifier: "PopUpViewController") as? PopUpViewController{
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true)
                
                }
                
                if (storyboard?.instantiateViewController(withIdentifier: "SimuladosViewController") as? SimuladosViewController) != nil {

                        self.navigationController?.popViewController(animated: true)

                    }
                
                resolveuField.text = ""
                acertouField.text = ""
            }
            
           
                    
        }
        
    }
    
    
}
