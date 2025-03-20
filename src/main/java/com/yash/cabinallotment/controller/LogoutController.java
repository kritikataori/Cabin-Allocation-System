package com.yash.cabinallotment.controller;

import com.yash.cabinallotment.domain.Users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            Users user = (Users) session.getAttribute("user");
            if (user != null && user.getRole() != null) {
                String role = user.getRole();
                if ("admin".equals(role)) {
                    res.sendRedirect("admin_dashboard.jsp");
                } else if ("employee".equals(role)) {
                    res.sendRedirect("employee_dashboard.jsp");
                } else {
                    res.sendRedirect("index.jsp");
                }
                return;
            }
        }
        res.sendRedirect("index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false); // Get session, but don't create if it doesn't exist
        try {
            if (session != null) {
                session.invalidate(); // Invalidate the session
            }
            res.sendRedirect("index.jsp");
        } catch (Exception e) {
            req.setAttribute("errorMessage", "Failed to logout");
            req.getRequestDispatcher("logout.jsp").forward(req, res);
        }
    }
}
