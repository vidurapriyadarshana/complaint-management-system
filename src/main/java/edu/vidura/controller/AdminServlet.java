package edu.vidura.controller;
import edu.vidura.model.bean.Complaint;

import edu.vidura.model.dao.ComplaintDAO;
import edu.vidura.model.dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("update".equalsIgnoreCase(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                String status = req.getParameter("status");
                String remarks = req.getParameter("remarks");

                Complaint complaint = new Complaint();
                complaint.setId(id);
                complaint.setStatus(status);
                complaint.setRemarks(remarks);

                ComplaintDAO complaintDAO = new ComplaintDAO(getServletContext());
                boolean updated = complaintDAO.updateStatus(complaint);

                if (updated) {
                    req.setAttribute("message", "Complaint updated successfully.");
                } else {
                    req.setAttribute("error", "Failed to update complaint. Try again.");
                }
            } catch (Exception e) {
                req.setAttribute("error", "An error occurred while updating the complaint.");
                e.printStackTrace();
            }
        }

        RequestDispatcher dispatcher = req.getRequestDispatcher("/complaint");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher rd = req.getRequestDispatcher("WEB-INF/views/admin_dashboard.jsp");
        rd.forward(req, resp);
    }
}
