<<<<<<< HEAD
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.food_application.model.User"%>

<%
User admin = (User) session.getAttribute("loggedUser");
%>

<div class="topbar">

    <div>
        <h4 style="margin:0;">Admin Dashboard</h4>
    </div>

    <div class="admin-info">

        <i class="bi bi-person-circle"></i>

        <div>

            <b><%=admin != null ? admin.getName() : "Administrator"%></b>

            <br>

            <small style="color:gray;">
                System Administrator
            </small>

        </div>

    </div>
=======
<div class="topbar">

<div>

<h3>

Admin Dashboard

</h3>

</div>

<div>

Welcome Admin

</div>
>>>>>>> 0c9c09f47493e717ad427f5ae69f05b355c0e9a6

</div>