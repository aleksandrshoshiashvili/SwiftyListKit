//
//  ListLoaderProtocol.swift
//  LastDDM
//
//  Created by Alexander Shoshiashvili on 07/03/2019.
//  Copyright © 2019 Alexander Shoshiashvili. All rights reserved.
//

public protocol ListLoaderProtocol {
    func showLoader()
    func showLoader(with sections: [TableListSection])
    func hideLoader()
    func hideLoader(with replacingSections: [TableListSection])
}
