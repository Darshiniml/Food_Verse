<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.food_application.model.User"%>

<%
User admin = (User) session.getAttribute("loggedUser");
%>

<div class="topbar">

    <div>
        <h3 style="margin:0;font-weight:700;">
            Admin Dashboard
        </h3>
    </div>

    <div class="admin-info">

        <i class="bi bi-person-circle fs-2"></i>

        <div class="ms-2">

            <strong>

                <%=admin!=null?admin.getName():"Administrator"%>

            </strong>

            <br>

            <small class="text-muted">

                System Administrator

            </small>

        </div>

    </div>

</div>