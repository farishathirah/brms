/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.WEB;

import com.DAO.ParentDAO;
import com.Model.Parent;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author afrin
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class ParentServlet extends HttpServlet {

    private ParentDAO parentDAO;
    private static final long serialVersionUID = 1L;

    @Override
    public void init() {
        parentDAO = new ParentDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            switch (action) {
                case "pnew":
                    showNewForm(request, response);
                    break;
                case "pinsert":
                    insertParent(request, response);
                    break;
                case "pdelete":
                    deleteParent(request, response);
                    break;
                case "pedit":
                    showEditForm(request, response);
                    break;
                case "peditadmin":
                    showEditAdminForm(request, response);
                    break;
                case "pupdate":
                    updateParent(request, response);
                    break;
                case "pupdateprofile":
                    updateProfile(request, response);
                    break;
                case "plogin":
                    loginParent(request, response);
                    break;
                case "plist":
                    listParent(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void listParent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Parent> listParent = parentDAO.selectAllParents();
        request.setAttribute("listParent", listParent);
        RequestDispatcher dispatcher = request.getRequestDispatcher("ParentList.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("ParentRegister.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int parentID = Integer.parseInt(request.getParameter("parentID"));
        Parent existingParent = parentDAO.selectParent(parentID);
        RequestDispatcher dispatcher = request.getRequestDispatcher("ParentRegister.jsp");
        request.setAttribute("parent", existingParent);
        dispatcher.forward(request, response);
    }

    private void showEditAdminForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int parentID = Integer.parseInt(request.getParameter("parentID"));
        Parent existingParent = parentDAO.selectParent(parentID);
        RequestDispatcher dispatcher = request.getRequestDispatcher("ParentAdminUpdate.jsp");
        request.setAttribute("parent", existingParent);
        dispatcher.forward(request, response);
    }

    private void insertParent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String parentName = request.getParameter("parentName");
        String parentUser = request.getParameter("parentUser");
        String parentPass = request.getParameter("parentPass");
        String parentPhone = request.getParameter("parentPhone");
        String parentEmail = request.getParameter("parentEmail");
        InputStream parentPP = null;

        Part filePart = request.getPart("parentPP");
        if (filePart != null && filePart.getSize() > 0) {
            parentPP = filePart.getInputStream();
        }

        Parent newParent = new Parent(parentName, parentUser, parentPass, parentPhone, parentEmail, parentPP);
        parentDAO.insertParent(newParent);
        response.sendRedirect("ParentSignIn.jsp");
    }

    private void updateParent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int parentID = Integer.parseInt(request.getParameter("parentID"));
        String parentName = request.getParameter("parentName");
        String parentUser = request.getParameter("parentUser");
        String parentPass = request.getParameter("parentPass");
        String parentPhone = request.getParameter("parentPhone");
        String parentEmail = request.getParameter("parentEmail");
        InputStream parentPP = null;

        Part filePart = request.getPart("parentPP");
        if (filePart != null && filePart.getSize() > 0) {
            parentPP = filePart.getInputStream();
        }

        Parent parent = new Parent(parentID, parentName, parentUser, parentPass, parentPhone, parentEmail, parentPP);
        parentDAO.updateParent(parent);
        response.sendRedirect("ParentHomepage.jsp");
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int parentID = Integer.parseInt(request.getParameter("parentID"));
        String parentName = request.getParameter("parentName");
        String parentUser = request.getParameter("parentUser");
        String parentPass = request.getParameter("parentPass");
        String parentPhone = request.getParameter("parentPhone");
        String parentEmail = request.getParameter("parentEmail");
        InputStream parentPP = null;

        // Handle file upload
        Part filePart = request.getPart("parentPP");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String filePath = uploadPath + File.separator + fileName;

            try (InputStream inputStream = filePart.getInputStream(); FileOutputStream outputStream = new FileOutputStream(filePath)) {
                int read;
                final byte[] bytes = new byte[1024];
                while ((read = inputStream.read(bytes)) != -1) {
                    outputStream.write(bytes, 0, read);
                }
            }
            parentPP = filePart.getInputStream(); // Get the InputStream for the blob
        }

        Parent parent = new Parent(parentID, parentName, parentUser, parentPass, parentPhone, parentEmail, parentPP);
        parentDAO.updateProfile(parent);
        response.sendRedirect("ParentServlet?action=plist");
    }

    private void deleteParent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int parentID = Integer.parseInt(request.getParameter("parentID"));
        parentDAO.deleteParent(parentID);
        response.sendRedirect("ParentServlet?action=plist");
    }

    protected void loginParent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String parentUser = request.getParameter("parentUser");
        String parentPass = request.getParameter("parentPass");

        response.setContentType("text/html");

        if (parentUser != null && parentPass != null) {
            try {
                Parent parent = parentDAO.loginParent(parentUser, parentPass);

                if (parent != null) {
                    HttpSession loginsession = request.getSession();
                    loginsession.setAttribute("parentID", parent.getParentID()); // Use the getter method for parentID
                    loginsession.setAttribute("redirect", "true");
                    response.sendRedirect("ParentHomepage.jsp");
                } else {
                    request.setAttribute("errorMessage", "Invalid IC or password. Please try again.");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("ParentSignIn.jsp");
                    dispatcher.forward(request, response);
                }

            } catch (SQLException e) {
                request.setAttribute("errorMessage", "An error occurred. Maybe not connected to the database.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("ParentSignIn.jsp");
                dispatcher.forward(request, response);
            }
        }
    }

}
