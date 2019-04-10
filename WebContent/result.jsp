<%@page import="java.util.ArrayList"%>
<%!boolean isOdd = false; // 글자수가 홀수인지 짝수인지 판별
	char[][] board = new char[5][5];
	String isZ[];

	public char[] boardSet(String keyTxt) { // 암호판 만들기
		String key = keyTxt.replace(" ", "");
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
		index=0;
		
		for(int i = 0; i < board.length; i++){
			for(int j = 0; j < board[i].length; j++){
				board[i][j] = resultArr[index++];
			}
		}
		
		
		return resultArr;
	}

	public ArrayList<String> PreEnc(String plain) {
		ArrayList<String> list = new ArrayList(); // 암호화 하기 전 문장으로 고친 문장 저장
		String result = "", targetTxt;
		String plainTxt = plain.replace(" ", "");

		for (int i = 0; i < plainTxt.length(); i += 2) {
			targetTxt = "";
			if(plain.charAt(i) == 'z'){
				plain.replaceFirst("z", "q");
			}

			try {
				if (plainTxt.charAt(i) == plainTxt.charAt(i + 1)) {
					targetTxt += Character.toString(plainTxt.charAt(i)) + "x";
					i--;
				} else
					targetTxt += Character.toString(plainTxt.charAt(i))
							+ Character.toString(plainTxt.charAt(i+1));
			} catch (StringIndexOutOfBoundsException e) {
				targetTxt += Character.toString(plainTxt.charAt(i)) + "x";
				isOdd = true;
			}
			
			list.add(targetTxt);
			
		}
		
		return list;
	}
	
	public String encStr(ArrayList<String> plain){//암호화
		String result="";
		int x1=0, x2=0,y1=0,y2=0;
		
		
		for(int i = 0; i < plain.size(); i++){
			for(int j = 0; j < board.length; j++){
				for(int d = 0; d < board[j].length; d++){
					if(board[j][d] == plain.get(i).charAt(0)){
						x1 = j;
						y1 = d;
					}
					if(board[j][d] == plain.get(i).charAt(1)){
						x2 = j;
						y2 = d;
					}
				}
			}
			
			if(x1 == x2){
				result += Character.toString(board[x1][(y1+1)%5])
						+ Character.toString(board[x2][(y2+1)%5])+" ";
			}else if(y1 == y2){
				result += Character.toString(board[(x1+1)%5][y1])
						+ Character.toString(board[(x2+1)%5][y2])+" ";
			}
			else{
				result += Character.toString(board[x2][y1])
						+ Character.toString(board[x1][y2])+" ";
			}
		}
	
		return result;
	}
	
	public String decStr(String enc){
		String decResult="";
		
		return decResult;
	}
	
	
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		ArrayList<String> preEnc = PreEnc(plainTxt);
		String encryptionTxt = encStr(preEnc);
		String decTxt = decStr(encryptionTxt.replace(" ", ""));
		
		for(int i = 0; i < preEnc.size(); i++){
			System.out.println(preEnc.get(i));
		}
		
		for (int i = 0; i < boardKey.length; i++) {
	%>
	<%=boardKey[i]%>
	<%
		if ((i + 1) % 5 == 0) {
	%>
	<br>
	<%
		}
		}
	%>
	<br>
	암호화된 문장 : <%= encryptionTxt %>
</body>
</html>

