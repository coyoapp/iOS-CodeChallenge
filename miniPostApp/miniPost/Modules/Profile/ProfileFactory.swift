//
//  InfoFactory.swift
//  miniPost
//
//  Created by Robert Lang on 22/3/24.
//

import Foundation

func createProfileModule() -> ProfilePresenter {

    let ProfileView = ProfileViewHandler()
    let ProfileInteractor = ProfileInteractor()
    let ProfilePresenter = ProfilePresenter()
    let ProfileRouter = ProfileRouter()

    ProfileView.presenter = ProfilePresenter
    ProfilePresenter.view = ProfileView
    ProfilePresenter.interactor = ProfileInteractor
    ProfilePresenter.router = ProfileRouter
    ProfileInteractor.presenter = ProfilePresenter
    ProfileRouter.presenter = ProfilePresenter

    ProfilePresenter.fetchInfo()

    return ProfilePresenter
}
