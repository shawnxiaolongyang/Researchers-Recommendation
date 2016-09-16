<%@ page language="java" import="java.util.*, java.net.URLConnection,java.net.URL,java.io.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <base href="<%=basePath%>">
    <title> Recommend papers by papers</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="theme-color" content="#2c3e50">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-title" content="TasteKid">
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="apple-touch-icon" sizes="57x57" href="https://www.tastekid.com/static/img/icons/apple-touch-icon-57x57.png">
    <link rel="apple-touch-icon" sizes="60x60" href="https://www.tastekid.com/static/img/icons/apple-touch-icon-60x60.png">
    <link rel="apple-touch-icon" sizes="72x72" href="https://www.tastekid.com/static/img/icons/apple-touch-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="76x76" href="https://www.tastekid.com/static/img/icons/apple-touch-icon-76x76.png">
    <link rel="apple-touch-icon" sizes="114x114" href="https://www.tastekid.com/static/img/icons/apple-touch-icon-114x114.png">
    <link rel="apple-touch-icon" sizes="120x120" href="https://www.tastekid.com/static/img/icons/apple-touch-icon-120x120.png">
    <link rel="apple-touch-icon" sizes="144x144" href="https://www.tastekid.com/static/img/icons/apple-touch-icon-144x144.png">
    <link rel="apple-touch-icon" sizes="152x152" href="https://www.tastekid.com/static/img/icons/apple-touch-icon-152x152.png">
    <link rel="apple-touch-icon" sizes="180x180" href="https://www.tastekid.com/static/img/icons/apple-touch-icon-180x180.png">
    <link rel="icon" type="image/png" href="https://www.tastekid.com/static/img/icons/favicon-32x32.png" sizes="32x32">
    <link rel="icon" type="image/png" href="https://www.tastekid.com/static/img/icons/android-chrome-192x192.png" sizes="192x192">
    <link rel="icon" type="image/png" href="https://www.tastekid.com/static/img/icons/favicon-96x96.png" sizes="96x96">
    <link rel="icon" type="image/png" href="https://www.tastekid.com/static/img/icons/favicon-16x16.png" sizes="16x16">
    <link rel="manifest" href="https://www.tastekid.com/static/img/icons/manifest.json">
    <link rel="shortcut icon" href="https://www.tastekid.com/static/img/icons/favicon.ico">
    <meta name="msapplication-TileColor" content="#00aba9">
    <meta name="msapplication-TileImage" content="https://www.tastekid.com/static/img/icons/mstile-144x144.png">
    <meta name="msapplication-config" content="https://www.tastekid.com/static/img/icons/browserconfig.xml">
    <link href="./SharkTank_files/css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="./SharkTank_files/libs.css">
    <link rel="stylesheet" type="text/css" href="./SharkTank_files/all.css">
    <meta property="og:site_name" content="TasteKid">
    <meta property="fb:admins" content="1483874706">
    <meta property="fb:app_id" content="56201581191">
    
    <meta name="description" content="If you like recommendation I recommend Canasta, Family Feud, Dungeons &amp; Dragons Online...">
    <meta property="og:title" content="recommendation | Similar games recommendations">
    <meta property="og:type" content="article">
    <meta property="og:url" content="https://www.tastekid.com/games/like/shark-tank">
    <meta property="og:image" content="https://www.tastekid.com/static/img/cover.jpg">
    <meta property="og:description" content="If you like recommendation I recommend Canasta, Family Feud, Dungeons &amp; Dragons Online...">
	
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  <body style="">
    <div class="tk-Header">
        <div class="container">
            <header class="row">
                <div class="col-xs-12">
                    
<form  action="P2P.jsp" class="tk-Header-quicksearch" method="POST">
        
        <input type="search" name="q" class="tk-Header-quicksearch-input js-q-autocomplete" placeholder="Papers " value="" autocomplete="off">
        <button type="submit" class="tk-Header-quicksearch-button"><span class="fa fa-search"></span></button>
    </form><div class="tk-Header-links">
                             <a class="tk-Header-link visible-xs-inline" data-init="toggle-quicksearch" style="display: inline;"><i class="fa fa-search"></i></a>
                    </div>
                </div>
            </header>
        </div>
    </div>
    <div class="tk-Top"><div class="tk-Top-container container">
    <div class="row">
        <div class="col-xs-12">
            <nav class="tk-Top-tabs">
                <ul class="tk-Top-tabs-list">
                    <li class="tk-Top-tabs-tab"><a href="./basicresearcher.jsp" data-init="category-tab" data-query-type="" data-track-click="" data-event-category="Buttons" data-event-action="Category tabs" data-event-label="E1">Basic Researcher Information<i class="fa fa-check pull-right"></i><i class="fa fa-chevron-down pull-right"></i></a></li>
                    <li class="tk-Top-tabs-tab"><a href="./basicpaper.jsp" data-init="category-tab" data-query-type="" data-track-click="" data-event-category="Buttons" data-event-action="Category tabs" data-event-label="E2">Basic Paper Information<i class="fa fa-check pull-right"></i><i class="fa fa-chevron-down pull-right"></i></a></li>
                    </ul>
					<ul class="tk-Top-tabs-list">
					<li class="tk-Top-tabs-tab"><a>Personal pagerank:</a></li>
					<li class="tk-Top-tabs-tab"><a href="./P2R.jsp" data-init="category-tab" data-query-type="s" data-track-click="" data-event-category="Buttons" data-event-action="Category tabs" data-event-label="Music">Paper to researcher<i class="fa fa-check pull-right"></i><i class="fa fa-chevron-down pull-right"></i></a></li>
                    <li class="tk-Top-tabs-tab"><a href="./R2R.jsp" data-init="category-tab" data-query-type="m" data-track-click="" data-event-category="Buttons" data-event-action="Category tabs" data-event-label="Movies">researcher to researcher<i class="fa fa-check pull-right"></i><i class="fa fa-chevron-down pull-right"></i></a></li>
                    <li class="tk-Top-tabs-tab"><a href="./R2P.jsp" data-init="category-tab" data-query-type="h" data-track-click="" data-event-category="Buttons" data-event-action="Category tabs" data-event-label="Shows">researcher to Paper<i class="fa fa-check pull-right"></i><i class="fa fa-chevron-down pull-right"></i></a></li>
					<li class="tk-Top-tabs-tab"><a href="./P2P.jsp" data-init="category-tab" data-query-type="b" data-track-click="" data-event-category="Buttons" data-event-action="Category tabs" data-event-label="Books">Paper to Paper<i class="fa fa-check pull-right"></i><i class="fa fa-chevron-down pull-right"></i></a></li>
					</ul>
					<ul class="tk-Top-tabs-list">
					<li class="tk-Top-tabs-tab"><a>Node2vector:</a></li>
					<li class="tk-Top-tabs-tab"><a href="./n2vp2r.jsp" data-init="category-tab" data-query-type="s1" data-track-click="" data-event-category="Buttons" data-event-action="Category tabs" data-event-label="Music">Paper to researcher<i class="fa fa-check pull-right"></i><i class="fa fa-chevron-down pull-right"></i></a></li>
                    <li class="tk-Top-tabs-tab"><a href="./n2vr2r.jsp" data-init="category-tab" data-query-type="m1" data-track-click="" data-event-category="Buttons" data-event-action="Category tabs" data-event-label="Movies">researcher to researcher<i class="fa fa-check pull-right"></i><i class="fa fa-chevron-down pull-right"></i></a></li>
                    <li class="tk-Top-tabs-tab"><a href="./n2vr2p.jsp" data-init="category-tab" data-query-type="h1" data-track-click="" data-event-category="Buttons" data-event-action="Category tabs" data-event-label="Shows">researcher to Paper<i class="fa fa-check pull-right"></i><i class="fa fa-chevron-down pull-right"></i></a></li>
					<li class="tk-Top-tabs-tab"><a href="./n2vp2p.jsp" data-init="category-tab" data-query-type="b1" data-track-click="" data-event-category="Buttons" data-event-action="Category tabs" data-event-label="Books">Paper to Paper<i class="fa fa-check pull-right"></i><i class="fa fa-chevron-down pull-right"></i></a></li>
					</ul>
            </nav>
        </div>
    </div>
</div></div>
<div> 
<%  String paras;
	if (request.getParameter("paper")!= null){
    paras = request.getParameter("paper");
   }
	else{
    paras = request.getParameter("q");
   }
   
   if (paras!= null){
   String raw = paras;
   paras = paras.replaceAll(" ","+");
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
	all = all.replaceAll("\\{","");
	
	String[] allrow = all.split("}");
	out.print(allrow[0]);
	out.print(allrow[1]);
	
	int len = allrow.length;
	String array[][] = new String[len][2];  
	int count = 0;
	for (String row : allrow) {
	if(count==0){
		String[] allcell = row.split(",");
		array[count][0] = allcell[0].split(":")[1];
		array[count][1] = allcell[2].split(":")[1];	}
	else{
		String[] allcell = row.split(",");
		array[count][0] = allcell[1].split(":")[1];
		array[count][1] = allcell[3].split(":")[1];	
	}
		count += 1;
	}
	
	out.print(array[0][0]);
	out.print(array[0][1]);
	
	session.setAttribute("rawarray", raw);
	
    
  
   
%>
<div class="tk-Content container">


        <div class="tk-Resources row" role="list">
            <div class="col-xs-12">
                  <h2 class="tk-Heading tk-Heading--2 tk-Resources-heading">What you search</h2>
                        <div class="tk-Resource js-resource-card" data-resource-type="h" role="listitem" title="<%out.println(session.getAttribute("rawarray")); %>" >
	                        <a  class="tk-Resource-labels">       
	         				<span class="tk-Resource-title"><%out.println(session.getAttribute("rawarray")); %></span>                             
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
   
   for(int i = 1; i < rows; i++ ){
   String forms = "form" + Integer.toString(i); 
   
   %>            
    <div class="tk-Resource js-resource-card" data-resource-type="g" title="<%=array[i][1] %>">
            <a class="tk-Resource-labels">
            <span class="tk-Resource-title"><%=array[i][1] %></span>
            <span class="js-card-likes-counter"><%=array[i][0] %></span>
        </a>
        <div class="tk-Resource-likes js-card-status" role="button">
            <i class="fa fa-heart"></i>
            
            <form name=<%=forms %> action="basicpaper.jsp" method="POST">
				<input type="text" name="paper" value=<%=array[i][1] %> hidden="hidden">
				<button type="submit" style="background-color: transparent; width: 6rem; height: 6rem; padding: 0; border: none;"></button>
			</form>
			
			
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
 
    

   
</div>
  </body>
</html>