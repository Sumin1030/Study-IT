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
<title>FreeBoard_list.jsp</title>

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/list.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js/util.js"></script>
<!-- 테이블 정렬 JS -->
<script type="text/javascript" src="<%=cp %>/js/jquery.tablesorter.min.js"></script>
<!-- 테이블 정렬 css -->
<link rel="stylesheet" href="<%=cp %>/css/theme.default.min.css">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<title>Mypage_evaluationComplete</title>
<script src="https://kit.fontawesome.com/5cdf4f755d.js" crossorigin="anonymous"></script>
<style type="text/css">
#table2 th{text-align: center;}
#table2 th:nth-child(1){width: 50px;}
#table2 th:nth-child(2){width: 460px;}
#table2 th:nth-child(3){width: 100px;}
#table2 th:nth-child(4){width: 100px;}
#table2 th:nth-child(5){width: 55px;}
#table2 th:nth-child(6){width: 55px;}
#table2 td{text-align: center;}
#table2 td:nth-child(2){text-align: left;}
</style>
<script type="text/javascript">

	function sendIt()
	{
		//alert("호출");
		
		f = document.myForm;
	
		// 검색어 입력 확인
		str = f.searchValue.value;
		str = str.trim();
		
		if(!str)
		{
			alert("\n검색어를 입력하세요");
			f.searchValue.focus();
			return; 
		} 
	}
	
	function clickPost(post_code)
	{
		//alert("호출 확인");
		//alert(post_code);
		window.location.href="freeboard_detail.action?post_code="+post_code;
	}
	
</script>
<script type="text/javascript">
	$(document).ready(function()
	{
		$(".btnWrite").click(function()
		{
			$(location).attr("href", "freeboard_insert_form.action");
		});
		
		$(".btnRefresh").click(function()
		{
			$(location).attr("href", "freeboardlist.action");
		});
		
		$("#table2").tablesorter(
		{ 
			headers: 
			{	// 조회수, 추천수, 날짜순 이외의 항목으로는 정렬할 수 없도록 설정
				'.num, .title, .writer' : 
				{
					sorter: false
				}
			}
		});
		
	});
</script>
<style type="text/css">
	.page a
	{
		text-decoration: none;
		color: Slateblue;
		
	}
	.page a:hover
	{
		color: Slateblue;
		font-weight: bold;
	}
</style>
</head>
<body>
<div class="wrapper">
	<jsp:include page="header.jsp" flush="false"/>
	<div class="main-content text-center" ><br>
	 
		<!-- 좌측 메뉴 구성 영역 -->
		<c:import url="BoardMenu.jsp"></c:import>
	
		<!-- 메인 콘텐츠 영역 -->
		<div class="main">
			<form action="freeboardlist.action" name="myForm">
					<table id="table1" class="table" style="margin-right: 30px;">
						<tr>
							<td>
								<select name="searchKey" id="searchKey" class="form-control">
									<option value="">선택</option>
									<option value="title">제목</option>
									<option value="user_id">작성자</option>
									<option value="content">내용</option>
								</select>
								<input type="text" name="searchValue" id="searchValue" class="form-control" placeholder="검색어를 입력하세요.">
								<input type="submit" value="검색" id="searchBtn" class="btn btn-outline-primary btn-sm">	
							</td>
						</tr>
					</table>
					
					<table id="table2" class="table table-striped table-hover tablesorter">
						<thead>
							<tr> 
								<th class="num">번호</th>
								<th class="title">제목</th>
								<th class="writer">작성자</th>
								<th>작성일</th>
								<th>조회수</th>
								<th>추천수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="post" items="${list }">
								<tr onclick="clickPost('${post.post_code }')">
									<td>${post.post_num }</td>
									<td>${post.title }</td>
									<td>${post.user_id}</td>
									<td>${post.write_date }</td>
									<td>${post.hitcount }</td>
									<td>${post.rec }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
		
					<div id=btnSet>
						<input type="button" value="글쓰기" class="btn btn-outline-primary btnWrite">
						<input type="button" value="새로고침" class="btn btn-outline-primary btnRefresh" >	
					</div>
				
				</form>
		
				<div id="footer">
					<p>
					<c:if test="${dataCount!=0}">
					     ${pageIndexList }
					</c:if>
					<c:if test="${dataCount==0}">
					     등록된 페이지가 없습니다.
					</c:if>
					</p>
				</div><!-- #footer -->
				
			</div><!-- end .main -->
	
  		</div><!-- end .main-content -->
		<jsp:include page="footer.jsp" flush="false"/>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
</body>
</html>