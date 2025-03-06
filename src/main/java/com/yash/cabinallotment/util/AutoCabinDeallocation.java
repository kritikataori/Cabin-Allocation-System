package com.yash.cabinallotment.util;

import com.yash.cabinallotment.domain.Allocations;
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
    private ScheduledExecutorService scheduler;
    private AllocationService allocationService;
    private CabinService cabinService;

    @Override
    public void contextInitialized(ServletContextEvent sce){
        System.out.println("Application started! AutoCabinDeallocation initialized.");

        allocationService = new AllocationServiceImpl();
        cabinService = new CabinServiceImpl();

        scheduler = Executors.newScheduledThreadPool(1);
        scheduler.scheduleAtFixedRate(new Runnable() {
            @Override
            public void run() {
                deallocateExpiredCabins();
            }
        }, 0, 1, TimeUnit.MINUTES); // Run every 1 minute
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("Application stopped! AutoCabinDeallocation shutting down.");
        if (scheduler != null) {
            scheduler.shutdownNow();
        }
    }

    private void deallocateExpiredCabins() {
        try {
            List<Allocations> expiredAllocations = allocationService.getExpiredAllocations();
            System.out.println("Expired Allocations: " + expiredAllocations);

            for (Allocations allocation : expiredAllocations) {
                int cabinIdToDeallocate = allocation.getAssignedCabinId() != 0 ? allocation.getAssignedCabinId() : allocation.getCabinId();
                cabinService.updateCabinStatus(cabinIdToDeallocate, "available");
                allocationService.updateAllocationStatus(allocation.getId(), "expired");
                System.out.println("Cabin " + cabinIdToDeallocate + " deallocated due to expired allocation.");
            }
        } catch (Exception e) {
            System.err.println("Error deallocating expired cabins: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
