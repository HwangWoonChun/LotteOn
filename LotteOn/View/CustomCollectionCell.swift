//
//  CustomCollectionCell.swift
//  LotteOn
//
//  Created by mmxsound on 2020/10/25.
//

import UIKit

class CustomCollectionCell: UICollectionViewCell {
    var viewModel: ProductViewModel!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var salePriceLabel: UILabel!
    @IBOutlet var productImgView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = ""
        self.priceLabel.text = ""
        self.salePriceLabel.text = ""
        self.productImgView.image = nil
    }
}

extension CustomCollectionCell: Bindable {
    func bindViewModel() {
        let brand = viewModel.product?.b ?? ""
        let productName = viewModel.product?.n ?? ""
        let imageURL = viewModel.product?.i ?? ""
        let originalPrice = viewModel.product?.op ?? 0
        let salePrice = viewModel.product?.p ?? 0
        let discountRate = viewModel.product?.d ?? 0
        //1. image
        self.productImgView.downloadImage(from: imageURL)
        //2.title
        var formattedString = NSMutableAttributedString()
        formattedString = formattedString.addsAttributeText(brand, .boldSystemFont(ofSize: 13))
        var spaceString = ""
        if brand.count > 0 { spaceString = " " }
        formattedString = formattedString.addsAttributeText(spaceString + productName, .systemFont(ofSize: 13))
        titleLabel.attributedText = formattedString
        //3.original price
        if discountRate > 0 {
            formattedString = NSMutableAttributedString()
            formattedString = formattedString.addsAttributeText("\(discountRate)%", .systemFont(ofSize: 11), .red)
            formattedString = formattedString.addsAttributeText(" \(originalPrice.withCommas())", .systemFont(ofSize: 13), .gray, strikeColor: .gray)
            priceLabel.attributedText = formattedString
        }
        //4. saleprice
        formattedString = NSMutableAttributedString()
        formattedString = formattedString.addsAttributeText("\(salePrice.withCommas())", .boldSystemFont(ofSize: 16), .black)
        formattedString = formattedString.addsAttributeText(" 원", .systemFont(ofSize: 11), .black)
        salePriceLabel.attributedText = formattedString
    }
}
