//
//  PopUpViewController.swift
//  Grupo07
//
//  Created by Sarah dos Santos Silva on 10/05/22.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var continuarView: UIView!
    @IBAction func teste(segue: UIStoryboardSegue){
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        continuarView.layer.cornerRadius = 20
    }
    
    @IBAction func continuarButtom(_ sender: UIButton) {
    
        
        
    }
    

}
