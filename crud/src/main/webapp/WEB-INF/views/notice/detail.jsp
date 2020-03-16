<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
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

	.lbl{ width: 20%}
	.lbl2{ width: 10%}
	.lbl3{ width: 5%}
	.input{ width: 75%}
	.del{color: red;}
	.btn_button {
     	background-color: #008CBA;
	    border: none;
	    color: white;
	    padding: 10px 24px;
	    text-align: center;
	    text-decoration: none;
	    display: inline-block;
	    cursor: pointer;
	}
	.del_button {
     	background-color: red;
	    border: none;
	    color: white;
	    padding: 10px 24px;
	    text-align: center;
	    text-decoration: none;
	    display: inline-block;
	    cursor: pointer;
	}
	pre {
	  font-size: 12px;
	}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){

	$('.del').click(function (e) {
	
		var b_titleid = $(this).attr('id');

	    var r = confirm(b_titleid.split("_")[0] + " 삭제하시겠습니까?");
	    if (r == true) {
	    	window.location.href = "delete?b_no=" + b_titleid.split("_")[1];
	    } else {
	        e.preventDefault();
	    }
	});
	
});
</script>
<title>공지사항</title>
</head>
<body>
<div id="menu">
  <table>
  		<tr>
            <th><h1 align="left"><a href="list.do">공지사항</a> </h1></th>
        </tr>
  </table>
</div>

   	<table class="table table-board" border="1px" >
    		<tr class="createForm">
    			<th class="lbl3"> <label >제목</label></th>
    			<td class="lbl"><label name="title">${notice.title}</label></td>
    			<th class="lbl3"> <label >게시일</label></th>
    			<td class="lbl2"><fmt:formatDate pattern="yyyy-MM-dd" value="${notice.postingDate}" /></td>
    		</tr>
    		<tr class="createForm">
    			<th class="lbl3">작성자</th>
    			<td class="lbl"><c:if test="${empty notice.modUser}">${notice.author}</c:if><c:if test="${not empty notice.modUser}">${notice.modUser}</c:if>	</td>
    			<th class="lbl3">조회수</th>
    			<td class="lbl2">${notice.viewCount}</td>
    		</tr>
			<tr class="createForm">
    			<th class="lbl3"> <label >내용</label></th>
    			<td colspan="3"><pre><label name="contents" >${notice.contents}</label></pre></td>
    		</tr>
    		
    		<tr class="Formfooter">
    			<td></td>
    			<td class="input" colspan="5">  
   
    			<input class="btn_button" type="button" value="목록" style="float: right " onClick="location.href='list.do'"/>
    			</td>
    		</tr>
    		
    		
    	</table>
</body>
</html>
