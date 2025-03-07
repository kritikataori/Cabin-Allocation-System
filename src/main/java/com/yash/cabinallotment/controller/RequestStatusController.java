package com.yash.cabinallotment.controller;

import com.yash.cabinallotment.domain.Requests;
import com.yash.cabinallotment.domain.Users;
import com.yash.cabinallotment.service.CabinRequestService;
import com.yash.cabinallotment.serviceimpl.CabinRequestServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/request_status")
public class RequestStatusController extends HttpServlet {
    private CabinRequestService cabinRequestService;

    @Override
    public void init() throws ServletException {
        cabinRequestService = new CabinRequestServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users user = (Users) session.getAttribute("user");
        if (user != null) {
            if (!"employee".equals(user.getRole())) {
                req.setAttribute("accessDeniedError", "You are not authorized to access this page.");
                req.getRequestDispatcher("index.jsp").forward(req, res);
                return;
            }
            List<Requests> userRequests = cabinRequestService.getRequestsByUserId(user.getId());
            for (Requests request : userRequests) {
                if (request.getCabinId() != null) {
                    String cabinName = cabinRequestService.getCabinNameById(request.getCabinId());
                    request.setCabinName(cabinName);
                }
                if(request.getStatus().equals("approved") && request.getAssignedCabinId() != 0) {
                    String assignedCabinName = cabinRequestService.getCabinNameById(request.getAssignedCabinId());
                    if(request.getCabinId() == request.getAssignedCabinId()){
                        request.setAssignedCabinName(request.getCabinName());
                    } else {
                        request.setAssignedCabinName(assignedCabinName);
                    }
                }
            }
            req.setAttribute("userRequests", userRequests);
            req.getRequestDispatcher("request_status.jsp").forward(req, res);
        } else {
            res.sendRedirect("login.jsp");
        }
    }
}
