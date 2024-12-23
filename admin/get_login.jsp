<%@ page import = "java.lang.*,java.util.*,java.sql.*,java.io.*" %>
<%@ page import = "java.servlet.http.*,java.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
</head>
<body>
    <%
	try{
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","pragna","1234");

        String uname = request.getParameter("uname");
        String pword = request.getParameter("pword");
		String name="admin";
		String pass="admin";
        
        if(0==uname.length() || 0==pword.length()){
            out.println("All Fields are mandatory!");
            con.close();
            return;
        }
        if(uname.equals("admin") && pword.equals("admin"))
		{
			  
      Statement st=con.createStatement();
	 ResultSet rs=st.executeQuery("select * from login");

		 

        if(rs.next()){
			 
		
		
			 Cookie nameC = new Cookie("name",name);
            Cookie passC = new Cookie("pass",pass);
			
           

            response.addCookie(nameC);
            response.addCookie(passC);
			out.print("Welcome ADMIN"); 
		}
		
		
           
		}
		else{
            out.print("Invalid username and password");
        }
		
		PreparedStatement pst=con.prepareStatement("insert into login values(?,?)");
     pst.setString(1,uname);
     pst.setString(2,pword);
   
    pst.executeUpdate();


        con.close();
	}catch(Exception e){
		out.print(e);
	}
    %>
    
</body>
</html>