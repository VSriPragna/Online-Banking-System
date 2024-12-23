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
 
    <%
	String name="";
          try{ 
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","pragna","1234");

	        Cookie cookies[] = request.getCookies();
        String n= "";
        for(int i=0;i<cookies.length;i++){
            if(cookies[i].getName().compareTo("name")==0){
                n = cookies[i].getValue();
            }
        }
		String pasword="admin";
		  String na="";
		   String p="";
         Statement st=con.createStatement();
	 ResultSet rs1=st.executeQuery("select * from login");

          while(rs1.next()){
			na = rs1.getString(1);
            p = rs1.getString(2);
			
        }
		out.print(na);
		out.print(p);
		if(n.length()==0 ||  pasword.length()==0){
            out.println("<h3>Please Login</h3>");
            return;
        }
		if(na.equals("admin") && p.equals("admin")){
        
        
        int c=0;

        PreparedStatement    ps = con.prepareStatement("select * from deletion");
			 ResultSet rs=ps.executeQuery();
			 
			 while(rs.next())
			 {
			     name=rs.getString(1);
				 c=c+1;
				 
			 
			 
			
			
			  ps = con.prepareStatement("delete from users where username=?");
			 ps.setString(1,name);
			 ResultSet rs3=ps.executeQuery();
			  ps = con.prepareStatement("delete from transactions where sender=? ");
			  ps.setString(1,name);
			 ResultSet rs4=ps.executeQuery();
			 %>
			 
			<h1>"user account deleted sucessfully"</h1>
			 
		<%	 
             ps = con.prepareStatement("delete from deletion where username=? ");
			 ps.setString(1,name);
			 ResultSet rs5=ps.executeQuery();
			
			  
		 
		  }
		  if(c==0)
			 {
				 %>
				 <h1>"No one register.."</h1>
				 <%
			 }
			 
		  }
		    
		  
		  else
		  {
			  out.print("<h3>Unable to fetch the inforamtion!Invalid Password or Username</h3>");
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