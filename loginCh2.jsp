<%@ page language="java" import="java.util.*,java.sql.*,java.net.*" pageEncoding="utf-8"%>  
<%@ page import="website.*,java.util.Date,java.util.Calendar,java.text.SimpleDateFormat"%>
<%  
String path = request.getContextPath();  
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
%>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">  
<html>  
  <head>  
    <base href="<%=basePath%>">  
      
    <title>My JSP 'Feilong_loginCh.jsp' starting page</title>  
     <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
  <link href="css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/><title>Insert title here</title>
 
    
      
    <meta http-equiv="pragma" content="no-cache">  
    <meta http-equiv="cache-control" content="no-cache">  
    <meta http-equiv="expires" content="0">      
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">  
    <meta http-equiv="description" content="This is my page">  

  
  </head>  
  <body>  
    <%      
    try{
            String email = request.getParameter("email");    
            String pwd = request.getParameter("pwd");  
            String key2 = request.getParameter("key4");
            Public w = new Public();
            Date now = new Date(); 
            SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");//可以方便地修改日期格式 
            String date = dateFormat.format( now ); 
            String key1 = Md5Utils.MD5Encode(date, "utf-8", false);
            String y = "" + (char)Integer.parseInt(key2);
            String key3 = Md5Utils.MD5Encode(y, "utf-8", false);
            
            email = w.strDec(email, key1, key2, key3);
            pwd = w.strDec(pwd, key2, key1, key3);
  
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); 
            String connectionString =  
            "jdbc:sqlserver://test50.database.windows.net:1433;database=test;user=huangsk100@test50;password=*PASSWORD*;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;";  
            Connection conn = DriverManager.getConnection(connectionString); 
            PreparedStatement pStmt1 = conn.prepareStatement("select * from dbo.login1 where Date1 = '" + email + "'");  
            ResultSet rs1 = pStmt1.executeQuery();
            if(rs1.next()){
            PreparedStatement pStmt = conn.prepareStatement("select * from dbo.login1 where Date1 = '" + email + "' and Password = '" + pwd + "'");  
            
            ResultSet rs = pStmt.executeQuery();
            
                if(rs.next()){
                	String user = rs1.getNString("Name");
                	String code2 = "";
                	code2 = user + ";" + En_De.Encrypt(user, user) + ";";
                	code2 = Publicforlink.EncodePasswd(code2);
                     	%>
                     	<jsp:forward page="success.jsp">
                 	<jsp:param name="code" value="<%=code2 %>"/> 
                 	</jsp:forward>
                 	<% 
                }else{
                    response.sendRedirect("login2.jsp?errNo");
                }  
     rs.close();  
     pStmt.close();
 }else response.sendRedirect("register.jsp?username2");
 rs1.close();
 pStmt1.close();
 conn.close(); 
    }catch(Exception e){  
        e.printStackTrace();  
    	%>

    	<br></br>
    	<br></br>
    	<br></br>
    	<div class="row">
               <div class="col s1 m2 l4 left">
          <p>&nbsp;&nbsp;&nbsp;</p>
          </div>
            <div class="col s10 m8 l4">
              <div class="card white z-depth-3">
                <div class="card-content black-text">
                  <span class="card-title">Sorry!</span>
                  <p>You visit this page in error.</p>
                  <p>We will bring you to home page in <span id="mes">5</span> seconds.</p> 
                  <a href="index.jsp">Click here</a><a class="black-text"> to go to home page immediately.</a><br>
                  <a class="black-text">if you find this page shows many times, please contact us.</a>
              </div>


          
          <script language="javascript" type="text/javascript"> 
    var i = 5; 
    var intervalid; 
    intervalid = setInterval("fun()", 1000); 
    function fun() { 
    if (i == 0) { 
    window.location.href = "index.jsp"; 
    clearInterval(intervalid); 
    } 
    document.getElementById("mes").innerHTML = i; 
    i--; 
    } 
    </script> 
        


            </div>
                </div>
                </div>
                <br></br>
                <br></br>
                <br></br>
    	
    	<%
    	} 
                 
                
                
                %> 
                
                
                 
     <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.js"></script>
      <script src="js/init.js"></script>
    <div id="fb-root"></div>
    <script>(function(d, s, id) {
      var js, fjs = d.getElementsByTagName(s)[0];
      if (d.getElementById(id)) return;
      js = d.createElement(s); js.id = id;
      js.src = 'https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.11';
      fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));</script>
        </body>
    </html>  