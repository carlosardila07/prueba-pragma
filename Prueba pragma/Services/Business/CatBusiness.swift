//
//  CatBusiness.swift
//  Prueba pragma
//
//  Created by Carlos Ardila on 7/06/23.
//

import Foundation
import PromiseKit

struct CatBusiness {
    func getCats() -> Promise<[Cat]> {
        return NetworkManager.shared.arrayRequest("breeds", method: .get)
    }
}
