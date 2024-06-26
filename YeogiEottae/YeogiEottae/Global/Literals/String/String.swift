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
    
    enum BasicInfo {
        static var basic1 = "2인 기준 최대 3인 (유료)"
        static var basic2 = "인원 추가 시 비용이 발생돼요."
        static var basic3 = "싱글베드 2개"
        static var basic4 = "객실+욕실 / 12평"
    }
    
    enum RefundPolicy {
        static var refund1 = "체크인일 기준 3일전 18시까지 : 100% 환불"
        static var refund2 = "체크인일 기준 3일전 18시 이후~당일 및 No-show : 환불 불가 (연박의 경우 최초 1박 환불 불가, 이후 일자 100% 환불)"
        static var refund3 = "취소, 환불 시 수수료가 발생할 수 있습니다."
        static var refund4 = "아래 객실은 별도의 취소 규정이 적용되오니 참고 부탁드립니다"
        static var refund5 = "[룸온리 특가], [호텔딜], [오픈런] 객실: 체크인일 기준 7일 전 18시까지 100% 환불, 이후 환불 불가 (연박의 경우 최초 1회 환불 불가 이 일자 100% 환불)"
        static var refund6 = "[특가],[취소불가] 객실: 취소, 변경, 환불 불가"
        static var refund7 = "예약 후 10분 내 취소될 경우 취소 수수료가 발생하지 않습니다. (*체크인 시간 경과 후 제외)"
        static var refund8 = "예약 후 10분 경과 시엔 해당 숙소의 취소 및 환불 규정이 적용됩니다."
    }
    
    enum HotelDetail {
        static var dateRange = "5.15 수 - 5.16 토 1박"
        static var hotelDetail = "호텔 상세"
        static var toss = "토스페이"
        static var roomInfo = "객실정보"
        static var roomPerson = "기준2인 최대2인"
        static var package = "패키지"
        static var amusementpark = "롯데월드 자유이용권 2매"
        static var coupon = "쿠폰적용시"
        static var distance = "건대입구역 도보 3분"
        static var warn = "방을 선택하면 비교하기 기능을 사용할 수 있어요"
        static var empty = "아직 선택된 방이 없어요"
        static var select = "선택하기"
        static var date = "5.2 목 - 5.3 금"
        static var compare = "비교하기"
        static var national = "국내 숙소"
        static var aboard = "해외 숙소"
        static var rental = "공간대여"
        static var ticket = "레저•티켓"
    }
    
    enum SearchList {
        static var hotel = "호텔"
        static var rating = "10"
        static var valuation = "3,333개 평가"
        static var filter = "필터"
    }
    
    enum Compare {
        static var reservation = "예약하기"
        static var add = "추가하기"
        static var like = "내가 선택한 상품"
        static var compareEasily = "비교하고 싶은 숙소를 추가하면\n간편하게 비교해볼 수 있어요"
        static var empty = "아직 추가한 숙소가 없어요"
        static var edit = "수정하기"
        static var editComplete = "수정완료"
    }
}
