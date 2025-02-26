package com.yash.cabinallotment.controller;

import com.yash.cabinallotment.domain.Cabins;
import com.yash.cabinallotment.exception.CabinException;
import com.yash.cabinallotment.service.CabinService;
import com.yash.cabinallotment.serviceimpl.CabinServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/manageCabins")
public class ManageCabinsController extends HttpServlet {
    private CabinService cabinService;

    @Override
    public void init() throws ServletException {
        cabinService = new CabinServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        List<Cabins> allCabins = cabinService.getAllCabins();
        req.setAttribute("allCabins", allCabins);
        req.getRequestDispatcher("manageCabins.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");

        try {
            if ("create".equals(action)) {
                String name = req.getParameter("cabinName");
                int capacity = Integer.parseInt(req.getParameter("capacity"));
                String status = req.getParameter("status");
                Cabins newCabin = new Cabins(0, name, capacity, status);
                cabinService.createCabin(newCabin);
            }
            else if ("update".equals(action)) {
                int id = Integer.parseInt(req.getParameter("cabinId"));
                String name = req.getParameter("cabinName");
                int capacity = Integer.parseInt(req.getParameter("capacity"));
                String status = req.getParameter("status");
                Cabins updatedCabin = new Cabins(id, name, capacity, status);
                cabinService.updateCabin(updatedCabin);
            }
            else if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("cabinId"));
                cabinService.deleteCabin(id);
            }
            else {
                throw new CabinException("Invalid action on cabin");
            }
            res.sendRedirect("/manageCabins");
        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "Invalid number format.");
            doGet(req,res);
        } catch (CabinException e){
            req.setAttribute("errorMessage", e.getMessage());
            doGet(req,res);
        }
    }
}