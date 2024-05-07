//
//  InfoFactory.swift
//  miniPost
//
//  Created by Robert Lang on 22/3/24.
//

import Foundation

func createProfileModule() -> ProfilePresenter {

    let profileViewHandler = ProfileViewHandler()
    let profileInteractor = ProfileInteractor()
    let profileRouter = ProfileRouter()
    let profilePresenter = ProfilePresenter()

    profilePresenter.view = profileViewHandler
    profilePresenter.interactor = profileInteractor
    profilePresenter.router = profileRouter
    
    profileViewHandler.presenter = profilePresenter
    
    profileInteractor.presenter = profilePresenter
    profileRouter.presenter = profilePresenter

    profilePresenter.fetchInfo()

    return profilePresenter
}
