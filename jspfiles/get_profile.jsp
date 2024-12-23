<%@ page import = "java.lang.*,java.util.*,java.sql.*,java.io.*" %>
<%@ page import = "java.servlet.http.*,java.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Balance</title>
</head>
<style>
th, td {
  border-style: dotted;
}
</style>
<body>
    <h3 align="center">YOUR PROFILE</h3>
    <table align="center" width="100%">
    <%
            String name = "";

            Cookie cookies[] = request.getCookies();
            for(int i=0;i<cookies.length;i++){
                if(cookies[i].getName().compareTo("name")==0){
                    name = cookies[i].getValue();
                    break;
                }
            }
            

            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","pragna","1234");
			String balance = "";
		
        PreparedStatement ps = con.prepareStatement("select * from users where username = ? ");
        ps.setString(1,name);
        ResultSet rs2 = ps.executeQuery();
        if(rs2.next()){
            balance = rs2.getString(4);
        }
		if(name.length()==0 || balance.length()==0){
            out.println("<h3>Please Login</h3>");
            return;
        }
              String n="";
             ps = con.prepareStatement("select * from personaldetails where username=?");
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
			
            if(rs.next())
			{
				n=rs.getString(1);
			}else{
				
                out.print("Please Update Your profile!!!");
                con.close();
                return;
            }
    %> 
	<center><img src="profile.jpg"></center>
            <tr>
                <td><b>Username</b></td>
                <td><b>Email</b></td>
                
				<td><b>Contact no</b></td>
                <td><b>Date of Birth</b></td>
				<td><b>State</b></td>
				<td><b>PinCode</b></td>
				<td><b>Address</b></td>
            </tr> 
    <%
	      
         
				
				
    %>          
                <tr>
                    <td><%= rs.getString(1)%></td>
                    <td><%= rs.getString(2)%></td>
                    <td><%= rs.getString(3)%></td>
					<td><%= rs.getString(4)%></td>
					<td><%= rs.getString(5)%></td>
                    <td><%= rs.getString(6)%></td>
					<td><%= rs.getString(7)%></td>
                </tr> 
				
    <%
	
				
				
           
            con.close();

    %>
    </table>
</body>
</html>