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
    
    @IBAction func DoneButtom(_ sender: UIBarButtonItem) {
        
        let resolveuInt = Int (resolveuField.text!)!
        let acertouInt = Int (acertouField.text!)!
        
        if (resolveuInt) > (acertouInt){
            
            resolveu.append(resolveuInt)
            acertou.append(acertouInt)
            dataSimulados.append(dateFormatter.string(from: date))
            
            if (storyboard?.instantiateViewController(withIdentifier: "SimuladosViewController") as? SimuladosViewController) != nil {

                    self.navigationController?.popViewController(animated: true)

                }
        }
        
        else if (resolveuInt) < (acertouInt){
            let alerta = UIAlertController(title: nil, message: "O número de questões acertadas não pode ser maior que as resolvidas!", preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: {[weak self](_)in }))
            present(alerta, animated: true, completion: nil)
            print("aqui")
        }
        
        else if (resolveuInt) == (acertouInt){
            
            resolveu.append(resolveuInt)
            acertou.append(acertouInt)
            dataSimulados.append(dateFormatter.string(from: date))
            
            
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
