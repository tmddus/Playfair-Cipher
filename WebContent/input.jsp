<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<form action="result" method="post">
<center>

	<h3>다중 문자 치환 알고리즘을 이용한<br>문자 암호화</h3>
	<table>
	<tr>
		<td>
			평문 : 
		</td>
		<td>
			<input type="text" name="plainTxt" size="25">
		</td>
	</tr>
	<tr>
		<td>
			가상의 키 : 
		</td>
		<td>
			 <input type="text" name="keyTxt" size="25">
		</td>
	</tr>
	<tr colspan="2">
		<td>
			<center>
			<input type="submit" value="암호화하기">
			</center>
		</td>
	</tr>
	
	
	
	</table>
</center>
	
</form>

</body>
</html>