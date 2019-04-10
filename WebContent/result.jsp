<%@page import="java.lang.reflect.Array"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.ArrayList"%>

<%!
	boolean isOdd = false; // 글자수가 홀수인지 짝수인지 판별
	char[][] board = new char[5][5];
	String isZ="";
	String isSpace="";

	public void boardSet(String keyTxt) { // 암호판 만들기
		String key = keyTxt.replace(" ", "");
		key = key.replace("z", "q");
		key += "abcdefghijklmnopqrstuvwxyz";
		char[] resultArr = new char[25];
		int index = 0;
		boolean chk = true;
		

		for (int i = 0; i < key.length(); i++) {
			chk = true;
			for (int j = 0; j < index; j++) {
				if (key.charAt(i) == resultArr[j]) {
					chk = false;
				} else if (key.charAt(i) == 'z') {
					chk = false;
				}
			}
			if (chk) {
				resultArr[index] = key.charAt(i);
				index++;
			}

		}
		index = 0;

		for (int i = 0; i < board.length; i++) {
			for (int j = 0; j < board[i].length; j++) {
				board[i][j] = resultArr[index++];
			}
		}
	}

	public ArrayList<String> PreEnc(String plain) {
		ArrayList<String> list = new ArrayList(); // 암호화 하기 전 문장으로 고친 문장 저장
		String result = "", targetTxt;
		String plainTxt = plain.replace(" ", "");

		for (int i = 0; i < plainTxt.length(); i += 2) {
			targetTxt = "";

			try {
				if (plainTxt.charAt(i) == plainTxt.charAt(i + 1)) {
					targetTxt += Character.toString(plainTxt.charAt(i)) + "x";
					i--;
				} else
					targetTxt += Character.toString(plainTxt.charAt(i)) + Character.toString(plainTxt.charAt(i + 1));
			} catch (StringIndexOutOfBoundsException e) {
				targetTxt += Character.toString(plainTxt.charAt(i)) + "x";
				isOdd = true;
			}

			list.add(targetTxt);

		}

		return list;
	}

	public String encStr(ArrayList<String> plain) {//암호화
		String result = "";
		int x1 = 0, x2 = 0, y1 = 0, y2 = 0;

		for (int i = 0; i < plain.size(); i++) {
			for (int j = 0; j < board.length; j++) {
				for (int d = 0; d < board[j].length; d++) {
					if (board[j][d] == plain.get(i).charAt(0)) {
						x1 = j;
						y1 = d;
					}
					if (board[j][d] == plain.get(i).charAt(1)) {
						x2 = j;
						y2 = d;
					}
				}
			}

			if (x1 == x2) {
				result += Character.toString(board[x1][(y1 + 1) % 5]) 
						+ Character.toString(board[x2][(y2 + 1) % 5]) + " ";
			} else if (y1 == y2) {
				result += Character.toString(board[(x1 + 1) % 5][y1]) 
						+ Character.toString(board[(x2 + 1) % 5][y2]) + " ";
			} else {
				result += Character.toString(board[x2][y1]) 
						+ Character.toString(board[x1][y2]) + " ";
			}
		}

		return result;
	}

	public String decStr(String enc, String key) {
		String decResult = "";
		ArrayList<String> encStrs = new ArrayList<String>();
		int x1=0, x2=0, y1=0, y2=0;
		String result="", returnResult="";
		
		for(int i=0; i < enc.length(); i+=2){
			String a = Character.toString(enc.charAt(i)) + 
					Character.toString(enc.charAt(i+1));
			
			encStrs.add(a);
		}
		
		for(int i = 0; i < encStrs.size(); i++){
			for(int j = 0; j <board.length; j++){
				for(int h = 0; h < board[j].length; h++){
					if(board[j][h] == encStrs.get(i).charAt(0)){
						x1 = j;
						y1 = h;
					}
					if(board[j][h] == encStrs.get(i).charAt(1)){
						x2 = j;
						y2 = h;
					}
				}
			}
			if(x1==x2) {
				decResult += Character.toString(board[x1][(y1+4)%5]) 
						+ Character.toString(board[x2][(y2+4)%5]);
			}else if(y1==y2) {
				decResult += Character.toString(board[(x1+4)%5][y1])
						+ Character.toString(board[(x2+4)%5][y2]);
			}else{
				decResult += Character.toString(board[x2][y1])
						+ Character.toString(board[x1][y2]);
			}
			
		}
		
		
		for(int i = 0; i < decResult.length(); i += 2){ // 중복된 문자를 다시 돌려놓는 for문
			
				try{
					if(decResult.charAt(i+1) == 'x' 
							&& decResult.charAt(i) == decResult.charAt(i+2)){
				decResult = decResult.substring(0, i+1) 
						+ decResult.substring(i+2);
					}
				} catch (StringIndexOutOfBoundsException e) {
					break;
				}
			} //for
		
		if(isOdd) decResult = decResult.substring(0,decResult.length()-1);
		
		
		for(int i = 0; i < isZ.length(); i++){
			if(isZ.charAt(i) == 'z')
				decResult=decResult.substring(0,i) + 'z' +
						decResult.substring(i+1, decResult.length());
		}
		System.out.print(isSpace);
		
		
		return decResult;
	}%>


<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>

	table{
		text-align: center;
	}
	td{
		padding: 5px;
	}
</style>


</head>
<body>

	<center>
		<fieldset>
			<legend>암호화 진행</legend>
			<%
				request.setCharacterEncoding("UTF-8");
				String plainTxt = request.getParameter("plainTxt"); // 평문
				String keyTxt = request.getParameter("keyTxt"); // 암호키
				boardSet(keyTxt); // 암호판에 들어갈 배열
				%>
				키 : <%= keyTxt %><br>
				평문 : <%=plainTxt %><br>
				
				<%
				
			
				for(int i = 0; i < plainTxt.length(); i++){
					if (plainTxt.charAt(i) == ' ') {
						plainTxt = plainTxt.substring(0,i) +
								plainTxt.substring(i+1, plainTxt.length());
						isSpace += 10;
					} else {
						isSpace += 0;
					}
				}
				
				for(int i = 0; i < plainTxt.length(); i++){
					if (plainTxt.charAt(i) == 'z') {
						plainTxt = plainTxt.substring(0,i) + 'q' + 
								plainTxt.substring(i+1, plainTxt.length());
						isZ += 'z';
					} else {
						isZ += "0";
					}
				}
				
				ArrayList<String> preEnc = PreEnc(plainTxt);
				String encryptionTxt = encStr(preEnc);
				String decTxt = decStr(encryptionTxt.replace(" ", ""), keyTxt); //복호화된 문장
				
				for(int i = 0; i < isSpace.length(); i++){
					if(isSpace.charAt(i) == '1')
						decTxt=decTxt.substring(0,i) + ' ' +
								decTxt.substring(i, decTxt.length());
				}

			%>
			<br>
			<br> 암호판(z는 q로 표시)<br>
			
			<table border="1">
			<%
				for (int i = 0; i < board.length; i++) {
			%>
				<tr>
					<%
						for(int j = 0; j < board[i].length; j++){ 
							if(!(board[i][j] == 'q')){
						%>
							<td><%=board[i][j]%></td>
					<%		}else{%>
							<td><%=board[i][j]%>/z</td>
					<% }}%>
				</tr>
			<%
				}
			%>
			</table>
			<%for (int i = 0; i< preEnc.size(); i++){ %>
				<%= preEnc.get(i) %>
			<% }%>
			
			<br> 암호화된 문장 :
			<%=encryptionTxt%>
			<br> 복호화된 문장 :
			<%=decTxt%>
			
		</fieldset>
	</center>


</body>
</html>

