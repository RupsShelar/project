<%@ page import="java.sql.*" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.io.InputStream" %>

<%
    String userName = request.getParameter("userName");    
    String password = request.getParameter("password");
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");

    // Load DB config from application.properties
    InputStream input = getServletContext().getResourceAsStream("/WEB-INF/classes/application.properties");
    Properties props = new Properties();
    props.load(input);

    String url = props.getProperty("db.url");
    String dbUser = props.getProperty("db.username");
    String dbPass = props.getProperty("db.password");

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(url, dbUser, dbPass);

    Statement st = con.createStatement();
    int i = st.executeUpdate(
        "INSERT INTO USER(first_name, last_name, email, username, password, regdate) " +
        "VALUES ('" + firstName + "','" + lastName + "','" + email + "','" + userName + "','" + password + "', CURDATE())"
    );

    if (i > 0) {
        response.sendRedirect("welcome.jsp");
    } else {
        response.sendRedirect("index.jsp");
    }

    con.close();
%>
