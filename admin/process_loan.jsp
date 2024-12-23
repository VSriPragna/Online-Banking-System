<%@ page import = "java.lang.*,java.util.*,java.sql.*,java.io.*" %>
<%@ page import = "java.servlet.http.*,java.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Details</title>
<style>
th, td {
  border-style: dotted;
}
</style>
<body 
 <h3 align="center">INFORMATION</h3>
   
    <%
          try{
			  
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","pragna","1234");
             String s=request.getParameter("status");
			  String name=request.getParameter("uname");
			  
            PreparedStatement pst=con.prepareStatement("insert into results values(?,?)");

pst.setString(1,name);
pst.setString(2,s);


if(pst!=null)
{
  out.println("<h3>Responded for the request!!!<h3>");
}
con.close();
     }
catch(Exception e)
{
  out.println(e);
}
 
 

			
           
     
			
			
			
    %> 
           

</body>
</html>