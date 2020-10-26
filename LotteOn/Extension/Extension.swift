//
//  Extension.swift
//  LotteOn
//
//  Created by mmxsound on 2020/10/25.
//

import UIKit

extension NSMutableAttributedString {
    //각 스티링별 색상변경
    func addsAttributeText(_ text: String, _ font : UIFont, _ color : UIColor = UIColor.black) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor : color]
        let string = NSMutableAttributedString(string:text, attributes: attributes)
        append(string)
        return self
    }
    //각 스트링별 색상변경 + strikeLine
    func addsAttributeText(_ text: String, _ font : UIFont, _ color : UIColor = UIColor.black, strikeColor: UIColor = .clear) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor : color,
            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
            .strikethroughColor: strikeColor,
        ]
        let string = NSMutableAttributedString(string:text, attributes: attributes)
        append(string)
        return self
    }
}

fileprivate var imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    //downloadImage
    func downloadImage(from url: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: url) else { return }
        
        contentMode = mode
        //cached Image
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            DispatchQueue.main.async() { [weak self] in
                self?.image = cachedImage
            }
        } else {
            //downloadImage
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                else { return }
                imageCache.setObject(image, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async() { [weak self] in
                    self?.image = image
                }
            }.resume()
        }
    }
}

extension Double {
    //절삭
    func cuttingNum(with value: Double) -> Double {
        return (self / value)
    }
    
    //Int for comma
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let value = Int(self)
        return numberFormatter.string(from: NSNumber(value: value))!
    }
}

extension CGFloat {
    static var ratioValue: CGFloat {return UIScreen.main.bounds.width / 375}
    func getRatio() -> CGFloat {
        let value = self * .ratioValue
        return value.rounded()
    }
}
