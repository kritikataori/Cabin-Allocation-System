package com.yash.cabinallotment.dao;

import com.yash.cabinallotment.domain.Requests;
import com.yash.cabinallotment.exception.CabinRequestException;

import java.util.List;

public interface CabinRequestDAO {
    void createRequest(Requests request);
    void approveRequest(int reqId) throws CabinRequestException;
    void rejectRequest(int reqId) throws CabinRequestException;
    List<Requests> getRequestsByUserId(int userId) throws CabinRequestException;
    List<Requests> getPendingRequests() throws CabinRequestException;
    int getPendingRequestCount() throws CabinRequestException;
    void assignOtherCabin(int reqId, int cabinId) throws CabinRequestException;
    Requests getRequestById(int reqId) throws CabinRequestException;
    void updateAssignedCabinId(int requestId, int assignedCabinId) throws CabinRequestException;
}
