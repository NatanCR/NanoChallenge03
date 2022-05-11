//
//  SimuladosTableViewCell.swift
//  Grupo07
//
//  Created by Sarah dos Santos Silva on 10/05/22.
//

import UIKit

class SimuladosTableViewCell: UITableViewCell {

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var acertouLabel: UILabel!
    @IBOutlet weak var resolveuLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //set the values for top,left,bottom,right margins
        
        //espaçamento entre as celulas
        
        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
        
        //Celula arredondada
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
    }
    
}
