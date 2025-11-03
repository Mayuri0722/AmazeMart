<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    // Invalidate the current session
    HttpSession Session = request.getSession(false);
    if (session != null) {
        session.invalidate();
    }

    // Prevent caching to block back button after logout
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // Redirect to login page
    response.sendRedirect("login.jsp");
%>
