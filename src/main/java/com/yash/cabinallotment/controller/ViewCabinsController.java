package com.yash.cabinallotment.controller;

import com.yash.cabinallotment.domain.Allocations;
import com.yash.cabinallotment.domain.Cabins;
import com.yash.cabinallotment.service.AllocationService;
import com.yash.cabinallotment.service.CabinService;
import com.yash.cabinallotment.serviceimpl.AllocationServiceImpl;
import com.yash.cabinallotment.serviceimpl.CabinServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@WebServlet("/view_cabins")
public class ViewCabinsController extends HttpServlet {

    private CabinService cabinService;
    private AllocationService allocationService;

    @Override
    public void init() throws ServletException {
        cabinService = new CabinServiceImpl();
        allocationService = new AllocationServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        System.out.println("doGet() called");
        List<Cabins> allCabins = cabinService.getAllCabins();
        req.setAttribute("allCabins", allCabins);

        List<Allocations> currentAllocations = allocationService.getCurrentAllocations();
        req.setAttribute("currentAllocations", currentAllocations);
        req.getRequestDispatcher("view_cabins.jsp").forward(req, res);

        Set<Integer> assignedCabinIds = new HashSet<>();
        //System.out.println(assignedCabinIds);
        for (Allocations allocation : currentAllocations) {
            if (allocation.getAssignedCabinId() != 0) {
                assignedCabinIds.add(allocation.getAssignedCabinId());
            }
        }
        System.out.println(assignedCabinIds);
        req.setAttribute("assignedCabinIds", assignedCabinIds);
    }
}