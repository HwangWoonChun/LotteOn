//
//  MallSelectionCell.swift
//  LotteOn
//
//  Created by mmxsound on 2020/10/25.
//

import UIKit

class MallSelectionCell: UICollectionViewCell {
    
    var viewModel: MallSectionViewModel!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var selectView: UIView!
    @IBOutlet var imageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        selectView.layer.cornerRadius = 10
        selectView.layer.borderWidth = 1
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = ""
    }
}

extension MallSelectionCell: Bindable {
    func bindViewModel() {
        
        self.titleLabel.text = self.viewModel.mallName
        
        if self.viewModel.isSelected {
            self.titleLabel.textColor = .white
            self.selectView.backgroundColor = .red
            self.selectView.layer.borderColor = UIColor.clear.cgColor
            self.imageView.tintColor = .white
        } else {
            self.titleLabel.textColor = .gray
            self.selectView.backgroundColor = .white
            self.selectView.layer.borderColor = UIColor.gray.cgColor
            self.imageView.tintColor = .gray

        }
    }
}

