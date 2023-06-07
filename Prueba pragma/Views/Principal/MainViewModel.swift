//
//  MainViewModel.swift
//  Prueba pragma
//
//  Created by Carlos Ardila on 7/06/23.
//

import Foundation

protocol MainViewModelDelegate {
    func onCatsResult(_ results: [Cat])
    func onToast(_ message: String)
}

class MainViewModel {
    
    var business: CatBusiness? = CatBusiness()
    
    deinit {
        self.business = nil
    }
    
    func loadResults(onSuccess: @escaping ([Cat]) -> Void, onError: @escaping (String) -> Void) {
        business?.getCats().done { result in
            onSuccess(result)
        }.catch { error in
            if let error = error as? CustomError {
                onError(error.errorDescription)
            }
        }
    }
}
