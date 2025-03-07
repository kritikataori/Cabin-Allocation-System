package com.yash.cabinallotment.controller;

import com.yash.cabinallotment.domain.Users;
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
import java.util.List;

//for admins to manage admin requests.
@WebServlet("/adminRequests")
public class AdminRequestsController extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect("login.jsp");
            return;
        }
        Users user = (Users) session.getAttribute("user");
        if (!"admin".equals(user.getRole())) {
            req.setAttribute("accessDeniedError", "You are not authorized to access this page.");
            req.getRequestDispatcher("index.jsp").forward(req, res);
            return;
        }

        try {
            List<Users> adminRequests = userService.getPendingAdminRequests();
            req.setAttribute("adminRequests", adminRequests);
            req.getRequestDispatcher("viewAdminRequests.jsp").forward(req, res);
        } catch (UserException e) {
            req.setAttribute("errorMessage", e.getMessage());
            req.getRequestDispatcher("admin_dashboard.jsp").forward(req, res);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect("login.jsp");
            return;
        }
        Users user = (Users) session.getAttribute("user");
        if (!"admin".equals(user.getRole())) {
            req.setAttribute("accessDeniedError", "You are not authorized to access this page.");
            req.getRequestDispatcher("index.jsp").forward(req, res);
            return;
        }

        String action = req.getParameter("action");
        int userId = Integer.parseInt(req.getParameter("requestId"));

        try {
            if ("approve".equals(action)) {
                userService.approveAdminRequest(userId);
            } else if ("reject".equals(action)) {
                userService.rejectAdminRequest(userId);
            }
            res.sendRedirect("/adminRequests"); // Redirect back to the list
        } catch (UserException e) {
            req.setAttribute("errorMessage", e.getMessage());
            res.sendRedirect("/adminRequests");
        }
    }
}
