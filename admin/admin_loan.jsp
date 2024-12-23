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
 <h3 align="center">ALL LOAN REQUESTED USERS</h3>
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
		if(name.length()==0 ||  pasword.length()==0){
            out.println("<h3>Please Login</h3>");
            return;
        }
		if(na.equals("admin") && p.equals("admin")){

      
       
           
           
        PreparedStatement      ps = con.prepareStatement("select * from loan");
           
            ResultSet rs = ps.executeQuery();
            if(rs.next()==false){
                out.print("No one requested");
                con.close();
                return;
            }
			else
			{
			
    %> 
            <tr>
                <td><b>Username</b></td>
                <td><b>Email</b></td>
                
				<td><b>loanType</b></td>
                
				
            </tr> 
    <%
           
    %> 
                <tr>
                    <td><%= rs.getString(1)%></td>
                    <td><%= rs.getString(2)%></td>
                    <td><%= rs.getString(3)%></td>
					
					
                </tr> 
    <%
			
           
			
			}
		}
		else{
			out.print("<h3>Unable to fetch the inforamtion!Invalid Password or Username</h3>");
		}
		 con.close();
			
			
    %>
    </table>

    <h3 align="center">FILL THE FORM</h3>
    <form action="process_loan.jsp" method="post" align="center">
Username: <input type="text" name="uname" id="uname" required><br><br>
Password: <input type="password" name="pword" id="pword" required><br>
Approve/Reject:	<input style="margin: 10px;" type="text" name="status">
	
	
	<input style="margin: 10px;" type="submit" value="submit" >
	
	
	 </form>
	

	

</body>
</html>