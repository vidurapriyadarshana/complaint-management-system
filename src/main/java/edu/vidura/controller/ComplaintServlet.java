package edu.vidura.controller;

import edu.vidura.model.bean.Complaint;
import edu.vidura.model.dao.ComplaintDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/complaint")
public class ComplaintServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer userId = (Integer) req.getSession().getAttribute("userId");

        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String title = req.getParameter("title");
        String description = req.getParameter("description");

        if (title == null || description == null || title.trim().isEmpty() || description.trim().isEmpty()) {
            req.setAttribute("errorMessage", "Title and Description are required.");
            doGet(req, resp);
            return;
        }

        Complaint complaint = new Complaint();
        complaint.setUserId(userId);
        complaint.setTitle(title);
        complaint.setDescription(description);
        complaint.setStatus("PENDING");

        ComplaintDAO dao = new ComplaintDAO(getServletContext());
        boolean inserted = dao.insertComplaint(complaint);

        if (!inserted) {
            req.setAttribute("errorMessage", "Failed to submit complaint.");
        }

        resp.sendRedirect(req.getContextPath() + "/complaint");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer userId = (Integer) req.getSession().getAttribute("userId");
        String role = (String) req.getSession().getAttribute("role");

        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        if ("EMPLOYEE".equalsIgnoreCase(role)) {
            ComplaintDAO complaintDAO = new ComplaintDAO(getServletContext());
            List<Complaint> complaints = complaintDAO.findByUserId(userId);

            req.setAttribute("complaints", complaints);
            req.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(req, resp);
//            resp.sendRedirect(req.getContextPath() + "/admin");
        } else if ("ADMIN".equalsIgnoreCase(role)) {
            ComplaintDAO complaintDAO = new ComplaintDAO(getServletContext());
            List<Complaint> complaints = complaintDAO.findAll();

            req.setAttribute("complaints", complaints);
            req.getRequestDispatcher("WEB-INF/views/admin_dashboard.jsp").forward(req, resp);
//            resp.sendRedirect(req.getContextPath() + "/admin");
        }


    }
}
