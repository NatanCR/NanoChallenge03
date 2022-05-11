//
//  PomodoroTableViewController.swift
//  Grupo07
//
//  Created by Sarah dos Santos Silva on 11/05/22.
//

import UIKit

class PomodoroTableViewController: UIViewController {

    @IBOutlet weak var pomodoroView: UIView!
    
    @IBOutlet weak var myTablePomodoro: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pomodoroView.layer.cornerRadius = 20
        
        let nib = UINib(nibName: "PomodoroTableViewCell", bundle: nil)
        
        myTablePomodoro.register(nib, forCellReuseIdentifier: "PomodoroTableViewCell")
        myTablePomodoro.delegate = self
        myTablePomodoro.dataSource = self
    }
}

extension PomodoroTableViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PomodoroTableViewCell", for: indexPath) as! PomodoroTableViewCell
        return cell
    }
    
    
}
