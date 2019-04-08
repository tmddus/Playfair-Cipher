<%!

public char[] boardSet(String keyTxt) { // 암호판 만들기
		String key = keyTxt.replace(" ", "");
		key += "abcdefghijklmnopqrstuvwxy";
		char[] resultArr = new char[25];
		int index=0;
		boolean chk = true;
		
		for(int i = 0; i < key.length(); i++){ // key 안을 모두 도는 for
			chk=true;	// 중복값이 존재하는지 판단하는 변수
			for(int j = 0; j < index; j++) {// result 속의 값과 key의 값이 같은지 판단
				if(key.charAt(i) == resultArr[j])
					chk = false;// 같은 값이 있으면 false로 스위치
			}
			if(chk) {// chk 가 false면 같은 값이 있다는 것으로, 대입을 하지 않고 반대의 경우엔 대입
				resultArr[index] = key.charAt(i);
				index++;
			}
		}
		
		return resultArr;
}
		
	
%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<%
	request.setCharacterEncoding("UTF-8");
	String plainTxt = request.getParameter("plainTxt"); // 평문
	String keyTxt = request.getParameter("keyTxt"); // 암호키
	char[] boardKey = boardSet(keyTxt); // 암호판에 들어갈 배열
	
	for(int i = 0; i < boardKey.length; i++){ %>
		<%= boardKey[i]%>
	<% }%>

</body>
</html>

