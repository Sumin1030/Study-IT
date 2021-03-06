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
<title>종료된 스터디</title>
<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="<%=cp %>/css/bootstrap.css">
	<link rel="stylesheet" href="<%=cp %>/css/style.css">
	<script src="http://code.jquery.com/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="https://kit.fontawesome.com/5cdf4f755d.js"></script>
<style type="text/css">
a {color:#000000;
text-decoration: none;}
</style>
<script type="text/javascript">

$(function()
{
	// 스터디원평가 버튼 클릭 시 액션 처리 
	$("#assessBtn").click(function()
	{
		$(location).attr("href", "assessform.action?studycode="+$('#studycode').val() + "&parti_code=" + $('#particode').val());	
	
	});
	
	// 스터디 후기 버튼 클릭 시 액션 처리 
	$("#reviewBtn").click(function()
	{
		$(location).attr("href", "review_insert_form.action?studycode="+$('#studycode').val()+"&parti_code="+$("#particode").val());	
	
	});
	
	$(".studyCnt").click(function(){
		ajaxRequest($(this).val());
	});
	
	
});

function ajaxRequest(id)
{   
	$.get("ajax.action", {id : id}, function(data)
	{
		alert('누적 스터디 수: ' + data +"개");	
    });
}

</script>	
</head>
<body>
<div class="wrapper">
 <jsp:include page="header.jsp" flush="false"/>
 <div class="main-content">
   <div class="title">
        <h3 class="titleTxt p-3 text-center">종료된 스터디</h3>
      </div>
      <div class="container"><br><br><br>
      <div class="row align-content-center">
          <div class="col-12">
          	<table class="table">
          	<c:forEach var="end" items="${endlist }">
              <tr>
                <td class="fw-bold fs-5 bd">스터디명</td>
                <!-- <td class="bd cen">자바스크립트 스터디</td> -->
                <td class="bd cen">${end.study_name }</td>
                <td class="fw-bold fs-5 bd">스터디 리더</td>
                <td class="cen">${end.leader }</td>
                <!-- <td class="cen">hsm11</td> -->
              </tr>
              <tr>
                <td class="fw-bold fs-5 bd">기간</td>
                <td class="bd cen">${end.period }</td>
                <!-- <td class="bd cen">2020/12/21 ~ 2021/01/25</td> -->
                <td class="fw-bold fs-5 bd">장소</td>
                <td class="cen">${end.loc }</td>
                <!-- <td class="cen">서울특별시 홍대</td> -->
              </tr>
              <tr>
                <td class="fw-bold fs-5 bd">요일</td>
                <td class="bd cen">${weekday }</td>
                <!-- <td class="bd cen">토요일, 일요일</td> -->
                <th class="bd fs-5">시간</th>
                <td class="cen">${end.start_time } ~ ${end.end_time }</td>
               <!--  <td class="cen">13:00 ~ 15:00</td> -->
              </tr>
              <tr>
               <td class="fw-bold bd fs-5">진행률</td>
               <td colspan="3"><div class="progress mt-2" style="width: 80%; margin: 0 auto;">
                <div class="progress-bar" role="progressbar" style="width: 100%;" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">100%</div>
              </div></td>
              </tr>
              </c:forEach>
          </table>   
          </div>
           <div class="col-lg-12 col-md-12 col-sm-12 mt-3 mb-5" style="margin: 0 auto;">
               <div class="col-7 mt-3" style="margin: 0 auto;">
               <c:forEach var="end" items="${endlist }">
              <button type="button" class="btn btn-outline-primary mb-2" 
              onclick="location.href='attendanceec.action?attCheck=1&particode=${end.parti_code}'">출석부</button></c:forEach>
              <!-- Button trigger modal -->
              <button type="button" class="btn btn-outline-primary mb-2" data-bs-toggle="modal" data-bs-target="#memberList">
                스터디원 목록
              </button>
              <!-- Modal -->
              <div class="modal fade" id="memberList" tabindex="-1" aria-labelledby="memberListLabel" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title fw-bold" id="memberListTitle">스터디원 목록</h5>
                    </div>
                    <div class="modal-body">
                      <table class="table">
                        <thead>
                          <tr>
                            <th scope="col">번호</th>
                            <th scope="col">아이디</th>
                            <th scope="col">평균 출석률</th>
                          </tr>
                        </thead>
                        <tbody>
                          <c:forEach var="mem" items="${member }">
                          <tr>
                            <th scope="row">${mem.rnum }</th>
                             <td><button type="button" class="btn btn-outline-primary studyCnt"  value="${mem.id }">${mem.id }</button></td>
                            <td>100%</td>
                          </tr>
                          </c:forEach>
                        </tbody>
                      </table>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    </div>
                  </div>
                </div>
              </div>
              
              <!-- Button trigger modal --> 
              <button type="button" class="btn btn-outline-primary mb-2" data-bs-toggle="modal" data-bs-target="#myScore">
                상호 평가 결과
              </button>
              <!-- Modal -->
              <div class="modal fade" id="myScore" tabindex="-1" aria-labelledby="exampleModalLabel2" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title fw-bold" id="myScoreLabel">상호평가 결과</h5>
                    </div>
                    <div class="modal-body fw-bold">
                      <span>회원님이 받은 등급은 : </span><span>${grade} 입니다.</span><br>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    </div>
                  </div>
                </div>
              </div>
              <input type="hidden" id="studycode" value=${param.studycode }>
              <input type="hidden" id="particode" value=${parti_code }>
              <button type="button" id="reviewBtn"
               value="${reviewCheck }" ${reviewCheck==0 ? "class=\"btn btn-outline-primary mb-2 \"" : "class=\"btn btn-outline-secondary btn-md mb-2 disabled\"" }
							${reviewCheck==0 ? "" : "disabled" }>스터디 후기</button>
              <button type="button" id="assessBtn" class="btn btn-outline-primary mb-2">스터디원 평가</button>
              
              <!-- Button trigger modal -->
				<button type="button" value="${saCheck }" ${saCheck==0 ? "class=\"btn btn-outline-primary mb-2 \"" : "class=\"btn btn-outline-secondary btn-md mb-2 disabled\"" }
							${saCheck==0 ? "" : "disabled" } 
				 data-bs-toggle="modal" data-bs-target="#exampleModal">
				  스터디 평가
				</button>
				
				<!-- Modal -->
				<form action="studyassess.action?" method="get">
				<input type="hidden"  name="parti_code" value="${parti_code }"/>
				<input type="hidden"  name="studycode" value="${param.studycode }"/>
				<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="exampleModalLabel">스터디 평가</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        <label>
	                      <input type="radio" name="score" value="1" checked>
	                       <span>1</span>
                         </label>
                         <label>
	                      <input type="radio" name="score" value="1.5" checked>
	                       <span>1.5</span>
                         </label>
                         <label>
	                      <input type="radio" name="score" value="2" checked>
	                       <span>2</span>
                         </label>
                         <label>
	                      <input type="radio" name="score" value="2.5" checked>
	                       <span>2.5</span>
                         </label>
                         <label>
	                      <input type="radio" name="score" value="3" checked>
	                       <span>3</span>
                         </label>
                         <label>
	                      <input type="radio" name="score" value="3.5" checked>
	                       <span>3.5</span>
                         </label>
                         <label>
	                      <input type="radio" name="score" value="4" checked>
	                       <span>4</span>
                         </label>
                         <label>
	                      <input type="radio" name="score" value="4.5" checked>
	                       <span>4.5</span>
                         </label>
                         <label>
	                      <input type="radio" name="score" value="5" checked>
	                       <span>5</span>
                         </label>
				       </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				        <button type="submit" class="btn btn-primary">제출</button>
				      </div>
				    </div>
				  </div>
				</div>
              </form>
              
          </div>
          </div>  
        <div>
          <br><br><br>
          <span class="fs-4 fw-bold">컨텐츠</span>
          <div class="list-group list-group-flush mt-3">
          <div class="stdcon">
          <table class="table mb-5">
			  <thead>
			    <tr>
			      <th scope="col" class="bg-light" style="width:10%">번호</th>
			      <th scope="col" class="text-center bg-light" style="width:50%">제목</th>
			      <th scope="col" class="bg-light" style="width:10%">작성자</th>
			      <th scope="col" class="bg-light" style="width:20%">작성일</th>
			      <th scope="col" class="bg-light" style="width:10%">조회수</th>
			    </tr>
			  </thead>
			  <tbody>
			    <c:forEach var="con" items="${endcontents }">
			    <tr>
			      <th scope="row">${con.rnum }</th>
			      <td class="text-center"><a href="contentsdetail.action?studycode=${con.study_code }&contentcode=${con.content_code }">${con.title }</a></td>
			      <td>${con.id }</td>
			      <td>${con.write_date }</td>
			      <td>${con.hitcount }</td>
			    </tr>
			    </c:forEach>
			  </tbody>
			</table> 
			</div> 
			<br>
			<div class="page">
			${pageIndexList }
			</div>
			<!-- 
			<nav aria-label="Page navigation example" style="margin:0 auto;">
			  <ul class="pagination">
			    <li class="page-item"><a class="page-link" href="#">이전글</a></li>
			    <li class="page-item"><a class="page-link" href="#">1</a></li>
			    <li class="page-item"><a class="page-link" href="#">2</a></li>
			    <li class="page-item"><a class="page-link" href="#">3</a></li>
			    <li class="page-item"><a class="page-link" href="#">다음글</a></li>
			  </ul>
			</nav>
			-->
          </div>
            <br><br><br><br>
          </div>
          </div>
      </div>
    </div><!--main-content end-->
	     
 <jsp:include page="footer.jsp" flush="false"/>
 </div>
</body>
</html>