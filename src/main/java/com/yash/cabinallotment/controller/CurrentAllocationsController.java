package com.yash.cabinallotment.controller;

import com.yash.cabinallotment.domain.Allocations;
import com.yash.cabinallotment.domain.Users;
import com.yash.cabinallotment.service.AllocationService;
import com.yash.cabinallotment.serviceimpl.AllocationServiceImpl;
import com.yash.cabinallotment.util.ExcelGenerator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

@WebServlet("/currentAllocations")
public class CurrentAllocationsController extends HttpServlet {
    private AllocationService allocationService;

    @Override
    public void init() throws ServletException {
        allocationService = new AllocationServiceImpl();
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

        List<Allocations> currentAllocations = allocationService.getCurrentAllocations();
        req.setAttribute("currentAllocations", currentAllocations);
        req.getRequestDispatcher("currentAllocations.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("downloadExcel".equals(action)) {
            downloadExcel(req, res);
        } else {
            doGet(req, res);
        }
    }

    private void downloadExcel(HttpServletRequest req, HttpServletResponse res) throws IOException{
        List<Allocations> currentAllocations = allocationService.getCurrentAllocations();
        System.out.println("Current Allocations Size: " + currentAllocations.size());
        if (!currentAllocations.isEmpty()) {
            System.out.println("First Allocation: " + currentAllocations.get(0)); // Or loop through and print all
        }

        ByteArrayOutputStream outputStream = ExcelGenerator.generateCurrentAllocationsExcel(currentAllocations);

        res.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        res.setHeader("Content-Disposition", "attachment; filename=currentAllocations.xlsx");

        outputStream.writeTo(res.getOutputStream());
        res.getOutputStream().flush();
    }
}
