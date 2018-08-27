//
//  Constants.swift
//  PoloGang(Bar)
//
//  Created by WHenlin on 2018-06-17.
//  Copyright © 2018 WHenlin. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

//URL Constants
let BASE_URL = "https://bar-app-whenlin.c9users.io/"
let URL_GETBARS = "\(BASE_URL)bars/"
let URL_GETREVIEWS = "\(BASE_URL)reviews/"
let URL_GETALLREVIEWS = "\(BASE_URL)allReviews/"


//Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"

//User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//HEADERS
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]

