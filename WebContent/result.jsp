
<%
	request.setCharacterEncoding("UTF-8");
	String plainTxt = request.getParameter("plainTxt");
	String keyTxt = request.getParameter("keyTxt");
	


%>


<%!
	public String ovlapTxt(String str){
		String resultTxt="";
		str.replace(" ", "");
		char[] result = str.toCharArray();
		
		for(int i = 0; i < result.length; i++){
			
		}
		return resultTxt;
	}


%>