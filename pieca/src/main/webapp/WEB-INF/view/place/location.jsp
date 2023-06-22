<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

    <style>
.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:100%;height:500px;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
#menu_wrap2 {position:absolute;top:0;right:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js" integrity="sha512-WFN04846sdKMIP5LKNphMaWzU7YpMyCU245etK3g/2ARYbPK9Ub18eG+ljU96qKRCWh+quCY7yefSmlkQw1ANQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script> <!-- locash메소드 -->
</head>
<body>
<h1>충전소 정보.</h1>
    <div class="w3-container">
     <div>
        <table id="place" class="w3-table-all" style="width:30%;">
        
        </table>
     </div>
  </div>
      <div><span id="si2">
       <select name="si2" onchange="getText2('si2')">
          <option value="">시도를 선택하세요</option>
       </select></span>
      <span id="gu2">
       <select name="gu2" onchange="getText2('gu2')">
          <option value="">구군을 선택하세요</option>
       </select></span>
       
      </div>
       <input value="" name="zscode" id="zscode">
       
   <input type="button" value="시티코드" onclick="ecclocationApi()"/>
   
   <div class="w3-container">
     <div>
        <table id="placetable" class="w3-table-all">
        
        </table>
     </div>
  </div>
  
  <div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

    <div id="menu_wrap" class="bg_white">
        <div class="option">
        </div>
        <hr>
        <ul id="placesList"></ul>
        <div id="pagination"></div>
    </div>
    <div id="menu_wrap2" class="bg_white">
        <div class="option">
        </div>
        <hr>
		<div>
        <table id="placesList2"></table>
		</div>
		
        <div>
        <table id="placesList3"></table>
        </div>
        
    </div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=02d94db8e10d97b2ae5cfd31f23e9c4c&libraries=services"></script>
<script>
var mark_index=0;
// 마커를 담을 배열입니다
var markers = [];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
const ps = new kakao.maps.services.Places();  

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});
var maxCallCnt = 0;
var runCnt = 0;
//dataIndexArr=[]
kakaoPlaceData = []
function searchInMethod (data2 ,status, pagination) {
	console.log(runCnt+'=========================')
	console.log(dataIndexArr?.[runCnt]?.addr+'에 있는 =>'+dataIndexArr?.[runCnt]?.statNm+'로 검색하자')
	runCnt++; //placeSearch 메서드의 콜백인데 for문안에서 앞메서드가 돌아서..비동기식이면 배열에 값이 누락됨 그래서 Cnt값으로
				//몇번 돌았는지 체크해줘야함
	console.log('keywordSearch의 콜백 데이터')
	console.log(data2)
	if (status === kakao.maps.services.Status.OK) {//키워드 검색결과 정상일때,
	    // origin
	//	kakaoPlaceData = data2.filter (obj => obj.category_name === '교통,수송 > 자동차 > 전기자동차 충전소');
		
		// convert object
		// data2 = [인천 서구 자동차삼겹살 {음식점}, 인천 서구 자동차삼겹살 {유리ㅏ판매}, 인천 서구 자동차삼겹살 {자동차}]
		for(const dataObj of data2){
			if(dataObj?.categey_name === '교통,수송 > 자동차 > 전기자동차 충전소' || _.isEmpty(dataObj?.categey_name)) {
				console.log("_.isEmpty(dataObj?.categey_name : ", _.isEmpty(dataObj?.categey_name));
				//kakaoPlaceData.push(dataObj);
				searchArr.push(dataObj);
				break;
			} 
			// else -> searchArr.push(고기집.)
		}
		
		if(searchArr.length === 0) {
			searchArr.push(data2[0]);
		}
		
		/* 임시로 닫아놈. 나중에 안되면 풀으셈@###@######@@*/
	//    if(kakaoPlaceData.length==0){
	//    	console.log('충전소 태그 없네 까비')
	//    	kakaoPlaceData = [data2[0]];	
	//    }
	
	   // console.log(dataIndexArr[runCnt-1].statNm+'=>이거로 검색');
	    //console.log(dataIndexArr[runCnt-1].addr+'=>이거는 주소');
		//console.log('밑에가 주소로 filter')
		//console.log(kakaoPlaceData);
	    //searchArr.push(kakaoPlaceData[0]) //카카오
		
		
	} else if (status === kakao.maps.services.Status.ZERO_RESULT) {
 		return;
 		dataIndexArr.splice(runCnt-1,1);
 		console.log('검색결과없음')
 		console.log('searchArr.length2:'+searchArr.length)
		console.log('dataIndexArr.length:'+dataIndexArr.length)
		//검색결과없음
	} else if (status === kakao.maps.services.Status.ERROR) {
		dataIndexArr.splice(runCnt-1,1);
 		console.log('에러가 있음')
	//에러발생했음
	return;
	}
		if(maxCallCnt === runCnt) { // searchInMethod가 다 돌고 나서
			console.log("searchArr 제대로 나와야함. : ", searchArr);
			displayPlaces(searchArr,curPage); // 화면에 리스트 출력
			displayPagination(searchArr); // 페이징 처리 호출 
			console.log(runCnt+'runCnt')
			runCnt = 0;//Cnt 초기화
			maxPage = Math.floor((searchArr.length+14)/15)//최대 페이지num 입력 페이징시 활용
    	} 
}


// 키워드로 장소를 검색합니다
searchArr = [];
//dataIndexArr = [];
// 키워드 검색을 요청하는 함수입니다
function searchPlaces(data) {
	console.log("search places 1111111111111111");
    maxCallCnt = data.length;
    const si22 = $("select[name=si2]").val().substr(0,2)
    if($("select[name=si2]").val().substr(0,2)=='충청'){
		si22 = $("select[name=si2]").val().substr(0,1)+$("select[name=si2]").val().substr(2,1);
	} 
	if($("select[name=si2]").val().substr(0,2)=='전라'){
		si22 = $("select[name=si2]").val().substr(0,1)+$("select[name=si2]").val().substr(2,1);
	}
	if($("select[name=si2]").val().substr(0,2)=='경상'){
		si22 = $("select[name=si2]").val().substr(0,1)+$("select[name=si2]").val().substr(2,1);
	}
    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    for (i=0; i<data.length; i++ ) {
       // searchInMethod
		if(si22==data[i].addr.slice(0,2) ){
       		dataIndexArr.push(data[i])//전기차 자료 검증(지역이 동일하면 넣었음)
       		// param1 - > 이디아 
       		// param1 - > 스타벅스 
       		// param1 - > 전기차 
       		// param1 - > 피시방 
       		// ps.keywordSearch(data[i].addr, searchInMethod)
       		// searchInMethod (data2 ,status, pagination)
       		ps.keywordSearch(data[i].addr, (a, b, c) => searchInMethod(a, b, c))
		}else{
			console.log('검색한 정보는 : '+data[i].addr.slice(0,2)+'지역입니다. 잘못된 데이터에요.')
		}
   } // for
   console.log('dataIndexArr = keywordSearch에 넣은순,'+dataIndexArr.length+'만큼 돕니다.')
   console.log(dataIndexArr)
   console.log("search places Done 222222");
} // searchPlaces
      
    
curPage = 1; //페이징처리하기위한 현재페이지 1로 초기화
// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places,curPage) { //places == searchArr
	console.log('displayPlaces call')
	var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new kakao.maps.LatLngBounds(), 
	maxPage = Math.floor((searchArr.length+14)/15) 
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);
    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    maxCur=15*curPage; //페이징 처리시 1페이지면 15가 max, 2페이지면 30이 max
    if(curPage==maxPage){maxCur = places.length} //페이징 처리시 현재페이지가 maxpage면 data의 length가 max
    for ( var i=15*(curPage-1);i<maxCur;  i++ ) {
        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i-15*(curPage-1)), 
            itemEl = getListItem(i-15*(curPage-1), places[i]); // 검색 결과 항목 Element를 생성합니다

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);
        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function(marker, title) {
            kakao.maps.event.addListener(marker, 'mouseover', function() {
                displayInfowindow(marker, title);
            });
			
            kakao.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
            });

            itemEl.onmouseover =  function () {
                displayInfowindow(marker, title);
            };
            marker.onclick = itemEl.onclick =  function () {//좌측 리스트 onclick 이벤트
                const filteredArray = searchArr.filter(obj => obj.place_name == title);//title이 searchArr에서 가져온거라 ==로 비교 가능
                const dataIndex = searchArr.indexOf(filteredArray[0]);
                const fiteredArray2 = dataIndexArr.filter (obj => obj.addr.slice(6) == filteredArray[0].road_address_name.slice(3));
                $("#placesList2 *").remove();
                $("#placesList3 *").remove();
            	console.log(title)
            	console.log('dataIndexArr.length: '+dataIndexArr.length)
            	console.log('searchArr.length: '+searchArr.length)//filteredArr
            	console.log('이걸로검색해보자 : '+filteredArray[0].road_address_name.slice(3))
            	console.log(fiteredArray2)
            	/////////onclick 시 행안부API 정보
            	let plcaeinfo = '<tr><td>충전소명 : '+fiteredArray2[0].statNm+'</td></tr>'
            	console.log(fiteredArray2[0])
            	let chgerStat = '';
            	if(fiteredArray2[0].stat==='1') {
            		chgerStat = '통신이상'
            	}else if(fiteredArray2[0].stat==='2') {
            		chgerStat = '충전대기완속'
            	}else if(fiteredArray2[0].stat==='3'){
            		chgerStat = '충전중'
            	}else if(fiteredArray2[0].stat==='4'){
            		chgerStat = '운영중지'
            	}else if(fiteredArray2[0].stat==='5'){
            		chgerStat = '점검중'
            	}else if(fiteredArray2[0].stat==='9'){
            		chgerStat = '상태미확인'
            	}
            	plcaeinfo += '<tr><td>충전기 상태 : '+chgerStat+'</td></tr>'
            	plcaeinfo += '<tr><td>realreal : '+fiteredArray2[0].stat+'</td></tr>'
            	plcaeinfo += '<tr><td>이용가능시간 : '+fiteredArray2[0].useTime+'</td></tr>'
            	plcaeinfo += '<tr><td>운영기관 : '+fiteredArray2[0].busiNm+'&nbsp/&nbsp('+fiteredArray2[0].busiCall+')</td></tr>'
            	plcaeinfo += '<tr><td>최근 상태조회 시간 : '+fiteredArray2[0].statUpdDt.substr(2,2)+'년'
    			+fiteredArray2[0].statUpdDt.substr(4,2)+'월'
    			+fiteredArray2[0].statUpdDt.substr(6,2)+'일&nbsp'
    			+fiteredArray2[0].statUpdDt.substr(8,2)+':'+fiteredArray2[0].statUpdDt.substr(10,2)+'</td></tr>'
            	plcaeinfo += '<tr><td>마지막 충전 시작시간 : '+fiteredArray2[0].lastTsdt.substr(2,2)+'년'
            				+fiteredArray2[0].lastTsdt.substr(4,2)+'월'
            				+fiteredArray2[0].lastTsdt.substr(6,2)+'일&nbsp'
            				+fiteredArray2[0].lastTsdt.substr(8,2)+':'+fiteredArray2[0].lastTsdt.substr(10,2)+'</td></tr>'
            	if(fiteredArray2[0].parkingFree=='N'){
            		plcaeinfo += '<tr><td>주차료 : 무료</td></tr>'
            	}else if(fiteredArray2[0].parkingFree=='Y'){
            		plcaeinfo += '<tr><td>주차료 : 유료</td></tr>'
            	}else{
            		plcaeinfo += '<tr><td>주차료 : 현장확인 필요</td></tr>'
            	}
            	if(fiteredArray2[0].limitYn=='Y'){
    	        	plcaeinfo += '<tr><td>이용제한 : '+fiteredArray2[0].limitDetail+'</td></tr>'
            	}
            	$("#placesList2").append(plcaeinfo)
            	//////////onclick 시 카카오맵 api 정보
            	let plcaeinfo2 = '<tr><td>===================</tr></td>'
            	plcaeinfo2 += '<tr><td>카카오맵 api</tr></td>'
            	plcaeinfo2 += '<tr><td>장소명 : '+filteredArray[0].place_name+'</td></tr>'
            	plcaeinfo2 += '<tr><td>장소분류 : '+filteredArray[0].category_name+'</td></tr>'
            	plcaeinfo2 += '<tr><td>주소 : '+filteredArray[0].address_name+'</td></tr>'
            	if(filteredArray[0].phone!=null && filteredArray[0].phone!=''){
            		plcaeinfo2 += '<tr><td>phone : '+filteredArray[0].phone+'</td></tr>'
            	}
            	if(filteredArray[0].road_address_name!=null && filteredArray[0].road_address_name!=''){
	            	plcaeinfo2 += '<tr><td>지번 : '+filteredArray[0].road_address_name+'</td></tr>'
            	}
            	$("#placesList3").append(plcaeinfo2)
            };

            itemEl.onmouseout =  function () {
            infowindow.close();
            };
        })(marker, places[i].place_name);

        fragment.appendChild(itemEl);
        console.log('displayPlaces Done')
    }

    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;
    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}


// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {
   mark_index++
    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
        itemStr += '<span>' + places.road_address_name + '</span>' +
                    '<span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
        itemStr += '<span>' +  places.address_name  + '</span>'; 
    }
	itemStr += '<span class="tel">' + places.phone  + '</span>' +'</div>';           
    el.innerHTML = itemStr;
    el.className = 'item';
    return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });
    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(searchArr) {
    console.log('displayPagination(pagination) 호출')
	var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i;
    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }
	//maxPage = Math.floor(searchArr.length/15)+1
	maxPage = Math.floor((searchArr.length+14)/15)
    for (i=1; i<=maxPage; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

       
            el.onclick = (function(i) {
                return function() {
                    //pagination.gotoPage(i);
                    curPage=i;
                    console.log(curPage+"현재페이지num")
                    displayPlaces(searchArr,i)
                }
            })(i);
        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
    console.log('displayPagination(pagination) Done')
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
    infowindow.setContent(content); //infowindow 에 표시할 내용
    infowindow.open(map, marker);
}

 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}

 $(function(){
    getcity()
     //getText2('si2') 위에 getcity안쓰고 이거만 쓸수있는 방법이있을거같음;;
})
 
 function ecclocationApi() {
	 dataIndexArr = [];
	searchArr = [];
	console.log('ecclocationApi 호출')
	params = "zscode=" + document.getElementById('zscode').value;
    $("#placetable *").remove();
    removeAllChildNods(document.getElementById('placesList'));
    removeMarker();
    $("#placesList2 *").remove();
    $("#placesList3 *").remove();
    mark_index = 0;
    var placeslist = []
	$.ajax({
		url : "${path}/api/ecclocationApi",
		type : "POST",
		data : params,
		success : function(data) {
		//lodash 메서드를 임포트 후 uniqBy를 사용하여 data에서 특정 부분에 유일성을 줬음
 		data = _.uniqBy(data,'statNm')
		data = _.uniqBy(data,'addr')
		data1=data
		 $.each(data, function(i){
		placeslist[i] = data[i].statNm;
	});
	searchPlaces(data)
		},
		error : function(e) {
			alert("충전소 찾다가 에러발생 : "+e.status)
		}
        })
        console.log('ecclocationApi Done')
}
 
 function cityCode() {
     $.ajax("${path}/api/cityCodeApi",{ // Map로 데이터 수신
        success : function(data) {
          },
          error : function(e) {
             alert("place 조회시 서버 오류 발생 : "+e.status)
          }
       })
    }
 
 
 
 
 function getcity(){   //서버에서 문자열로 전달 받기
      $.ajax({
         url : "${path}/api/select",
         success : function(data){
            let arr = data.substring(data.indexOf('[')+1,data.indexOf(']')).split(",");
            $.each(arr,function(i,item){
               // i : 인덱스. 첨자. 0부터 시작
               // item: 배열의 요소
               $("select[name=si2]").append(function(){
                  return "<option>"+item+"</option>"
               })
            })
         }
      })
   }
 
   function getText2(name){
      let city = $("select[name='si2']").val();
      let gu = $("select[name='gu2']").val();
      let disname;
      let toptext="구군을 선택하세요";
      let params="";
      if(name == "si2"){
         params = "si2="+city.trim();
         disname = "gu2";
         $('input[name=zscode]').attr('value','')
         gu=null
      }else if(name == "gu2"){
         params = "si2=" + city.trim() + "&gu2=" + gu.trim();
      } else{
         return;
      }
      $.ajax({
         url : "${path}/api/selectText",
         type : "POST",
         data : params,
         success : function(arr){
            $("select[name="+disname+"] option").remove();
            $("select[name="+disname+"]").append(function(){
               return "<option value=''>"+toptext+"</option>"
            })
            $.each(arr,function(i,item){
               $("select[name="+disname+"]").append(function(){
                  return "<option>"+item+"</option>"
               })
            })
            if(city!=null && gu!=null && city!="" && gu!= ""){ 
               placecode(si2,gu2)
            }
         }
      })
   }
   
    function placecode(si2,gu2){   //서버에서 문자열로 전달 받기
       let city = $("select[name='si2']").val();
      let gu = $("select[name='gu2']").val();
       params = "si2=" + city.trim() + "&gu2=" + gu.trim();
         $.ajax({
            url : "${path}/api/placecode",
            data : params,
            type : "POST",
            success : function(data){
               $('input[name=zscode]').attr('value',data[1].row[0].region_cd.substr(0,5))
            }
         })
      }
   
</script> 
</body>
</html>