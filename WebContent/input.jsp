<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<style type="text/css">
	
		tr{
			text-align: center;
		}
	</style>


</head>
<body>


	<center>

		<form action="result.jsp" method="post" name="frm">
			<fieldset>
				<legend>
					<h3>
						다중 문자 치환 알고리즘을 이용한<br>문자 암호화
					</h3>
				</legend>
				<table>
					<tr>
						<td>평문 :</td>
						<td><input type="text" name="plainTxt" size="25"></td>
					</tr>
					<tr>
						<td>가상의 키 :</td>
						<td><input type="text" name="keyTxt" size="25"></td>
					</tr>
					<tr colspan="2">
						<td>	
							<input type="submit" value="암호화하기" name="submit" >
						</td>
					</tr>
				</table>
			</fieldset>
	</center>

	</form>

</body>
</html>