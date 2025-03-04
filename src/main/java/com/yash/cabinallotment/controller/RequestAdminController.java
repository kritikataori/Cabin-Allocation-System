package com.yash.cabinallotment.controller;

import com.yash.cabinallotment.exception.UserException;
import com.yash.cabinallotment.service.UserService;
import com.yash.cabinallotment.serviceimpl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

//for employees to submit admin role requests.
@WebServlet("/requestAdmin")
public class RequestAdminController extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect("login.jsp"); // Redirect to log in if no session
            return;
        }

        String username = req.getParameter("username");
        String reason = req.getParameter("reason");

        try {
            userService.requestAdminRole(username, reason);
            req.setAttribute("successMessage", "Request for admin role submitted successfully.");
            req.getRequestDispatcher("employee_dashboard.jsp").forward(req, res);
        } catch (UserException e) {
            req.setAttribute("errorMessage", e.getMessage());
            req.getRequestDispatcher("employee_dashboard.jsp").forward(req, res);
        }
    }
}
