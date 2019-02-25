//
//  AssetTableViewCell.swift
//  CARAssetsAnalyzer
//
//  Created by Kevin Johnson on 2/20/19.
//  Copyright © 2019 Kevin Johnson. All rights reserved.
//

import UIKit

class AssetTableViewCell: UITableViewCell {
    
    struct ViewModel {
        let imageName: String
        let sizeString: String
    }
    
    @IBOutlet weak private var assetImageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var sizeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.adjustsFontForContentSizeCategory = true
        sizeLabel.adjustsFontForContentSizeCategory = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if assetImageView.image != nil {
            assetImageView.image = nil
        }
    }

    func configure(viewModel: ViewModel) {
        assetImageView.image = UIImage(named: viewModel.imageName) // show something if image missing?
        nameLabel.text = viewModel.imageName
        sizeLabel.text = viewModel.sizeString
    }
}
