package com.yash.cabinallotment.controller;

import com.yash.cabinallotment.domain.Cabins;
import com.yash.cabinallotment.domain.Users;
import com.yash.cabinallotment.exception.CabinException;
import com.yash.cabinallotment.service.CabinService;
import com.yash.cabinallotment.serviceimpl.CabinServiceImpl;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
@WebServlet("/manageCabins")
public class ManageCabinsController extends HttpServlet {
    private CabinService cabinService;

    @Override
    public void init() throws ServletException {
        cabinService = new CabinServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect("login.jsp");
            return;
        }
        Users user = (Users) session.getAttribute("user");
        if (!"admin".equals(user.getRole())) {
            req.setAttribute("accessDeniedError", "You are not authorized to access this page.");
            req.getRequestDispatcher("index.jsp").forward(req, res);
            return;
        }
        List<Cabins> allCabins = cabinService.getAllCabins();
        req.setAttribute("allCabins", allCabins);
        req.getRequestDispatcher("manageCabins.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        System.out.println("--- Start of doPost() ---");

        String action = null;
        Map<String, String> multipartParams = new HashMap<>();
        String fileName = null;

        try {
            if (ServletFileUpload.isMultipartContent(req)) {
                DiskFileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List<FileItem> items = upload.parseRequest(req);

                for (FileItem item : items) {
                    if (item.isFormField()) {
                        multipartParams.put(item.getFieldName(), item.getString("UTF-8"));
                    } else if ("cabinImage".equals(item.getFieldName())) {
                        if (item.getSize() > 0) {
                            fileName = UUID.randomUUID().toString() + "." + FilenameUtils.getExtension(item.getName());
                            String uploadPath = getServletContext().getRealPath("") + File.separator + "img/employeedashboard/viewCabins";
                            File uploadDir = new File(uploadPath);
                            if (!uploadDir.exists()) {
                                uploadDir.mkdirs();
                            }
                            File uploadedFile = new File(uploadPath + File.separator + fileName);
                            item.write(uploadedFile);
                        }
                    }
                }
                action = multipartParams.get("action");
                System.out.println("Multipart action parameter value: " + action);

            } else {
                action = req.getParameter("action");
                System.out.println("Regular action parameter value: " + action);
            }

            HttpSession session = req.getSession();
            if (session == null || session.getAttribute("user") == null) {
                res.sendRedirect("login.jsp");
                return;
            }
            Users user = (Users) session.getAttribute("user");
            if (!"admin".equals(user.getRole())) {
                req.setAttribute("accessDeniedError", "You are not authorized to access this page.");
                req.getRequestDispatcher("index.jsp").forward(req, res);
                return;
            }

            if ("create".equals(action)) {
                createCabin(req, res, multipartParams, fileName);
            } else if ("update".equals(action)) {
                updateCabin(req, res, multipartParams, fileName);
            } else if ("delete".equals(action)) {
                deleteCabin(req, res, multipartParams);
            } else {
                throw new CabinException("Invalid action on cabin");
            }

        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "Invalid number format.");
            req.getRequestDispatcher("manageCabins.jsp").forward(req, res);
        } catch (CabinException e) {
            req.setAttribute("errorMessage", e.getMessage());
            req.getRequestDispatcher("manageCabins.jsp").forward(req, res);
        } catch (ServletException e) {
            System.err.println("ServletException: " + e.getMessage());
            e.printStackTrace();
            req.setAttribute("errorMessage", "Error processing request.");
            req.getRequestDispatcher("manageCabins.jsp").forward(req, res);
        } catch (IllegalStateException e) {
            if (e.getCause() != null) {
                System.err.println("File size limit exceeded: " + e.getMessage());
                req.setAttribute("errorMessage", "The uploaded image file is too large. Please upload a smaller file.");
                res.sendRedirect("/manageCabins");
                return;
            }
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void createCabin(HttpServletRequest req, HttpServletResponse res, Map<String, String> multipartParams, String fileName) throws ServletException, IOException, CabinException {
        String name = multipartParams.get("cabinName");
        int capacity = Integer.parseInt(multipartParams.get("capacity"));
        String status = multipartParams.get("status");
        System.out.println("Capacity parameter value: '" + multipartParams.get("capacity") + "'");
        Cabins newCabin = new Cabins(name, capacity, status, "img/employeedashboard/viewCabins/" + fileName);
        cabinService.createCabin(newCabin);
        req.getSession().setAttribute("successMessage", "Cabin added successfully.");
        res.sendRedirect("/manageCabins");
    }

    private void updateCabin(HttpServletRequest req, HttpServletResponse res, Map<String, String> multipartParams, String fileName) throws ServletException, IOException, CabinException {
        int id = Integer.parseInt(multipartParams.get("cabinId"));
        String name = multipartParams.get("cabinName");
        int capacity = Integer.parseInt(multipartParams.get("capacity"));
        String status = multipartParams.get("status");
        String imageUrl = null;

        if (fileName != null) {
            imageUrl = "img/employeedashboard/viewCabins/" + fileName;
        } else {
            Cabins existingCabin = cabinService.getCabinById(id);
            if (existingCabin != null) {
                imageUrl = existingCabin.getCabinImageUrl();
            }
        }

        Cabins updatedCabin = new Cabins(id, name, capacity, status, imageUrl);
        cabinService.updateCabin(updatedCabin);
        res.sendRedirect("/manageCabins");
    }

    private void deleteCabin(HttpServletRequest req, HttpServletResponse res, Map<String, String> multipartParams) throws ServletException, IOException, CabinException {
        String cabinIdStr = multipartParams.get("cabinId");

        if (cabinIdStr != null && !cabinIdStr.isEmpty()) {
            try{
                int id = Integer.parseInt(cabinIdStr);
                Cabins cabinToDelete = cabinService.getCabinById(id);

                if (cabinToDelete != null && cabinToDelete.getCabinImageUrl() != null) {
                    // Get the physical file path
                    String imagePath = getServletContext().getRealPath("") + File.separator + cabinToDelete.getCabinImageUrl();
                    File imageFile = new File(imagePath);

                    // Delete the image file if it exists
                    if (imageFile.exists()) {
                        if (imageFile.delete()) {
                            System.out.println("Successfully deleted image file: " + imagePath);
                        } else {
                            System.err.println("Failed to delete image file: " + imagePath);
                        }
                    } else {
                        System.out.println("Image file not found: " + imagePath);
                    }
                }

                cabinService.deleteCabin(id);
                res.sendRedirect("/manageCabins");
            }catch(NumberFormatException e){
                System.err.println("Error parsing cabinId: " + e.getMessage());
                req.setAttribute("errorMessage", "Invalid cabin ID format.");
                res.sendRedirect("/manageCabins");
            }
        } else {
            System.err.println("cabinId parameter is missing or empty.");
            req.setAttribute("errorMessage", "Cabin ID is missing.");
            res.sendRedirect("/manageCabins");
        }
    }
}