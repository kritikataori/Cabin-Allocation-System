package com.yash.cabinallotment.service;

import com.yash.cabinallotment.domain.Allocations;
import com.yash.cabinallotment.exception.CabinException;

import java.util.List;

public interface AllocationService {
    List<Allocations> getCurrentAllocations() throws CabinException;
    void addAllocation(Allocations allocation) throws CabinException;
    List<Allocations> getExpiredAllocations() throws CabinException;
    void updateAllocationStatus(int allocationId, String status) throws CabinException;
    List<Allocations> getAllocationsWithExpiredStatus();
}

