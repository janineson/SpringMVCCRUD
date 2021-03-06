<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" http-equiv="Content-Type" content="text/html; charset=UTF-8;width=device-width, initial-scale=1">
<style>
body {
  font-family:Arial,Verdana,sans-serif;
  font-size:80%;
  color:#676767;
}
table {
	text-align:center; 
    margin-left:auto; 
    margin-right:auto; 
    border-collapse: collapse;
    border-spacing: 0;
    width: 50%;
    border: 1px solid #ddd;
}

th, td {
    text-align: left;
    padding: 8px;
}

tr:nth-child(even){background-color: #f2f2f2}

@media screen and (max-width: 991px) {
	table {
	    width: 80%;
	}
}

@media screen and (max-width: 767px) {
	table {
	    width: 100%;
	}
}

.rightAlign{
    text-align: right;
}

/* Add a black background color to the top navigation bar */
.topnav {
    overflow: hidden;
    background-color: #e9e9e9;
}

/* Style the links inside the navigation bar */
.topnav a {
    float: left;
    display: block;
    color: black;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
    font-size: 17px;
}

/* Change the color of links on hover */
.topnav a:hover {
    background-color: #ddd;
    color: black;
}

/* Style the "active" element to highlight the current page */
.topnav a.active {
    background-color: #2196F3;
    color: white;
}

/* Style the search box inside the navigation bar */
.topnav input[type=text] {
    float: right;
    padding: 6px;
    border: none;
    margin-top: 8px;
    margin-right: 16px;
    font-size: 17px;
}

/* When the screen is less than 600px wide, stack the links and the search field vertically instead of horizontally */
@media screen and (max-width: 600px) {
    .topnav a, .topnav input[type=text] {
        float: none;
        display: block;
        text-align: left;
        width: 100%;
        margin: 0;
        padding: 14px;
    }
    .topnav input[type=text] {
        border: 1px solid #ccc;
    }
}



</style>
<title>공지사항</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	//see boardcontroller createPOST flashattribute
    var result ='${msg}';
    
/*     if(result != '성공' && result != ''){
    	alert("Validation " + result);
    }

     */
    $(function(){
    	 $("#keyword").focus();
    	  $('#keyword').keypress(function (e) {
    		 var key = e.which;
    		 if(key == 13)  // the enter key code
    		  {
    			 $("#search").submit();
    		  }
    		});  
    
	  
/* 	      
	      $('#keyword').on('keypress', function (event) {
	    	    var regex = new RegExp("^[a-zA-Z0-9]+$");
	    	    var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);
	    	    if (!regex.test(key)) {
	    	       event.preventDefault();
	    	       return false;
	    	    }
	    	});
 */
	});
    
    
    function deleteItem(no, title){
	  	var del = confirm(title + " 삭제하시겠습니까?");
	    if (del == true) {
	    	window.location.href = "delete.do?no=" + no + "<c:if test='${not empty queryString}'>${queryString}</c:if>";
	    } else {
	        e.preventDefault();
	    }
  
  }

    function deleteSelected(){
    	var frm = document.form;

    	var isChecked = false;
	   	 $(':checkbox').each(function() {
	   		 if (this.checked){
	   		 	isChecked = true;
	   		 }
	   		 
	           
	        });
	   	 
	   	 if (isChecked){
	       	 if(confirm("선택된 항목을 삭제하시겠습니까?")) {
	       			frm.submit();
	       		}
	       		
	        }else{
	       	 alert("삭제할 항목을 먼저 선택하세요.");
	       		return false;
	
	        }     
	        


    }
    //toggle checkbox
    function selectAll (evt){  
        if(evt.checked) {
            // Iterate each checkbox
            $(':checkbox').each(function() {
                this.checked = true;                        
            });
        } else {
            $(':checkbox').each(function() {
                this.checked = false;                       
            });
        }
    }
</script>
 

</head>
<body>

<div id="menu">
  <table>
  		<tr>
            <th><h1 align="left"><a href="mList.do">공지사항 관리</a></h1></th>
            <th><h2 align="right"><a href="list.do">관리자 모드 나가기 </a></h2></th>
        </tr>
  </table>
</div>
<div id="menu">
<form id="search" name="search" method="get">
 <table>
  		<tr>
  			
  			<th class="rightAlign"  >
  			  	<input type="text" name="keyword"  id="keyword" style="vertical-align: middle" value="${keyword}">

  			 	<input class="btn_button" type="submit" value="검색" id="btnSearch" style="vertical-align: middle"/>
           </th>
        </tr>
  </table>
</form>	       
</div>
<form id="form" name="form" method="post" action="?${_csrf.parameterName}=${_csrf.token}">

    <table class="table table-board" border="1px" style="margin-bottom: 5px"  >
        <tr>
         	<th><input type="checkbox" name="checkAll"
							onclick="selectAll(this);" /></th>
            <th>NO.</th>
            <th>제목</th>
            <th>사용여부</th>
            <th>등록일</th>
            <th>관리</th>
        </tr>
 
 		<c:if test="${not empty notice}">
		    <c:forEach var="item" items="${notice}" varStatus="status">
		    <input type="hidden" name="listLength" value="${fn:length(notice)}" />
		    <input type="hidden" name="page" value="${page}">
		    
		        <tr>
		        	<td><input type="checkbox"
										name="no_<c:out value="${status.index}"/>"
										value="<c:out value="${item.no}"/>" /></td>
		            <td>
						<c:set var="no" value="${totalRows - status.index - currentPage}"/>
						<c:out value="${no}"/>
		            </td>
		            <td><a href="mDetail.do?no=${item.no}&page=${page}<c:if test='${not empty urlParam}'>${urlParam}</c:if>"> <c:if test="${'Y' == item.stickyYn}">[공지]</c:if> ${item.title }</a></td>
		            <td><c:if test="${item.useYn == 'Y'}">
						사용
					</c:if>
					<c:if test="${item.useYn == 'N'}">
						미사용
					</c:if></td>
		            <td>	<c:if test="${empty item.modDttm}"><fmt:formatDate pattern="yyyy-MM-dd" value="${item.crtDttm}" /></c:if>
	    			<c:if test="${not empty item.modDttm}"><fmt:formatDate pattern="yyyy-MM-dd" value="${item.modDttm}" /></c:if></td>
		            <td><a href="edit.do?no=${item.no}&page=${page}<c:if test='${not empty urlParam}'>${urlParam}</c:if>">수정</a> | <a href="javascript:void(0);" onclick="deleteItem(${item.no},'${item.title}')">삭제</a></td>
		        </tr>
		       
		    </c:forEach>
	    </c:if>
	    
	    <c:if test="${empty notice}">
	        	<td colspan="6" style="text-align: center">검색 결과가 없습니다.</td>
	    </c:if>

    </table>
</form>
  <table style="border: 0px;">
  		<tr>
            <th>
              <h2 align="left"><a href="javascript:void(0);" onclick="deleteSelected();">선택삭제 </a></h2></th>
               <th><h2 align="right"><a href="write.do">신규등록 </a></h2></th>
        </tr>
  </table>
<c:if test="${listCount > 1}">
	 <div id="pager">  
		 <div id = "defaultMode" align="center">
		    <c:forEach var = "i" begin = "1" end = "${listCount}">
		         <a href="mList.do?page=${i}<c:if test="${not empty urlParam}">${urlParam}</c:if>">${i}</a>
		         <span style="padding-right: 10px;"></span>
		    </c:forEach>
		 </div>
		
	</div>		
</c:if>	   
</body>
</html>
