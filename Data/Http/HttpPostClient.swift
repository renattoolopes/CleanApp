//
//  HttpPostClient.swift
//  Data
//
//  Created by Renato Lopes on 07/09/20.
//  Copyright © 2020 Renato Lopes. All rights reserved.
//

import Foundation

public protocol HttpPostClient {
    func post(to url: URL, with data: Data?)
}
