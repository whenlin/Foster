//
//  DailyEvent.swift
//  BarRank
//
//  Created by WHenlin on 2018-08-30.
//  Copyright © 2018 WHenlin. All rights reserved.
//

import Foundation

struct DailyEvent {
    var weekDay: String!
    var deals: [String]
    var dealDescriptions: [String]
}

var days = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]

var mondayDeals = ["Dollar Beers","1/2 Price Wings", "Appetizers","Burgers & Beers"]
var mondaydealDescriptions = ["$1.25 beers at Jack's","1/2 price wings at Molly Bloom's","1/2 price apps at The Pub on Richmond","$5 burger and $5 pints at Symposium"]

var tuesdayDeals = ["Tequila Tuesdays","Burgers & Beers","Nachos & Drinks","Movie Night"]
var tuesdaydealDescriptions = ["$2.50 tequila, $12.50 pitchers, 1/2 price nachos at Jack's","1/2 price burgers, $13 pitchers at McCabe's","1/2 price nachos, $5 Coronas, $4 Jagermeister at Winks","$3.25 student admission at Western Film"]

var wednesdayDeals = ["Dollar Beers","Wine Wednesday","Nacho Night"]
var wednesdaydealDescriptions = ["$1.25 beers at Jack's","1/2 price bottles of wine at McCabe's","1/2 price nachos at Molly Bloom's"]

var thursdayDeals = ["Schooners","Thirsty Thursdays","1/2 Price Wine"]
var thursdaydealDescriptions = ["$7.50 domestic schooners of Coors Light, Canadian, Bud and Coors Banquet at McCabe's","$14 pitchers of Labatt 50, $4.50 rail mixed drinks at Winks","1/2 price bottles of wine at The Pub on Richmond"]

var fridayDeals = ["Toonie Takeover"]
var fridaydealDescriptions = ["$2 tequila and Jagerbombs at Jack's"]

var saturdayDeals = ["Only at Jack's","Drinks at Winks"]
var saturdaydealDescriptions = ["$2.50 Jack Daniel's and Florida Tracksuits at Jack's","$5 Caesars until 4pm, $5 domestic small draught, $3 Jagermeister at Winks"]

var sundayDeals = ["$5 Pints", "Sunday Funday"]
var sundaydealDescriptions = ["$5 pints at McCabe's","1/2 price wings with purchase of a beverage at Winks"]
