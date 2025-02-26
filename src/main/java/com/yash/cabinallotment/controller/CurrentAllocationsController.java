package com.yash.cabinallotment.controller;

import com.yash.cabinallotment.domain.Allocations;
import com.yash.cabinallotment.service.AllocationService;
import com.yash.cabinallotment.serviceimpl.AllocationServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
        List<Allocations> currentAllocations = allocationService.getCurrentAllocations();
        req.setAttribute("currentAllocations", currentAllocations);
        req.getRequestDispatcher("currentAllocations.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        doGet(req,res);
    }
}
