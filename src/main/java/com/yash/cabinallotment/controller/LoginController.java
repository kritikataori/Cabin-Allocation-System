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

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
    }

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false); //returns current session if current session exists. If not, it will not create a new session.
        if (session != null && session.getAttribute("user") != null) {
            Users user = (Users) session.getAttribute("user");
            System.out.println("DEBUG: User object from session: " + user);
            if ("admin".equals(user.getRole())) {
                res.sendRedirect("admin_dashboard.jsp");
            } else {
                res.sendRedirect("employee_dashboard.jsp");
            }
        } else {
            req.getRequestDispatcher("login.jsp").forward(req, res);
        }
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        System.out.println("DEBUG: Received username: " + username + ", password: " + password);

        try {
            Users user = userService.confirmUser(username, password);
            if (user != null) {
                HttpSession session = req.getSession();
                session.setAttribute("user", user); // Store the complete user object in session
                System.out.println("DEBUG: User object from session: " + user);
                if ("admin".equals(user.getRole())) {
                    res.sendRedirect("admin_dashboard.jsp");
                } else {
                    res.sendRedirect("employee_dashboard.jsp");
                }
            } else {
                req.setAttribute("errorMessage", "Invalid username or password.");
                req.getRequestDispatcher("login.jsp").forward(req, res);
            }
        } catch (UserException e) {
            req.setAttribute("errorMessage", e.getMessage());
            req.getRequestDispatcher("login.jsp").forward(req, res);
        }
    }
}
