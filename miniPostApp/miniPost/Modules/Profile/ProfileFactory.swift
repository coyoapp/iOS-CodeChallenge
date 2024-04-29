//
//  InfoFactory.swift
//  miniPost
//
//  Created by Robert Lang on 22/3/24.
//

import Foundation

func createProfileModule() -> ProfilePresenter {
    let profileView = ProfileViewHandler()
    let profileInteractor = ProfileInteractor()
    let profilePresenter = ProfilePresenter()
    let profileRouter = ProfileRouter()

    profileView.presenter = profilePresenter
    profilePresenter.view = profileView
    profilePresenter.interactor = profileInteractor
    profilePresenter.router = profileRouter
    profileInteractor.presenter = profilePresenter
    profileRouter.presenter = profilePresenter

    profilePresenter.fetchInfo()

    return profilePresenter
}
