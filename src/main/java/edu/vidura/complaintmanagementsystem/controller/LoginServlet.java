package edu.vidura.complaintmanagementsystem.controller;

import edu.vidura.complaintmanagementsystem.model.bean.User;
import edu.vidura.complaintmanagementsystem.model.dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/api/v1/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        ServletContext context = getServletContext();
        userDAO = new UserDAO(context);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = userDAO.validate(username, password);

        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user.getUsername());
            session.setAttribute("role", user.getRole());
            session.setMaxInactiveInterval(30 * 60);

            RequestDispatcher rd;
            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                rd = req.getRequestDispatcher("/WEB-INF/views/admin_dashboard.jsp");
            } else if ("EMPLOYEE".equalsIgnoreCase(user.getRole())) {
                rd = req.getRequestDispatcher("/WEB-INF/views/dashboard.jsp");
            } else {
                req.setAttribute("errorMessage", "Unauthorized role.");
                rd = req.getRequestDispatcher("/WEB-INF/views/login.jsp");
            }
            rd.forward(req, resp);
        } else {
            req.setAttribute("errorMessage", "Invalid username or password.");
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
    }
}
