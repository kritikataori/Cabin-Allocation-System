package com.yash.cabinallotment.dao;

import com.yash.cabinallotment.domain.Allocations;

import java.util.List;

public interface AllocationDAO {
    List<Allocations> getCurrentAllocations();
    void addAllocation(Allocations allocation);
}
