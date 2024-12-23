<%@ page import = "java.lang.*,java.util.*,java.sql.*,java.io.*" %>
<%@ page import = "java.servlet.http.*,java.servlet.*,java.text.*" %>
<%
    String receiver = request.getParameter("receiver");
    int amount = Integer.valueOf(request.getParameter("amount"));

    String sender = "";
    int sender_balance = 0;

    Cookie cookies[] = request.getCookies();
    for(int i=0;i<cookies.length;i++){
        if(cookies[i].getName().compareTo("name")==0){
            sender = cookies[i].getValue();
        }
        if(cookies[i].getName().compareTo("balance")==0){
            sender_balance = Integer.valueOf(cookies[i].getValue());
        }
		out.print(sender_balance);
    }
    if(sender.length()==0){
        out.print("Please Login!");
        return;
    }
    if(sender_balance < amount){
        out.print("Insufficient Balance!");
        return;
    }

    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","pragna","1234");

    //check if receiver is present
    PreparedStatement ps = con.prepareStatement("select * from users where username=?");
    ps.setString(1, receiver);
    ResultSet rs = ps.executeQuery();
    int receiver_balance = 0;
    if(rs.next()){
        receiver_balance = rs.getInt(4);
    }else{
        out.print("Receiver doesn't exist!");
        con.close();
        return;
    }

    
    Statement st = con.createStatement();
    // Add amount to receiver
    String toBeAdded = String.valueOf(receiver_balance + amount);
    st.executeUpdate("update users set balance = '"+toBeAdded+"' where users.username = '"+receiver+"' ");
    
    // Subtract amount from sender
    String toBeSubtracted = String.valueOf(sender_balance - amount);
    st.executeUpdate("update users set balance = '"+toBeSubtracted+"' where users.username = '"+sender+"' ");

    // Add this transaction to transactions table
      String day = request.getParameter("dd");
		 
		
   PreparedStatement pst=con.prepareStatement("insert into transactions values(?,?,?,?)");
          pst.setString(1,sender);
          pst.setString(2,receiver);
          pst.setString(3,day);
		  pst.setString(4,String.valueOf(amount));
         
          pst.executeUpdate();
    
    con.close();

    out.print("<h3>Transfer Successfull!</h3>");
%>