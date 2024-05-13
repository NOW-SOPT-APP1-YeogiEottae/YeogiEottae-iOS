//
//  Filter.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/12.
//

import Foundation

protocol SearchFilterProtocol { }
//protocol DiscountProtocol: SearchFilterProtocol { }
//protocol PreferenceProtocol: SearchFilterProtocol { }

enum SearchFilter: String, CaseIterable, SearchFilterProtocol {
    
    case couponDiscount = "쿠폰할인"
    case onSale = "할인특가"
    case dayUse = "대실예약"
    case breakfastFree = "조식포함"
    case poolVilla = "풀빌라"
    
    
    
    enum Discount: CaseIterable, SearchFilterProtocol {
        case coupon
        case onSale
    }
    
    enum Preference: CaseIterable, SearchFilterProtocol {
        case swimEnable
        case BBQ
        case forestView
        case ensuiteBathroom
        case pet
        case bulmeong
        case InstaWorthy
        case forCouple
        case forFamily
        case goodReviews
        case campingCar
        case autoCamping
    }
    
    enum CampingCategory: CaseIterable, SearchFilterProtocol {
        case glamping
        case caravan
        case autoCamping
    }
    
    enum Facility: CaseIterable, SearchFilterProtocol {
        
        enum PublicFacility: CaseIterable, SearchFilterProtocol {
            case swimmingPool
            case sharedShowerRoom
            case market
            case bbq
            case electricity
            case sink
            case microwave
            case internet
            case cafe
            case convenienceStore
            case karaoke
            case kitchen
            case washingMaching
            case clothesDryer
            case clothesDehydrator
            case publicPC
            case parkingLot
            case lounge
            case cookingAllowed
        }
        
        enum RoomFacility: CaseIterable, SearchFilterProtocol {
            case showerRoom
            case airConditional
            case hairDryer
            case wifi
            case tv
            case amenity
            case miniBar
            case refridgerator
            case bath
            case iron
            case electricRiceCooker
            case privateSpa
        }
        
        enum OtherFacility: CaseIterable, SearchFilterProtocol {
            case cookingAllowedInRoom
            case siteParking
            case petAllowed
            case pickupService
            case breakfastFree
            case campfire
            case creditCard
            case smokingAllowedInRoom
            case valetParking
            case smokeFree
        }
        
    }
    
    
    
}
