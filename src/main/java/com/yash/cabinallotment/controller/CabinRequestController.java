package com.yash.cabinallotment.controller;

import com.yash.cabinallotment.domain.Allocations;
import com.yash.cabinallotment.domain.Cabins;
import com.yash.cabinallotment.domain.Requests;
import com.yash.cabinallotment.domain.Users;
import com.yash.cabinallotment.service.AllocationService;
import com.yash.cabinallotment.service.CabinRequestService;
import com.yash.cabinallotment.service.CabinService;
import com.yash.cabinallotment.serviceimpl.AllocationServiceImpl;
import com.yash.cabinallotment.serviceimpl.CabinRequestServiceImpl;
import com.yash.cabinallotment.serviceimpl.CabinServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Time;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet("/requests")
public class CabinRequestController extends HttpServlet {

    private CabinRequestService cabinRequestService;
    private CabinService cabinService;
    private AllocationService allocationService;

    @Override
    public void init() {
        cabinRequestService = new CabinRequestServiceImpl();
        cabinService = new CabinServiceImpl();
        allocationService = new AllocationServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        String action = req.getParameter("action");

//        List<Cabins> availableCabins = null;
//        if (cabinService != null) {
//            availableCabins = cabinService.getAllCabins();
//            req.setAttribute("availableCabins", availableCabins);
//        } else {
//            System.out.println("There are no cabins available!");
//        }
//        req.getRequestDispatcher("request_cabin.jsp").forward(req, res);

        List<Cabins> availableCabins = cabinService.getAllCabins(); // Get all cabins
        req.setAttribute("availableCabins", availableCabins);

        if ("requestCabin".equals(action)) {
            String cabinIdParam = req.getParameter("cabinId");
            if (cabinIdParam != null) {
                int cabinId = Integer.parseInt(cabinIdParam);
                Cabins selectedCabin = cabinService.getCabinById(cabinId); // Fetch the selected cabin details
                req.setAttribute("selectedCabin", selectedCabin);
                req.getRequestDispatcher("request_cabin.jsp").forward(req, res); // Redirect to employee page
            }
        }

        if ("pending".equals(action)) {
            List<Requests> pendingRequests = cabinRequestService.getPendingRequests();
            req.setAttribute("pendingRequests", pendingRequests);
            req.getRequestDispatcher("viewCabinRequests.jsp").forward(req, res); // Redirect to admin page
        }
        else {
            req.getRequestDispatcher("request_cabin.jsp").forward(req, res); // Redirect to employee page
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("create".equals(action)) {
            HttpSession session = req.getSession();
            Users user = (Users) session.getAttribute("user");
            if (user == null) {
                System.err.println("User is not available");
                res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Please login to do that");
                return;
            }
            int empId = user.getId();
            System.out.println("empId from session: " + empId);
            int cabinId = 0;
            java.sql.Date reqDate = null; // Use java.sql.Date
            Time startTime = null;
            Time endTime = null;
            try {
                cabinId = Integer.parseInt(req.getParameter("cabinId"));
                String dateString = req.getParameter("reqDate");

                if (dateString == null) {
                    System.err.println("No Date provided");
                    res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Date not provided");
                    return;
                }
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date parsedDate = sdf.parse(dateString);
                reqDate = new java.sql.Date(parsedDate.getTime());

                startTime = Time.valueOf(req.getParameter("startTime") + ":00");
                endTime = Time.valueOf(req.getParameter("endTime") + ":00");

                Requests newRequest = new Requests(empId, cabinId, reqDate, startTime, endTime, "pending");
                cabinRequestService.createRequest(newRequest);
                res.sendRedirect("employee_dashboard.jsp");

            }
            catch (NumberFormatException e) {
                System.err.println("CabinId is not a number");
                res.sendError(HttpServletResponse.SC_BAD_REQUEST, "The cabinId should be an integer");
                return;
            }
            catch (ParseException e) {
                System.err.println("Date is in wrong format");
                req.setAttribute("dateError", "Invalid date format. Please use yyyy-MM-dd");
                req.getRequestDispatcher("employee_dashboard.jsp").forward(req, res);
                return;
            }
            catch (IllegalArgumentException e) {
                System.err.println("Time is in the wrong format");
                req.setAttribute("timeError", "Invalid Time format. Please use yyyy-MM-dd");
                req.getRequestDispatcher("employee_dashboard.jsp").forward(req, res);
                return;
            }
        }
        else if ("approve".equals(action)) {
            int reqId = Integer.parseInt(req.getParameter("requestId"));
            Requests request = cabinRequestService.getRequestById(reqId);
            cabinRequestService.approveRequest(reqId);
            //create a new allocation
            Allocations allocation = new Allocations(0, reqId, request.getCabinId(), request.getEmpId(), request.getStartTime(), request.getEndTime());
            allocationService.addAllocation(allocation);
            res.sendRedirect("/requests?action=pending"); // Redirect back to pending requests
        }
        else if ("reject".equals(action)) {
            int reqId = Integer.parseInt(req.getParameter("requestId"));
            cabinRequestService.rejectRequest(reqId);
            res.sendRedirect("/requests?action=pending");
        }
        else if ("assignOther".equals(action)) {
            int reqId = Integer.parseInt(req.getParameter("requestId"));
            int cabinId = Integer.parseInt(req.getParameter("cabinId"));
            Requests request = cabinRequestService.getRequestById(reqId);

            // Update the request with the new cabinId
            cabinRequestService.assignOtherCabin(reqId, cabinId);

            // Get the updated request
            Requests updatedRequest = cabinRequestService.getRequestById(reqId);

            // Create a new allocation with the updated cabinId
            Allocations allocation = new Allocations(0, reqId, updatedRequest.getCabinId(), updatedRequest.getEmpId(), updatedRequest.getStartTime(), updatedRequest.getEndTime());
            allocation.setAssignedCabinId(cabinId); // set assigned cabin id here
            allocationService.addAllocation(allocation);

            res.sendRedirect("/requests?action=pending");
        }
        else {
            System.err.println("Invalid action parameter: " + action);
        }
    }
}

