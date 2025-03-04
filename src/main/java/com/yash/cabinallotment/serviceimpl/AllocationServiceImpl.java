package com.yash.cabinallotment.serviceimpl;

import com.yash.cabinallotment.dao.AllocationDAO;
import com.yash.cabinallotment.daoimpl.AllocationDAOImpl;
import com.yash.cabinallotment.domain.Allocations;
import com.yash.cabinallotment.exception.CabinException;
import com.yash.cabinallotment.service.AllocationService;

import java.util.List;

public class AllocationServiceImpl implements AllocationService {
    private AllocationDAO allocationDAO;

    public AllocationServiceImpl() {
        allocationDAO = new AllocationDAOImpl();
    }

    @Override
    public List<Allocations> getCurrentAllocations() throws CabinException {
        try {
            return allocationDAO.getCurrentAllocations();
        } catch (Exception e) {
            throw new CabinException("Error retrieving current allocations: " + e.getMessage());
        }
    }

    @Override
    public void addAllocation(Allocations allocation) throws CabinException {
        try {
            allocationDAO.addAllocation(allocation);
        } catch (Exception e) {
            throw new CabinException("Error adding allocation: " + e.getMessage());
        }
    }

    @Override
    public List<Allocations> getExpiredAllocations() throws CabinException {
        try {
           return allocationDAO.getExpiredAllocations();
        } catch (Exception e) {
            throw new CabinException("Error retrieving expired allocations: " + e.getMessage());
        }
    }

    @Override
    public void updateAllocationStatus(int allocationId, String status) {
        allocationDAO.updateAllocationStatus(allocationId, status);
    }
}
