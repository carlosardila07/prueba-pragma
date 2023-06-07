//
//  CatView.swift
//  Prueba pragma
//
//  Created by Carlos Ardila on 7/06/23.
//

import UIKit

class CatView: UIView {

    let kCONTENT_XIB_NAME = "CatView"
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var intelligenceLabel: UILabel!
    
    private var isFirstCall = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewSetup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        viewSetup()
    }
    
    private func loadViewFromNib() -> UIView? {
         let bundle = Bundle(for: type(of: self))
         let nib = UINib(nibName: kCONTENT_XIB_NAME, bundle: bundle)
         return nib.instantiate(withOwner: self, options: nil).first as? UIView
     }
    
    private func viewSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        if !isFirstCall {
            self.addSubview(view)
            isFirstCall = true
        }
        contentView = view
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
    }
    
    func setData(cat: Cat) {
        self.nameLabel.text = cat.name
        self.countryLabel.text = cat.origin
        self.intelligenceLabel.text = "Inteligencia: \(cat.intelligence)"
        var url = "https://s.france24.com/media/display/8c13820c-5b0e-11e9-bf90-005056a964fe/w:980/p:16x9/gato.webp"
        if let imageUrl = cat.image?.imageUrl {
            url = imageUrl
        }
        self.imageView.downloaded(from: url)
    }
    
}

extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
