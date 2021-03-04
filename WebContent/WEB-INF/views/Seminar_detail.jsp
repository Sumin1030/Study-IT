<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>세미나 및 공모전</title>

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/detailpage.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.css">
<link href="css/bootstrap.min.css">
<script src="https://kit.fontawesome.com/5cdf4f755d.js" crossorigin="anonymous"></script>
<script type="text/javascript">

	$(document).ready(function() {
	    $('#commentBox').on('keyup', function() {
	        $('#commentCnt').html("("+$(this).val().length+" / 300)");
	 
	        if($(this).val().length > 300) {
	            $(this).val($(this).val().substring(0, 300));
	            $('#commentCnt').html("(300 / 300)");
	        }
	    });
	});
	
	
	$(function()
	{
		// 테스트
		//alert("확인");
		
		
		// 수정 버튼 클릭 시 액션 처리
		$(".updateBtn").click(function()
		{
			//alert("수정 버튼 클릭");
			//alert($(this).val());
			$(location).attr("href", "seminarupdateform.action?post_code=" + $(this).val());
		
		});
		
		// 삭제 버튼 클릭 시 
		$(".deleteBtn").click(function()
		{
			//alert("삭제 버튼 클릭");
			//alert($(this).val());
			
			if (confirm("현재 선택한 데이터를 정말 삭제하시겠습니까?"))
			{
				$(location).attr("href", "seminardelete.action?post_code=" +$(this).val());
			}
		});
		
		$(".btnRec").click(
        function()
        {
           $(location).attr(
                 "href",
                 "seminar_rec.action?check=1&post_code="
                       + $(this).val());
        });

      	$(".btnNotRec").click(
         function()
         {
            $(location).attr(
                  "href",
                  "seminar_rec.action?check=2&post_code="
                        + $(this).val());
         });
      	
      // 댓글 수정 누르면 수정 폼 
      $(".cmtUpdateBtn").click(function() {
    	  	
			var comment_code = $(this).val();
			//alert(comment_code);
			$.post("getseminarcomm.action?comment_code="+comment_code
			, function(cmtList)
			{
				$("#commentBox").val(cmtList);
				$("#commBtn").html("수정");
				$("#commForm").attr({"action":"modifyseminarcomm.action?comment_code="+comment_code});
				
			});
			
		}); 
      
		
		// 댓글 삭제 버튼 클릭 시 
		$(".cmtDelBtn").click(function()
		{
			//alert("삭제 버튼 클릭");
			//alert($(this).val());
			
			if (confirm("현재 선택한 데이터를 정말 삭제하시겠습니까?"))
			{
				$(location).attr("href", "seminarcmtdelete.action?comment_code=" + $(this).val());
			} 
		});  
		
		
		
	});

	
	function chk()
	{
		if(confirm("현재 선택한 데이터를 정말 신고하시겠습니까?"))
		{
			return true;
		}
		return false;
	}

</script>
   
</head>
<body>
<div class="wrapper">
 <jsp:include page="header.jsp" flush="false"/>
 <div class="main-content text-center"><br>
 
 	<!-- 메뉴 구성 영역 -->
 	<div class="menu">
	<br> 
		<h1 class="text-center">정보공유</h1>
		<br><br><br>
		<nav>
			<ul id="menu">
				<li><a href="informlist.action">IT기술정보공유</a></li>
				<li><a href="seminarlist.action" class="selected">세미나 및 공모전</a></li>
				<li><a href="interviewlist.action">면접/코딩테스트 후기</a></li>
				<li><a href="freelist.action">자유게시판</a></li>
				<li><a href="questionlist.action">Q&A</a></li>
			</ul>
		</nav>
	</div>

	<div class="main">
		<form action="seminarupdateform.action" method="get" name="myForm">
		<table id="table1" class="table">
		<input type="hidden" name="post_code" value="${detail.post_code}">
			<tr>
				<th colspan="2">${detail.seminar_category }</th>
				<th colspan="6" style="background-color: #ffffff;">${detail.title}</th>
			</tr>

			<tr>
					<th>작성자</th>
					<td>${detail.id}</td>
					<th>작성일</th>
					<td>${detail.write_date }</td>
					<th>조회수</th>
					<td>${detail.hitcount}</td>
					<th>추천수</th>
					<td>${detail.rec }</td>
				</tr>
			<tr>
				<th>모집시작</th>
				<td colspan="3">${detail.start_date}</td>
				<th>모집마감</th>
				<td colspan="3">${detail.end_date}</td>
			
			</tr>
        
        	<tr>
				<td colspan="8" style="height: 300px;">${detail.content }</td>
			</tr>
			<!-- <tr>
				<td colspan="8">
					<div class="BoardDetail_noLine">
						이전글 : (1) 반갑습니다
					</div>.BoardDetail_noLine
				</td>
			</tr>
			<tr>
				<td colspan="8">
					<div class="BoardDetail_noLine">
						다음글 : (3) 개발자입니다
					</div>.BoardDetail_noLine
				</td>
			</tr> -->
			<tr>
				<td colspan="4" style="border-bottom: #ffffff;">
					<input type="button" value="리스트" class="btn btn-outline-primary btn-sm"
					onclick="location.href='seminarlist.action'">
				</td>
				
				<!--  관리자 로그인 -->
				<td colspan="4" style="text-align: right; border-bottom: #ffffff;">
			        <c:if test="${sessionScope.code == null}">
			     		<input type="button" value="신고" class="btn btn-outline-danger btn-sm" disabled="disabled">
			        </c:if>
			        
			        <c:if test="${sessionScope.admin==null && sessionScope.code != null && detail.user_code==sessionScope.code}">
			            <button type="submit" class="btn btn-outline-primary btn-sm updateBtn"
								value="${detail.post_code }">수정</button>
						<button type="button" class="btn btn-outline-primary btn-sm deleteBtn"
								value="${detail.post_code}">삭제</button>
			        </c:if>
			        
			        <c:if test="${sessionScope.code == 'admin'}">
			     		<button type="button" class="btn btn-outline-primary btn-sm deleteBtn"
								value="${detail.post_code}">삭제</button>
			        </c:if>
			       
			        
			        <c:if test="${sessionScope.admin==null && sessionScope.code != null && detail.user_code != sessionScope.code}">
			            <button type="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" data-bs-target="#staticBackdrop" 
			            	${check=="different" ?  "" : "style=\"display:inline;\"" }
							${chkReport==0 ?  "" : "disabled = \"disabled\"" }>
		                    ${chkReport==0 ?  "신고하기" : "신고완료" } 
		                </button>
		                
		                
			        </c:if>
			        
			        
				</td>
			</tr>
		</table>
		 </form>
		 <!-- Modal -->
         <form action="seminarreport.action" method="post" onsubmit="return chk()">
         	<input type="hidden" name="post_code" value="${param.post_code }" />
           	<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
             	<div class="modal-dialog">
               		<div class="modal-content">
                 		<div class="modal-header">
                   			<h5 class="modal-title" id="staticBackdropLabel">게시글 신고</h5>
                   			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                 		</div>
                 		<div class="modal-body"> 
                      		신고 카테고리<br>
                     		<select name="post_report_ctg_code" id="post_report_ctg_code" class="form-control">
							<c:forEach var="ctg" items="${reportctg }">
								<option value="${ctg.post_report_ctg_code }">${ctg.post_report_ctg }</option>	
							</c:forEach>
							</select>
             
                   			<hr>                  
                     		신고 내용 <br>
                     		<div>
                       			<textarea class="form-control" rows="7" cols="20" id="report_reason" name="report_reason" placeholder="내용을 입력하세요."></textarea>
                   			</div>
                 		</div>
                 
                 		<div class="modal-footer">
                   			<button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">취소</button>
                   			<button type="submit" class="btn btn-primary">제출</button>
                 		</div>
              		</div>
             	</div>
           	</div>
       	</form> 
		<br><br>
		
		<table id="commentHeader" class="table">
				<tr>
					<td>
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-right-text" viewBox="0 0 16 16">
							<path d="M2 1a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h9.586a2 2 0 0 1 1.414.586l2 2V2a1 1 0 0 0-1-1H2zm12-1a2 2 0 0 1 2 2v12.793a.5.5 0 0 1-.854.353l-2.853-2.853a1 1 0 0 0-.707-.293H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h12z"/>
							<path d="M3 3.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zM3 6a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9A.5.5 0 0 1 3 6zm0 2.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z"/>
						</svg> 
						댓글 ${cmtCount }
					</td>
					<td>
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hand-thumbs-up" viewBox="0 0 16 16">
						 	<path d="M8.864.046C7.908-.193 7.02.53 6.956 1.466c-.072 1.051-.23 2.016-.428 2.59-.125.36-.479 1.013-1.04 1.639-.557.623-1.282 1.178-2.131 1.41C2.685 7.288 2 7.87 2 8.72v4.001c0 .845.682 1.464 1.448 1.545 1.07.114 1.564.415 2.068.723l.048.03c.272.165.578.348.97.484.397.136.861.217 1.466.217h3.5c.937 0 1.599-.477 1.934-1.064a1.86 1.86 0 0 0 .254-.912c0-.152-.023-.312-.077-.464.201-.263.38-.578.488-.901.11-.33.172-.762.004-1.149.069-.13.12-.269.159-.403.077-.27.113-.568.113-.857 0-.288-.036-.585-.113-.856a2.144 2.144 0 0 0-.138-.362 1.9 1.9 0 0 0 .234-1.734c-.206-.592-.682-1.1-1.2-1.272-.847-.282-1.803-.276-2.516-.211a9.84 9.84 0 0 0-.443.05 9.365 9.365 0 0 0-.062-4.509A1.38 1.38 0 0 0 9.125.111L8.864.046zM11.5 14.721H8c-.51 0-.863-.069-1.14-.164-.281-.097-.506-.228-.776-.393l-.04-.024c-.555-.339-1.198-.731-2.49-.868-.333-.036-.554-.29-.554-.55V8.72c0-.254.226-.543.62-.65 1.095-.3 1.977-.996 2.614-1.708.635-.71 1.064-1.475 1.238-1.978.243-.7.407-1.768.482-2.85.025-.362.36-.594.667-.518l.262.066c.16.04.258.143.288.255a8.34 8.34 0 0 1-.145 4.725.5.5 0 0 0 .595.644l.003-.001.014-.003.058-.014a8.908 8.908 0 0 1 1.036-.157c.663-.06 1.457-.054 2.11.164.175.058.45.3.57.65.107.308.087.67-.266 1.022l-.353.353.353.354c.043.043.105.141.154.315.048.167.075.37.075.581 0 .212-.027.414-.075.582-.05.174-.111.272-.154.315l-.353.353.353.354c.047.047.109.177.005.488a2.224 2.224 0 0 1-.505.805l-.353.353.353.354c.006.005.041.05.041.17a.866.866 0 0 1-.121.416c-.165.288-.503.56-1.066.56z"/>
						</svg> 
						추천 ${detail.rec } 
					</td>
					<td>
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hand-thumbs-down" viewBox="0 0 16 16">
  							<path d="M8.864 15.674c-.956.24-1.843-.484-1.908-1.42-.072-1.05-.23-2.015-.428-2.59-.125-.36-.479-1.012-1.04-1.638-.557-.624-1.282-1.179-2.131-1.41C2.685 8.432 2 7.85 2 7V3c0-.845.682-1.464 1.448-1.546 1.07-.113 1.564-.415 2.068-.723l.048-.029c.272-.166.578-.349.97-.484C6.931.08 7.395 0 8 0h3.5c.937 0 1.599.478 1.934 1.064.164.287.254.607.254.913 0 .152-.023.312-.077.464.201.262.38.577.488.9.11.33.172.762.004 1.15.069.13.12.268.159.403.077.27.113.567.113.856 0 .289-.036.586-.113.856-.035.12-.08.244-.138.363.394.571.418 1.2.234 1.733-.206.592-.682 1.1-1.2 1.272-.847.283-1.803.276-2.516.211a9.877 9.877 0 0 1-.443-.05 9.364 9.364 0 0 1-.062 4.51c-.138.508-.55.848-1.012.964l-.261.065zM11.5 1H8c-.51 0-.863.068-1.14.163-.281.097-.506.229-.776.393l-.04.025c-.555.338-1.198.73-2.49.868-.333.035-.554.29-.554.55V7c0 .255.226.543.62.65 1.095.3 1.977.997 2.614 1.709.635.71 1.064 1.475 1.238 1.977.243.7.407 1.768.482 2.85.025.362.36.595.667.518l.262-.065c.16-.04.258-.144.288-.255a8.34 8.34 0 0 0-.145-4.726.5.5 0 0 1 .595-.643h.003l.014.004.058.013a8.912 8.912 0 0 0 1.036.157c.663.06 1.457.054 2.11-.163.175-.059.45-.301.57-.651.107-.308.087-.67-.266-1.021L12.793 7l.353-.354c.043-.042.105-.14.154-.315.048-.167.075-.37.075-.581 0-.211-.027-.414-.075-.581-.05-.174-.111-.273-.154-.315l-.353-.354.353-.354c.047-.047.109-.176.005-.488a2.224 2.224 0 0 0-.505-.804l-.353-.354.353-.354c.006-.005.041-.05.041-.17a.866.866 0 0 0-.121-.415C12.4 1.272 12.063 1 11.5 1z"/>
						</svg> 
						비추천 ${detail.notrec }</td>
					<td>
                        <!-- <input type="button" value="추천" class="btn btn-outline-primary btn-sm btnRec"> -->
                        <button type="button" value="${detail.post_code }"
                           class="btn btn-outline-primary btn-sm btnRec">추천</button> <!-- <input type="button" value="비추천" class="btn btn-outline-primary btn-sm btnNotRec"> -->
                        <button type="button" value="${detail.post_code }"
                           class="btn btn-outline-primary btn-sm btnNotRec">비추천</button>
                     </td>
				</tr>
				
			</table>
		
		
	
		<table id="table2" class="table">
				<c:forEach var="comment" items="${cmtList }">
				<input type="hidden" name="code" value="${sessionScope.code}">
				<input type="hidden" id="comment_code" value="${comment.comment_code }" />
				<input type="hidden" id="post_code" value="${detail.post_code}">
				<tr>
			 		<th style="width: 10%">${comment.user_id }</th>
					<c:if test="${sessionScope.code!=null && sessionScope.code==comment.user_code}">
						<td id="comment" style="width: 60%;">${comment.comments }</td>
			     		<td style="width: 5%">
			     			<!-- 댓글 수정 -->
                             <button name="comment_code" type="submit" style="color: black;" class="btn btn-link btn-sm cmtUpdateBtn"
                             value="${comment.comment_code }">
                             	<svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
                                  <path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5L13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175l-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z"/>
                                </svg>
                             </button>     
                    	</td>
                    	<td style="width: 5%">
                    		<!-- 댓글 삭제 -->
                             <button  style="color: black;" class="btn btn-link btn-sm cmtDelBtn"
                             value="${comment.comment_code }">
                             	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                                     <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                                     <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
                                </svg>
                             </button> 
                    	</td> 
                    	<td style="width: 8%; text-align: right;">${comment.write_date }</td>
			        </c:if>
			        
			        <c:if test="${sessionScope.code == null}">
			        	<td id="comment" style="width: 65%;">${comment.comments }</td>
			       		<td colspan="3">${comment.write_date }</td>
			        </c:if>
			        
			        <c:if test="${sessionScope.code!=null && sessionScope.code!=comment.user_code}">
			        	<td id="comment" style="width: 65%;">${comment.comments }</td>
			       		<td colspan="3">${comment.write_date }</td>
			        </c:if>
			        
			        <c:if test="${sessionScope.code == 'admin'}">
			        	<td id="comment" style="width: 55%;">${comment.comments }</td>
                    	
                    	<td style="width: 6%">
                             <a style="color: black;" class="cmtDelBtn"><!-- 삭제버튼 -->
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                                     <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                                     <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
                                </svg>
                             </a>
                    	</td> 
                    	<td style="width: 10%">${comment.write_date }</td>
			        </c:if>
			 	</tr>
				</c:forEach>
			</table>
			
			
			
			
			
			
			<div id="commentFooter">
				<p>${pageIndexList }</p>
			</div><!-- #commentFooter -->
			
		<form action="semicmtinsert.action" method="post" name="myForm" id="commForm">
		<input type="hidden" name="code" value="${sessionScope.code}">
		<input type="hidden" name="post_code" value="${detail.post_code}">
		<input type="hidden" name="comment_code" value="${comment.comment_code}">
		<table id="commentWrite" class="table">
			<tr>
		 		<td colspan="2">
		 			<c:if test="${sessionScope.code == null}">
			     		 <textarea id="commentBox" name="comments" cols="" rows="" 
						class="form-control" placeholder="로그인 후에 댓글을 등록할 수 있습니다." readonly="readonly"></textarea>
						</textarea>
			        </c:if>
			        
			        <c:if test="${sessionScope.code != null}">
			            <textarea id="commentBox" name="comments" cols="" rows="" 
						class="form-control" placeholder="댓글을 입력하세요."></textarea>
			        </c:if>
			        
			        <c:if test="${sessionScope.code == 'admin'}">
			     		<textarea id="commentBox" name="comments" cols="" rows="" 
						class="form-control" placeholder="댓글을 입력하세요."></textarea>
			        </c:if>
		 		</td>
		 	</tr>
		 	<tr>
		 		<td>
			 		<div id="commentCnt">(0 / 300)</div>
			 	</td>
			 	<td>
			 		<c:if test="${sessionScope.code == null}">
			     		<button type="submit" class="btn btn-outline-primary btn-sm btn2" disabled="disabled">등록</button>	
			        </c:if>
			        
			        <c:if test="${sessionScope.code != null}">
			            <button type="submit" class="btn btn-outline-primary btn-sm btn2" id="commBtn">등록</button>	
			        </c:if>
			        
			        <c:if test="${sessionScope.code == 'admin'}">
			     		<button type="submit" class="btn btn-outline-primary btn-sm btn2" id="commBtn">등록</button>	
			        </c:if>
   				</td>
		 	</tr>	
		</table>
		
		</form>

	</div><!-- .main -->
	

	
   
  </div>
 <jsp:include page="footer.jsp" flush="false"/>
 </div>
 
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
</body>
</html>