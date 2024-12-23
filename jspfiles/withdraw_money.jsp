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
		  String balance = "";
        PreparedStatement ps = con.prepareStatement("select * from users where username = ? ");
        ps.setString(1,name);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            balance = rs.getString(4);
        }else{
        out.print("<h3>Unable to fetch Balance!</h3>");
        }
        if(name.length()==0 || balance.length()==0){
            out.println("<h3>Please Login</h3>");
            return;
        }

      
       
        String dd = request.getParameter("day");
		 
		
        
        
        //deposition amount
        String amount = String.valueOf(request.getParameter("amount"));

        PreparedStatement pst=con.prepareStatement("insert into withdraw values(?,?,?)");
          pst.setString(1,name);
         
          pst.setString(2,dd);
		  pst.setString(3,amount);
         
          pst.executeUpdate();
         
        // update users table
		Statement st = con.createStatement();
        String total = Integer.toString(Integer.parseInt(balance) - Integer.parseInt(amount));
        st.executeUpdate("update users set balance = '"+total+"' where users.username='"+name+"'");
        
        con.close();
        out.print("<h3>Money withdraw Succesful!</h3>");
    }
    catch(Exception e){
        out.print(e);
    }
%>

</body>
</html>