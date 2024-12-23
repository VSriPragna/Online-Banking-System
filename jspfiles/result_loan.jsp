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
 <h3 align="center">STATUS OF LOAN</h3>
   
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
			String balance = "";
			String p="";
			String  n="";
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
        
             ps = con.prepareStatement("select * from loan");
           
            ResultSet rs = ps.executeQuery();
			
            while(rs.next()){
				
			    p=rs.getString(3);
				n=rs.getString(1);
				
                
            }
		
			
			
			 Statement st=con.createStatement();
	     ResultSet rs1=st.executeQuery("select * from results");
		 String s="";
		 String r="";
		 
		 while(rs1.next())
		 {
             s=rs1.getString(2);
		     r=rs1.getString(1);
		 }
		 out.print(n);
		 out.print(name);
	if(r.equals(n))
      {
		if(r.equals(name))
		{
			
		 	
			  if(s.equals("Approve"))
			   {
				out.print("<h3>The Admin  approve your loan request</h3>");
				out.print("<h4>The loan amount is added to your account<h4>");
				String amount="";
				if(p.equals("Home Loan"))
				{
					amount="30000";
				}
				else if(p.equals("Bussiness Loan"))
				{
					amount="50000";
				}
				else if(p.equals("Shop Loan"))
				{
					amount="20000";
				}
				else {
					amount="40000";
				}
				 st = con.createStatement();
            String total = Integer.toString(Integer.parseInt(balance) + Integer.parseInt(amount));
            st.executeUpdate("update users set balance = '"+total+"' where users.username='"+name+"'");
			 ps = con.prepareStatement("delete from loan where username=? ");
			 ps.setString(1,n);
			 ResultSet rs3=ps.executeQuery();
			   }
			 else 
			{
				out.print("<h3>The Admin reject your loan request ");
				out.print("because your not eligible for loan...</h3>");
			}
			}
			else {
				out.print("<h3>You doesn't send any loan request to the admin..</h3>");
			}
			}
			else{
				out.print("<h3>The request is in process</h3>");
			}
			

      ps = con.prepareStatement("delete from loan where username=?");
			 ps.setString(1,name);
			 ResultSet rs3=ps.executeQuery();
			
			
			 
		 
			
    %> 
           

</body>
</html>