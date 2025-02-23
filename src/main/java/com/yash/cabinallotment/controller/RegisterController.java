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

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.getRequestDispatcher("register.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        System.out.println("doPost() called");

        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String role = "employee";

        Users user = new Users(username, password, email, role);

        try {
            userService.registerUser(user);
            Users registeredUser = userService.loginUser(user);
            if (registeredUser != null) {
                HttpSession session = req.getSession();
                session.setAttribute("user", registeredUser);
                System.out.println("User registered in session: " + session.getId());
                System.out.println("Session user: " + registeredUser);
                res.sendRedirect("login.jsp");
            } else {
                req.setAttribute("errorMessage", "Login after registration failed.");
                req.getRequestDispatcher("register.jsp").forward(req, res);
            }
        } catch (UserException e) {
            req.setAttribute("errorMessage", e.getMessage());
            req.getRequestDispatcher("register.jsp").forward(req, res);
        }
    }
}
