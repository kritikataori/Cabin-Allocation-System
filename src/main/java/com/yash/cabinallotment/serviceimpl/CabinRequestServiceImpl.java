package com.yash.cabinallotment.serviceimpl;

import com.yash.cabinallotment.dao.CabinDAO;
import com.yash.cabinallotment.dao.CabinRequestDAO;
import com.yash.cabinallotment.daoimpl.CabinDAOImpl;
import com.yash.cabinallotment.daoimpl.CabinRequestDAOImpl;
import com.yash.cabinallotment.domain.Requests;
import com.yash.cabinallotment.exception.CabinException;
import com.yash.cabinallotment.exception.CabinRequestException;
import com.yash.cabinallotment.service.CabinRequestService;

import java.util.List;

public class CabinRequestServiceImpl implements CabinRequestService {
    private CabinRequestDAO cabinRequestDAO;
    private CabinDAO cabinDAO;

    public CabinRequestServiceImpl() {
        this.cabinRequestDAO = new CabinRequestDAOImpl();
        this.cabinDAO = new CabinDAOImpl();
    }

    @Override
    public List<Requests> getPendingRequests() throws CabinRequestException {
        return cabinRequestDAO.getPendingRequests();
    }

    @Override
    public void createRequest(Requests request) throws CabinRequestException {
        cabinRequestDAO.createRequest(request);
    }

    @Override
    public void approveRequest(int reqId) throws CabinRequestException {
        cabinRequestDAO.approveRequest(reqId);
    }

    @Override
    public void rejectRequest(int reqId) throws CabinRequestException {
        cabinRequestDAO.rejectRequest(reqId);
    }

    @Override
    public int getPendingRequestCount() throws CabinRequestException {
        return cabinRequestDAO.getPendingRequestCount();
    }

    @Override
    public List<Requests> getRequestsByUserId(int userId) throws CabinRequestException {
        return cabinRequestDAO.getRequestsByUserId(userId);
    }

    @Override
    public String getCabinNameById(int cabinId) {
        return cabinDAO.getCabinNameById(cabinId);
    }

    @Override
    public void assignOtherCabin(int reqId, int cabinId) {
        cabinRequestDAO.assignOtherCabin(reqId, cabinId);
    }

    @Override
    public Requests getRequestById(int reqId) throws CabinRequestException {
        return cabinRequestDAO.getRequestById(reqId);
    }

    @Override
    public void updateAssignedCabinId(int requestId, int assignedCabinId) throws CabinRequestException {
        cabinRequestDAO.updateAssignedCabinId(requestId, assignedCabinId);
    }

    @Override
    public void updateAllocationStatus(int requestId, String status) {
        cabinRequestDAO.updateAllocationStatus(requestId, status);
    }
}
