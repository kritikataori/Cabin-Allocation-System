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
public class AutoCabinDeallocation implements ServletContextListener {

    private ScheduledExecutorService scheduler; //Java concurrency utility that allows you to schedule tasks to run at a fixed rate or with a delay.
    private AllocationService allocationService;
    private CabinService cabinService;
    private CabinRequestDAOImpl cabinRequestDAO;

    @Override
    public void contextInitialized(ServletContextEvent sce){  //called when the web application is initialized.
        System.out.println("Application started! AutoCabinDeallocation initialized.");

        allocationService = new AllocationServiceImpl();
        cabinService = new CabinServiceImpl();
        cabinRequestDAO = new CabinRequestDAOImpl();

        scheduler = Executors.newScheduledThreadPool(1); //creates a thread pool with a single thread for executing scheduled tasks
        scheduler.scheduleAtFixedRate(new Runnable() {  //run tasks repeatedly at a fixed rate.
            @Override
            public void run() {
                deallocateExpiredCabins();
            }
        }, 0, 1, TimeUnit.MINUTES); // Run every 1 minute
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) { //called when the web application is about to be shut down
        System.out.println("Application stopped! AutoCabinDeallocation shutting down.");
        if (scheduler != null) {
            scheduler.shutdownNow();
        }
    }

    private void deallocateExpiredCabins() {
        try {
            List<Requests> expiredRequests = cabinRequestDAO.getExpiredRequests();
            System.out.println("Expired Requests: " + expiredRequests);

            for (Requests request : expiredRequests) {
                int cabinIdToDeallocate = request.getAssignedCabinId() != 0 ? request.getAssignedCabinId() : request.getCabinId();
                // Check if the cabin is not assigned to another active request
                if (!cabinRequestDAO.isCabinAssignedToOtherRequest(cabinIdToDeallocate, request.getId())) {
                    cabinService.updateCabinStatus(cabinIdToDeallocate, "available");
                }
                cabinRequestDAO.updateAllocationStatus(request.getId(), "expired");
                allocationService.updateAllocationStatusByRequestId(request.getId(), "expired");
                System.out.println("Cabin " + cabinIdToDeallocate + " deallocated due to expired request.");
            }
        } catch (Exception e) {
            System.err.println("Error deallocating expired cabins: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
