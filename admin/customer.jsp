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
 <h3 align="center">ALL USER DETAILS</h3>
    <table align="center" width="100%">
    <%
           
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","pragna","1234");
				        Cookie cookies[] = request.getCookies();
        String name = "";
        for(int i=0;i<cookies.length;i++){
            if(cookies[i].getName().compareTo("name")==0){
                name = cookies[i].getValue();
            }
        }
		  String  pasword = "admin";
		  int c=0;
		  String n="";
		   String p="";
         Statement st=con.createStatement();
	 ResultSet rs1=st.executeQuery("select * from login");

          while(rs1.next()){
			n = rs1.getString(1);
            p = rs1.getString(2);
			c=c+1;
        }
		out.print(n);
		out.print(p);
		if(name.length()==0 ||  pasword.length()==0){
            out.println("<h3>Please Login</h3>");
            return;
        }
		if(n.equals("admin") && p.equals("admin")){
        
        
        

      
       
          
     PreparedStatement         ps = con.prepareStatement("select * from users");
           
            ResultSet rs = ps.executeQuery();
            if(rs.next()==false){
                out.print("No one regsitered");
                con.close();
                return;
            }
    %> 
	
            <tr>
                <td><b>Username</b></td>
                <td><b>Email</b></td>
                
				<td><b>Password</b></td>
                <td><b>Balance</b></td>
				
            </tr> 
    <%
            while(rs.next()){
    %> 
                <tr>
                    <td><%= rs.getString(1)%></td>
                    <td><%= rs.getString(2)%></td>
                    <td><%= rs.getString(3)%></td>
					<td><%= "$ "+rs.getString(4)%></td>
					
                </tr> 
    <%
            }
		}
		else
		{
			out.print("<h3>Unable to fetch the inforamtion!Invalid Password or Username</h3>");
		}
            con.close();
    %>
    </table>

</body>
</html>