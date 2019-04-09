<%!

public char[] boardSet(String keyTxt) { // 암호판 만들기
		String key = keyTxt.replace(" ", "");
		key += "abcdefghijklmnopqrstuvwxyz";
		char[] resultArr = new char[25];
		int index=0;
		boolean chk = true;
		
		for(int i = 0; i < key.length(); i++){
			chk=true;
			for(int j = 0; j < index; j++){
				if(key.charAt(i) == resultArr[j]){
					chk=false;
				}else if(key.charAt(i) == 'q'){
					chk = false;
				}
			}
			if(chk){
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
		<%=boardKey[i] %>
	<% 	if((i + 1)%5 == 0){ %>
			<br>
	<%	}
	 }%>

</body>
</html>

