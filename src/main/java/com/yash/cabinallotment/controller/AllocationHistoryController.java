package com.yash.cabinallotment.controller;

import com.yash.cabinallotment.domain.Allocations;
import com.yash.cabinallotment.domain.Users;
import com.yash.cabinallotment.service.AllocationService;
import com.yash.cabinallotment.serviceimpl.AllocationServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/allocationHistory")
public class AllocationHistoryController extends HttpServlet {
    private AllocationService allocationService;

    @Override
    public void init() throws ServletException {
        allocationService = new AllocationServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
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

        List<Allocations> expiredAllocations = allocationService.getAllocationsWithExpiredStatus();
        req.setAttribute("expiredAllocations", expiredAllocations);
        req.getRequestDispatcher("allocationHistory.jsp").forward(req, res);
    }
}
