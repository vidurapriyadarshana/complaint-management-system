<%@ page import="edu.vidura.model.bean.Complaint" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
    String username = (String) session.getAttribute("user");

    // Check if we're editing a complaint
    String editId = request.getParameter("editId");
    Complaint editComplaint = null;
    if (editId != null && complaints != null) {
        for (Complaint c : complaints) {
            if (String.valueOf(c.getId()).equals(editId)) {
                editComplaint = c;
                break;
            }
        }
    }
%>
<html>
<head>
    <title>Employee Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 900px;
            margin: 50px auto;
        }

        h1, h2 {
            color: #004080;
            margin-bottom: 20px;
        }

        form input[type="text"],
        form textarea {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            box-sizing: border-box;
        }

        form input[type="submit"] {
            background-color: #004080;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            width: 100%;
        }

        form input[type="submit"]:hover {
            background-color: #003060;
        }

        /* Update button styling */
        form input[type="submit"].update-btn {
            background-color: #008000;
        }

        form input[type="submit"].update-btn:hover {
            background-color: #006600;
        }

        /* Cancel button styling */
        .cancel-btn {
            background-color: #808080;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            box-sizing: border-box;
        }

        .cancel-btn:hover {
            background-color: #606060;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ccc;
            text-align: left;
            font-size: 14px;
        }

        th {
            background-color: #004080;
            color: white;
        }

        .actions {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .actions form {
            margin: 0;
            padding: 0;
        }

        .edit-link {
            background-color: #008000;
            color: white;
            text-decoration: none;
            font-weight: bold;
            padding: 8px 16px;
            border-radius: 4px;
            font-size: 12px;
            text-align: center;
            display: inline-block;
            width: 60px;
            box-sizing: border-box;
        }

        .edit-link:hover {
            background-color: #006600;
            text-decoration: none;
        }

        .delete-link {
            background-color: #FF0000;
            border: none;
            color: white;
            font-weight: bold;
            cursor: pointer;
            padding: 8px 16px;
            font-size: 12px;
            border-radius: 4px;
            width: 60px;
            box-sizing: border-box;
        }

        .delete-link:hover {
            background-color: #CC0000;
        }

        /* Disabled button styling */
        .edit-link.disabled,
        .delete-link.disabled {
            background-color: #CCCCCC;
            color: #666666;
            cursor: not-allowed;
            opacity: 0.6;
        }

        .edit-link.disabled:hover,
        .delete-link.disabled:hover {
            background-color: #CCCCCC;
        }

        .form-buttons {
            display: flex;
            gap: 10px;
        }

        .form-buttons > * {
            flex: 1;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Welcome, <%= username != null ? username : "Employee" %></h1>

    <h2><%= editComplaint != null ? "Update Complaint" : "Submit a New Complaint" %></h2>
    <form action="<%= request.getContextPath() %><%= editComplaint != null ? "/updateComplaint" : "/complaint" %>" method="post">
        <% if (editComplaint != null) { %>
        <input type="hidden" name="id" value="<%= editComplaint.getId() %>" />
        <% } %>

        <input type="text" name="title" placeholder="Complaint Title"
               value="<%= editComplaint != null ? editComplaint.getTitle() : "" %>" required /><br/>

        <textarea name="description" placeholder="Complaint Description" rows="4" required><%= editComplaint != null ? editComplaint.getDescription() : "" %></textarea><br/>

        <div class="form-buttons">
            <input type="submit"
                   value="<%= editComplaint != null ? "Update Complaint" : "Submit Complaint" %>"
                   class="<%= editComplaint != null ? "update-btn" : "" %>" />

            <% if (editComplaint != null) { %>
            <a href="<%= request.getContextPath() %>/complaint" class="cancel-btn">Cancel</a>
            <% } %>
        </div>
    </form>

    <h2>Your Complaints</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Description</th>
            <th>Status</th>
            <th>Remarks</th>
            <th>Actions</th>
        </tr>
        <%
            if (complaints != null && !complaints.isEmpty()) {
                for (Complaint c : complaints) {
        %>
        <tr>
            <td><%= c.getId() %></td>
            <td><%= c.getTitle() %></td>
            <td><%= c.getDescription() %></td>
            <td><%= c.getStatus() %></td>
            <td><%= c.getRemarks() != null ? c.getRemarks() : "-" %></td>
            <td class="actions">
                <% if ("RESOLVED".equalsIgnoreCase(c.getStatus())) { %>
                <span class="edit-link disabled">Edit</span>
                <button class="delete-link disabled" disabled>Delete</button>
                <% } else { %>
                <a class="edit-link" href="<%= request.getContextPath() %>/complaint?editId=<%= c.getId() %>">Edit</a>
                <form action="<%= request.getContextPath() %>/complaintAction" method="post" onsubmit="return confirm('Are you sure you want to delete this complaint?');">
                    <input type="hidden" name="id" value="<%= c.getId() %>" />
                    <input type="submit" class="delete-link" value="Delete" />
                </form>
                <% } %>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="6">You haven't submitted any complaints yet.</td>
        </tr>
        <% } %>
    </table>
</div>
</body>
</html>