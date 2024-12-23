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
body, html {
  height: 100%;
  margin: 0;
}

.bg {
 
  background-image: url("balance.jpg");

  /* Full height */
  height: 100%; 

  /* Center and scale the image nicely */
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
}
</style>
<body>
<div class="bg">
    <%
        //getting username cookie from the request and displaying it

        Cookie cookies[] = request.getCookies();
        String name = "";
        
        try
        {
            for(int i=0;i<cookies.length;i++){
                    if(cookies[i].getName().compareTo("name")==0){
                        name = cookies[i].getValue();
                        break;
                    }
            }
        }catch(Exception e){
            out.print("<center><h3>Welcome Stranger, Please Login!</h3></center>");
            return;
        }

        if(name.length()==0){
            out.print("<center><h3>Unable to Fetch the balance, Please Login!</h3><center>");
        }else{
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","pragna","1234");
            PreparedStatement st = con.prepareStatement("select * from users where username = ? ");
            st.setString(1,name);
            ResultSet rs = st.executeQuery();
            if(rs.next()){
                out.print("<center><h2>Welcome "+name.toUpperCase()+"!</h2></center>");
                out.print("<center><h1>Your Account Balance : $"+rs.getString(4)+"</h1><center>");
            }else{
                out.print("<center><h3>Unable to fetch Balance!</h3><center>");
            }
            con.close();
        }
        
    %>
	</div>
</body>
</html>