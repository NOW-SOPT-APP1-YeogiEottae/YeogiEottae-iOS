//
//  String.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/13/24.
//

import Foundation

enum StringLiteral {
    enum TabBar {
        static var homeTitle = "홈"
        static var searchTitle = "검색"
        static var nearByTitle = "주변"
        static var likeTitle = "찜"
        static var myInfoTitle = "내 정보"
    }
    
    enum AccommodationKindSegmentName {
        static var allKind = "전체"
        static var motel = "모텔"
        static var hotelResort = "호텔•리조트"
        static var pension = "펜션"
        static var homeVilla = "홈&빌라"
        static var camping = "캠핑"
        static var guestHouseHanok = "게하•한옥"
    }
    
    enum CompareRoom {
        static var navigationTitle = "객실 비교하기"
        static var calander = "5.12 일 - 5.13 월"
        static var person = "2명"
        static var edit = "수정하기"
        static var discountPercent = "10%"
        static var firstCome = "선착순"
        static var discountAmout = "-5000원"
        static var facility = "자쿠지 무료 이용\n수영장\n조식 제공"
        static var more = "더보기..."
    }
    
    enum CompareFilter {
        static var lowPrice = "낮은 가격 순"
        static var highPrce = "높은 가격 순"
        static var highRate = "높은 평점 순"
        static var highDiscount = "높은 할인 순"
        static var facility = "부대 시설"
        static var roomHotel = "객실 및 호텔"
    }
    
    enum SearchSegmentName {
        static var allKind = "전체"
        static var motel = "모텔"
        static var hotelResort = "호텔•리조트"
        static var pension = "펜션"
        static var homeVilla = "홈&빌라"
        static var camping = "캠핑"
        static var guestHouseHanok = "게하•한옥"
    }
    
    enum SearchListView {
        static var showMapButtonTitle = "지도보기"
        static var SortButtonTitle = "정렬"
    }
    
    enum CurrentFilterCriteria {
        static var YeogiEottaeRecommended = "여기어때 추천순"
    }
}
