package com.yash.cabinallotment.serviceimpl;

import com.yash.cabinallotment.dao.CabinDAO;
import com.yash.cabinallotment.daoimpl.CabinDAOImpl;
import com.yash.cabinallotment.domain.Cabins;
import com.yash.cabinallotment.exception.CabinException;
import com.yash.cabinallotment.service.CabinService;

import java.util.List;

public class CabinServiceImpl implements CabinService {
    private CabinDAO cabinDAO;

    public CabinServiceImpl() {
        cabinDAO = new CabinDAOImpl();
    }

    @Override
    public List<Cabins> getAllCabins() throws CabinException {
        return cabinDAO.getAllCabins();
    }

    @Override
    public void createCabin(Cabins cabin) throws CabinException {
        cabinDAO.createCabin(cabin);
    }

    @Override
    public void updateCabin(Cabins cabin) throws CabinException {
        cabinDAO.updateCabin(cabin);
    }

    @Override
    public void deleteCabin(int cabinId) throws CabinException {
        cabinDAO.deleteCabin(cabinId);
    }
}
