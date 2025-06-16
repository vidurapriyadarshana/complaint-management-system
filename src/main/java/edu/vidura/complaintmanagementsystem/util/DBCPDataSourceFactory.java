package edu.vidura.complaintmanagementsystem.util;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.SQLException;

@WebListener
public class DBCPDataSourceFactory implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        BasicDataSource ds = new BasicDataSource();
        ds.setDriverClassName("com.mysql.cj.jdbc.Driver");
        ds.setUrl("jdbc:mysql://localhost:3306/complaintmanagementsystem");
        ds.setUsername("root");
        ds.setPassword("Vidura999@");

        ds.setInitialSize(5);
        ds.setMaxTotal(10);

        ServletContext context = sce.getServletContext();
        context.setAttribute("ds", ds);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        BasicDataSource ds = (BasicDataSource) sce.getServletContext().getAttribute("ds");
        try {
            if (ds != null) {
                ds.close();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
