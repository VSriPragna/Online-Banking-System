<%@ page import = "java.io.*,java.lang.*,java.sql.*,java.util.*" %>
<%@ page import = "java.servlet.*,java.servlet.http.*,java.text.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    
<%
    try{
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","pragna","1234");

        // get name and balance from cookies

        Cookie cookies[] = request.getCookies();
        String name = "";
        for(int i=0;i<cookies.length;i++){
            if(cookies[i].getName().compareTo("name")==0){
                name = cookies[i].getValue();
            }
        }
		  
        PreparedStatement ps = con.prepareStatement("select * from users where username = ? ");
        ps.setString(1,name);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
           name=name;
        }else{
        out.print("<h3>You are not able to delete your account!!!</h3>");
        }
        if(name.length()==0){
            out.println("<h3>Please Login</h3>");
            return;
        }

      
       
        String e = request.getParameter("email");
		 
		
        
        
        
        PreparedStatement pst=con.prepareStatement("insert into deletion values(?,?)");
          pst.setString(1,name);
          pst.setString(2,e);
          
         
          pst.executeUpdate();
         
        
        
        con.close();
        out.print("<h3>Your request has been send!!</h3>");
    }
    catch(Exception e){
        out.print(e);
    }
%>

</body>
</html>