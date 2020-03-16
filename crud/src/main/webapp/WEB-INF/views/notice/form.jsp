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
	font-family: Arial, Verdana, sans-serif;
	font-size: 80%;
	color: #676767;
}

table {
	text-align: center;
	margin-left: auto;
	margin-right: auto;
	border-collapse: collapse;
	border-spacing: 0;
	width: 50%;
	border: 1px solid #ddd;
}

th, td {
	text-align: left;
	padding: 8px;
}

tr:nth-child(even) {
	background-color: #f2f2f2
}

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

.lbl {
	width: 25%
}

.input {
	width: 75%
}

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

.error {
	font-size: 12px;
	color: red;
}
</style>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  

<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>  
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.js"></script>

<script type="text/javascript">

    $(function(){
	    	$.datepicker.setDefaults({
	    	     dateFormat: 'yy-mm-dd'
	    	});
    	  $( "#stickyStrDate" ).datepicker({
    	  });
    	  $( "#stickyEndDate" ).datepicker({
    	  });
    	  $( "#postingDate" ).datepicker({
    	  });
    	 
    	  if ($( "#postingDate" ).val()==''){
    		  $( "#postingDate" ).datepicker("setDate",new Date());
    		  
    	  }else{
    		  $("#postingDate").datepicker("setDate", $("#postingDate").val());
    		  
    	  }
    	
    	 
    	  //client side validation
	      $("#form").validate({
	        // Specify validation rules
	        rules: {
	          // The key name on the left side is the name attribute
	          // of an input field. Validation rules are defined
	          // on the right side
	          title: { required: true },
	          contents:  { required: true },
	          author:  { required: true }	          
	        },
	        // Specify validation error messages
	        messages: {
	        	title: " 제목을 입력하세요",
	        	contents: "내용을 입력하세요",
	        	author: "작성자를 입력하세요"
	        },
	        // Make sure the form is submitted to the destination defined
	        // in the "action" attribute of the form when valid
	        submitHandler: function(form) {
	          form.submit();
	        }
	      });

		$('#stickyY').click(function(){
			$('#stickyStrDate').removeAttr('disabled');
			$('#stickyEndDate').removeAttr('disabled');
		
		});
		
		$('#stickyN').click(function(){
			$('#stickyStrDate').attr("disabled", 'disabled');
			$('#stickyEndDate').attr("disabled", 'disabled');
		});
		
		<c:if test="${empty notice.stickyYn or 'N' == notice.stickyYn}">
			$('#stickyStrDate').attr("disabled", 'disabled');
			$('#stickyEndDate').attr("disabled", 'disabled');
		</c:if>

    });
    
   	
</script>
<title>공지사항</title>
</head>
<body>
<div id="menu">
  <table>
  		<tr>
            <th><h1 align="left"><a href="mList.do">공지사항</a> <c:if test="${ empty notice}">등록</c:if><c:if test="${not empty notice}">수정</c:if> </h1></th>
        </tr>
  </table>
</div>

    <form action="/board/notice/<c:if test="${empty notice}">write</c:if><c:if test="${not empty notice}">edit</c:if>.do" method="POST" id="form">
        <input type="hidden" name="page" value="${page}">
	    <input type="hidden" name="keyword" value="${keyword}">
	  
		<c:if test="${not empty notice}">
			<input type="hidden" name="no" value="${notice.no}"/>
		</c:if>
    	<table class="table table-board" border="1px" >
    		<tr class="createForm">
    			<th class="lbl" > <label for="useY">사용여부</label></th>
    			<td class="input"><input type="radio" id="useY" name="useYn" value="Y" <c:if test="${'Y' == notice.useYn}">checked</c:if>> <label for="useY">사용</label>
    					<input type="radio" id="useN" name="useYn" value="N" <c:if test="${'N' == notice.useYn or empty notice.useYn}">checked</c:if>> <label for="useN">미사용</label></td>
    		</tr>
    		<tr class="createForm">
    			<th class="lbl" > <label for="stickyY">공지여부</label></th>
    			<td class="input"><input type="radio" id="stickyY" name="stickyYn" value="Y" <c:if test="${'Y' == notice.stickyYn}">checked</c:if>> <label for="stickyY">YES</label>
    					<input type="radio" id="stickyN" name="stickyYn" value="N" <c:if test="${'N' == notice.stickyYn or empty notice.stickyYn}">checked</c:if>> <label for="stickyN">NO</label></td>
    		</tr>
    		<tr class="createForm">
    			<th class="lbl" > <label for="stickyStrDate">공지 시작날짜</label></th>
    			<td class="input"><input type="text" id="stickyStrDate"  name="stickyStrDate" class="createForm" value="<fmt:formatDate value="${notice.stickyStrDate}" 
											pattern="yyyy-MM-dd"/>"></td>
    		</tr>
    		<tr class="createForm">
    			<th class="lbl" > <label for="stickyEndDate">공지 마지막날짜</label></th>
    			<td class="input"><input type="text" id="stickyEndDate"  name="stickyEndDate" class="createForm" value="<fmt:formatDate value="${notice.stickyEndDate}" 
											pattern="yyyy-MM-dd"/>"></td>
    		</tr>
    		<tr class="createForm">
    			<th class="lbl" > <label for="postingDate">게시일자</label></th>
    			<td class="input"><input type="text" id="postingDate" name="postingDate" data-date-format="yyyy-mm-dd" class="createForm" value="<fmt:formatDate value="${notice.postingDate}" 
											pattern="yyyy-MM-dd"/>"></td>
    		</tr>
    		<tr class="createForm">
    			<th class="lbl" > <label for="title">제목 *</label></th>
    			<td class="input"><input type="text" name="title" id="title" class="createForm"  style="width:100%;" value="${notice.title}" maxlength="30"></td>
    		</tr>
    		<tr class="createForm">
    			<th class="lbl"> <label for="contents">내용 *</label></th>
    			<td class="input"><textarea rows="6" cols="30" name="contents" id="contents" class="createForm"  style="width:100%;" onkeypress="if (this.value.length > 500) { return false; }">${notice.contents}</textarea></td>
    		</tr>
    		<tr class="createForm">
    			<th class="lbl"><label for="author">작성자 *</label></th>
    			<td class="input">  <input type="text" name="author" id="author" class="createForm" maxlength="30" style="width:100%;" value="<c:if test="${empty notice.modUser}">${notice.author}</c:if><c:if test="${not empty notice.modUser}">${notice.modUser}</c:if>"></td>
    		</tr>
    		<tr class="Formfooter">
    			<td class="lbl"></td>
    			<td class="input">  
	    			<input  id="submit" class="btn_button" type="submit" value="<c:if test="${ empty notice}">등록</c:if><c:if test="${not empty notice}">수정</c:if>하기" style="float: right "/>
    			</td>
    		</tr>	
    	</table>
    </form>
</body>
</html>
