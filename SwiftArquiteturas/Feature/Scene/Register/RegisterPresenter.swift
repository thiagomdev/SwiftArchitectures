//
//  RegisterPresenter.swift
//  SwiftArquiteturas
//
//  Created by Thiago on 11/06/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol RegisterPresentationLogic
{
  func presentSomething(response: Register.Something.Response)
}

class RegisterPresenter: RegisterPresentationLogic
{
  weak var viewController: RegisterDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: Register.Something.Response)
  {
    let viewModel = Register.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
