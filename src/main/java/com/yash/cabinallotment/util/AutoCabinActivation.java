package com.yash.cabinallotment.util;

import com.yash.cabinallotment.daoimpl.CabinRequestDAOImpl;
import com.yash.cabinallotment.domain.Allocations;
import com.yash.cabinallotment.domain.Requests;
import com.yash.cabinallotment.service.AllocationService;
import com.yash.cabinallotment.service.CabinService;
import com.yash.cabinallotment.serviceimpl.AllocationServiceImpl;
import com.yash.cabinallotment.serviceimpl.CabinServiceImpl;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

@WebListener
public class AutoCabinActivation implements ServletContextListener {
    private ScheduledExecutorService scheduler;
    private AllocationService allocationService;
    private CabinRequestDAOImpl cabinRequestDAO;
    private CabinService cabinService;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("AutoCabinActivation initialized.");
        allocationService = new AllocationServiceImpl();
        cabinRequestDAO = new CabinRequestDAOImpl();
        cabinService = new CabinServiceImpl();

        scheduler = Executors.newScheduledThreadPool(1);
        scheduler.scheduleAtFixedRate(new Runnable() {
            @Override
            public void run() {
                activatePendingAllocations();
            }
        }, 0, 30, TimeUnit.SECONDS); // Run every 30 seconds
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("AutoCabinActivation shutting down.");
        if (scheduler != null) {
            scheduler.shutdownNow();
        }
    }

    private void activatePendingAllocations() {
        try {
            List<Requests> pendingRequests = cabinRequestDAO.getRequestsForActivation();

            for (Requests request : pendingRequests) {
                // Create Allocation
                Allocations allocation = new Allocations();
                allocation.setRequestId(request.getId());
                allocation.setCabinId(request.getCabinId());
                allocation.setEmployeeId(request.getEmpId());
                allocation.setStartTime(request.getStartTime());
                allocation.setEndTime(request.getEndTime());
                allocation.setAssignedCabinId(request.getAssignedCabinId());

                allocationService.addAllocation(allocation);

                // Update Request Status
                cabinRequestDAO.updateAllocationStatus(request.getId(), "active");

                // Update Cabin Status
                int cabinIdToAllocate = request.getAssignedCabinId() != 0 ? request.getAssignedCabinId() : request.getCabinId();
                cabinService.updateCabinStatus(cabinIdToAllocate, "occupied");
                System.out.println("Cabin " + cabinIdToAllocate + " allocated for request " + request.getId());
            }
        } catch (Exception e) {
            System.err.println("Error activating pending allocations: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
