//
//  ViewController.swift
//  Prueba pragma
//
//  Created by Carlos Ardila on 7/06/23.
//

import UIKit
import Toast_Swift

class ViewController: UIViewController {
    
    @IBOutlet weak var resultsStackView: UIStackView!
    
    var viewModel: MainViewModel? = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    deinit {
        viewModel = nil
    }
    
    func loadData() {
        self.viewModel?.loadResults(onSuccess: { [weak self] results in
            guard let self = self else { return }
            self.addResults(results)
        }, onError: { [weak self] error in
            guard let self = self else { return }
            self.view.makeToast(error)
        })
    }
    
    func addResults(_ results: [Cat]) {
        for cat in results {
            let catView = CatView()
            catView.setData(cat: cat)
            catView.heightAnchor.constraint(equalToConstant: 360).isActive = true
            resultsStackView.addArrangedSubview(catView)
        }
    }

}

