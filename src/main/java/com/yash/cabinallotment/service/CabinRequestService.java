package com.yash.cabinallotment.service;

import com.yash.cabinallotment.domain.Requests;
import com.yash.cabinallotment.exception.CabinRequestException;

import java.util.List;

public interface CabinRequestService {
    void createRequest(Requests request) throws CabinRequestException;
    void approveRequest(int reqId) throws CabinRequestException;
    void rejectRequest(int reqId) throws CabinRequestException;
    List<Requests> getRequestsByUserId(int userId) throws CabinRequestException;
    List<Requests> getPendingRequests() throws CabinRequestException;
    int getPendingRequestCount() throws CabinRequestException;
    String getCabinNameById(int cabinId) throws CabinRequestException;
}
