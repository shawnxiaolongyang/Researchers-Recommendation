<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'MyJsp.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
  
  <% String paras = request.getParameter("q");
   if (paras!= null){
   String url = "http://localhost:5000/BasicInfo?node=Paper&title="+paras;
   URLConnection connection = new URL(url).openConnection();
   InputStream Response = connection.getInputStream(); 
   BufferedReader reader = new BufferedReader(new InputStreamReader(Response));
	StringBuilder result = new StringBuilder();
	String line;
	while((line = reader.readLine()) != null) {
    	result.append(line);
	}
	out.println(result.toString());
   
   }
   
%>

  <div>
 <table cellpadding="0" cellspacing="0" border="1" width="100%">
 <%
   int rows = ;  // 多少行
   int cols = 3;  // 多少列
   for(int i = 0; i < rows; i++ ){
 %>
  <tr align="center" height="30">
 <%
    for(int j = 0; j < cols; j++ ){
 %>
   <td>[<%=i+1 %>] | [<%=j+1 %>]</td>
 <%
    }
   }
 %> 
 </table>
 </div>
  <div>
 <table cellpadding="0" cellspacing="0" border="1" width="100%">
 <%
   String[][] array = (String[][])session.getAttribute("array");
   int rows = array.length;  // 多少行
   int cols = 2;  // 多少列
   for(int i = 0; i < rows; i++ ){
 %>
  <tr align="center" height="30">
 <%
    for(int j = 0; j < cols; j++ ){
 %>
   <td>[<%=array[i][j] %>]</td>
 <%
    }
   }
 %> 
 </table>
 </div>
 
 
 
 
 
 
 
 <% String paras;
	if (request.getParameter("paper")!= null){
    paras = request.getParameter("paper");
   }
	else{
    paras = request.getParameter("q");
   }
   
   if (paras!= null){
   String url = "http://localhost:5000/pprRecommend/PtoP?title="+paras;
   URLConnection connection = new URL(url).openConnection();
   InputStream Response = connection.getInputStream(); 
   BufferedReader reader = new BufferedReader(new InputStreamReader(Response));
	StringBuilder result = new StringBuilder();
	String line;
	while((line = reader.readLine()) != null) {
    	result.append(line);
	}
	String all = result.toString().replaceAll("\"","");
	all = all.replaceAll("\\\\","");
	all = all.replaceAll("\\[","");
	all = all.replaceAll("\\]","");
	all = all.replaceAll("\\,{","");
	all = all.replaceAll("\\{","");
	String[] allrow = all.split("}");
	int len = allrow.length;
	String array[][] = new String[len][2];  
	int count = 0;
	for (String row : allrow) {
		String[] allcell = row.split(",");
		array[count][0] = allcell[0].split(":")[1];
		array[count][1] = allcell[1].split(":")[1];		
		count += 1;
	}
	
	out.print(array[0][0]);
	out.print(array[0][1]);
	
	session.setAttribute("rawarray",paras);
	
    
  
   
%>
<div class="tk-Content container">


        <div class="tk-Resources row" role="list">
            <div class="col-xs-12">
                  <h2 class="tk-Heading tk-Heading--2 tk-Resources-heading">What you search</h2>
                        <div class="tk-Resource js-resource-card" data-resource-type="h" role="listitem" title="<%=array[0][1]%>" >
	                        <a  class="tk-Resource-labels">       
	         				<span class="tk-Resource-title"><%= array[0][1]%></span>                             
	        				</a>
					        <div class="tk-Resource-likes js-card-status" role="button">
					            
					             <form name="form2" action="basicpaper.jsp" method="POST">
						         <input type="text" name="paper" value=<%out.println(session.getAttribute("rawarray")); %> hidden="hidden">
						         <button type="submit" style="background-color: transparent; width: 6rem; height: 6rem; padding: 0; border: none;"></button>
						         </form>
					            
					        </div>
    					</div>
            </div>
        </div>
        
        <div class="tk-Resources row" role="list">
            <div class="col-xs-12">
                <h2 class="tk-Heading tk-Heading--2 tk-Resources-heading">recommend you</h2>
  <%
   
   int rows = array.length;  
   
   for(int i = 1; i < 3; i++ ){
   %>            
    <div class="tk-Resource js-resource-card" data-resource-type="g" title="<%=array[i][1] %>">
            <a class="tk-Resource-labels">
            <span class="tk-Resource-title"><%=array[i][1] %></span>
            
        </a>
        <div class="tk-Resource-likes js-card-status" role="button">
            <i class="fa fa-heart"></i>
            <span class="js-card-likes-counter"><%=array[i][0] %></span>
        </div>
    </div>
    <%
    if(i>1000){break;}
   }
   }
   %> 
</div>
</div>
</div>
 
    
<% session.removeAttribute("array"); %>








String[] allrow = all.split("{");
	int len = allrow.length;
	String array[][] = new String[len][2];  
	int count = 0;
	for (String row : allrow) {
	if(count!=0){
		String[] allcell = row.split(",");
		array[count-1][0] = allcell[0].split(":")[1];
		array[count-1][1] = allcell[2].split(":")[1];	}	
		count += 1;
	}
	
	out.print(array[0][0]);
	out.print(array[0][1]);
	
	session.setAttribute("rawarray",paras);
	
    
  
   
%>
<div class="tk-Content container">


        <div class="tk-Resources row" role="list">
            <div class="col-xs-12">
                  <h2 class="tk-Heading tk-Heading--2 tk-Resources-heading">What you search</h2>
                        <div class="tk-Resource js-resource-card" data-resource-type="h" role="listitem" title="<%=array[0][1]%>" >
	                        <a  class="tk-Resource-labels">       
	         				<span class="tk-Resource-title"><%= array[0][1]%></span>                             
	        				</a>
					        <div class="tk-Resource-likes js-card-status" role="button">
					            
					             <form name="form2" action="basicpaper.jsp" method="POST">
						         <input type="text" name="paper" value=<%out.println(session.getAttribute("rawarray")); %> hidden="hidden">
						         <button type="submit" style="background-color: transparent; width: 6rem; height: 6rem; padding: 0; border: none;"></button>
						         </form>
					            
					        </div>
    					</div>
            </div>
        </div>
        
        <div class="tk-Resources row" role="list">
            <div class="col-xs-12">
                <h2 class="tk-Heading tk-Heading--2 tk-Resources-heading">recommend you</h2>
  <%
   
   int rows = array.length;  
   
   for(int i = 1; i < 3; i++ ){
   %>            
    <div class="tk-Resource js-resource-card" data-resource-type="g" title="<%=array[i][1] %>">
            <a class="tk-Resource-labels">
            <span class="tk-Resource-title"><%=array[i][1] %></span>
            
        </a>
        <div class="tk-Resource-likes js-card-status" role="button">
            <i class="fa fa-heart"></i>
            <span class="js-card-likes-counter"><%=array[i][0] %></span>
        </div>
    </div>
    <%
    if(i>1000){break;}
   }
   }
   %> 
</div>
</div>
</div>
 
    
<% session.removeAttribute("array"); %>

  </body>
</html>
