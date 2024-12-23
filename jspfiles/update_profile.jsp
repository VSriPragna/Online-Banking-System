<%@ page import = "java.lang.*,java.util.*,java.sql.*,java.io.*" %>
<%@ page import = "java.servlet.http.*,java.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>update Page</title>
</head>
<body>

    <%
	try{
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","pragna","1234");
		 Cookie cookies[] = request.getCookies();
        String name = "";
        for(int i=0;i<cookies.length;i++){
            if(cookies[i].getName().compareTo("name")==0){
                name = cookies[i].getValue();
            }
		}
		  PreparedStatement pst = con.prepareStatement("select * from personaldetails where username = ? ");
		  pst.setString(1,name);
		   ResultSet rs1 = pst.executeQuery();
		   if(rs1.next())
		   {
		   }
		   

        
        String email = request.getParameter("email");
		String p = request.getParameter("phone");
		String d = request.getParameter("dob");
		String s = request.getParameter("state");
		String pincode = request.getParameter("pin");
		String address = request.getParameter("add");
		
        

        pst = con.prepareStatement("insert into personaldetails values(?,?,?,?,?,?,?)");
        pst.setString(1,name);
		 pst.setString(2,email);
		  pst.setString(3,p);
		   pst.setString(4,d);
		    pst.setString(5,s);
			 pst.setString(6,pincode);
			  pst.setString(7,address);
			 pst.executeUpdate();
			 
if(pst!=null)
{
  out.println("<h1>Your data is sccuessfully updated...</h1>");
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