//
//  CustomError.swift
//  Prueba pragma
//
//  Created by Carlos Ardila on 7/06/23.
//

import Foundation

protocol OurErrorProtocol: LocalizedError {
    var title: String? { get }
    var code: Int { get }
}

struct CustomError: OurErrorProtocol {

    var title: String?
    var code: Int
    var errorDescription: String {
        get { return _description }
        set { self._description = newValue}
    }
    var failureReason: String? {
        get { return _description }
        set { self._description = newValue ?? "Error de servidor" }
    }

    private var _description: String

    init(title: String?, description: String, code: Int) {
        self.title = title ?? "Error"
        self._description = description
        self.code = code
    }
}
