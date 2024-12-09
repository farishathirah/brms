package com.WEB;

import com.DAO.BabysitterDAO;
import com.Model.Babysitter;
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
public class BabysitterServlet extends HttpServlet {

    private BabysitterDAO babysitterDAO;
    private static final long serialVersionUID = 1L;

    /**
     *
     */
    @Override
    public void init() {
        babysitterDAO = new BabysitterDAO();
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
                case "prnew":
                    showNewForm(request, response);
                    break;

                case "prinsert":
                    insertBabysitter(request, response);
                    break;

                case "prdelete":
                    deleteBabysitter(request, response);
                    break;

                case "predit":
                    showEditForm(request, response);
                    break;
                    
                case "preditadmin":
                    showEditAdminForm(request, response);
                    break;

                case "prupdate":
                    updateBabysitter(request, response);
                    break;

                case "prupdateprofile":
                    updateProfile(request, response);
                    break;

                case "prlogin":
                    loginBabysitter(request, response);
                    break;

                case "prlist":
                    listBabysitter(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

    }

    private void listBabysitter(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Babysitter> listBabysitter = babysitterDAO.selectAllBabysitters();
        request.setAttribute("listBabysitter", listBabysitter);
        RequestDispatcher dispatcher = request.getRequestDispatcher("BabysitterList.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("BabysitterRegister.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int babyID = Integer.parseInt(request.getParameter("babyID"));
        Babysitter existingBabysitter = babysitterDAO.selectBabysitter(babyID);
        RequestDispatcher dispatcher = request.getRequestDispatcher("BabysitterRegister.jsp");
        request.setAttribute("babysitter", existingBabysitter);
        dispatcher.forward(request, response);
    }
    
    private void showEditAdminForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int babyID = Integer.parseInt(request.getParameter("babyID"));
        Babysitter existingBabysitter = babysitterDAO.selectBabysitter(babyID);
        RequestDispatcher dispatcher = request.getRequestDispatcher("BabysitterAdminUpdate.jsp");
        request.setAttribute("babysitter", existingBabysitter);
        dispatcher.forward(request, response);
    }


    private void insertBabysitter(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String babyName = request.getParameter("babyName");
        String babyUser = request.getParameter("babyUser");
        String babyPass = request.getParameter("babyPass");
        String babyPhone = request.getParameter("babyPhone");
        String babyEmail = request.getParameter("babyEmail");
        InputStream babyPP = null;
        
        Part filePart = request.getPart("babyPP");
        if (filePart != null && filePart.getSize() > 0) {
            babyPP = filePart.getInputStream();
        }
        Babysitter newBabysitter = new Babysitter(babyName, babyUser, babyPass, babyPhone, babyEmail, babyPP);
        babysitterDAO.insertBabysitter(newBabysitter);
        response.sendRedirect("BabysitterSignIn.jsp");
    }

    private void updateBabysitter(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int babyID = Integer.parseInt(request.getParameter("babyID"));
        String babyName = request.getParameter("babyName");
        String babyUser = request.getParameter("babyUser");
        String babyPass = request.getParameter("babyPass");
        String babyPhone = request.getParameter("babyPhone");
        String babyEmail = request.getParameter("babyEmail");
        InputStream babyPP = null;
        
        Part filePart = request.getPart("babyPP");
        if (filePart != null && filePart.getSize() > 0) {
            babyPP = filePart.getInputStream();
        }
        Babysitter babysitter = new Babysitter(babyID, babyName, babyUser, babyPass, babyPhone, babyEmail, babyPP);
        babysitterDAO.updateBabysitter(babysitter);
        response.sendRedirect("BabysitterHomepage.jsp");
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int babyID = Integer.parseInt(request.getParameter("babyID"));
        String babyName = request.getParameter("babyName");
        String babyUser = request.getParameter("babyUser");
        String babyPass = request.getParameter("babyPass");
        String babyPhone = request.getParameter("babyPhone");
        String babyEmail = request.getParameter("babyEmail");
        InputStream babyPP = null;

        // Handle file upload
        Part filePart = request.getPart("babyPP");
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
            babyPP = filePart.getInputStream(); // Get the InputStream for the blob
        }

        Babysitter babysitter = new Babysitter(babyID, babyName, babyUser, babyPass, babyPhone, babyEmail, babyPP);
        babysitterDAO.updateProfile(babysitter);
        response.sendRedirect("BabysitterServlet?action=prlist");
    }

    private void deleteBabysitter(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int babyID = Integer.parseInt(request.getParameter("babyID"));
        babysitterDAO.deleteBabysitter(babyID);
        response.sendRedirect("BabysitterServlet?action=prlist");
    }

    protected void loginBabysitter(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException, SQLException {

    String babyUser = request.getParameter("babyUser");
    String babyPass = request.getParameter("babyPass");

    response.setContentType("text/html");

    if (babyUser != null && babyPass != null) {
        try {
            Babysitter babysitter = babysitterDAO.loginBabysitter(babyUser, babyPass);

            if (babysitter != null) {
                HttpSession loginsession = request.getSession();
                loginsession.setAttribute("babyID", babysitter.getBabyID()); // Use the getter method for babyID
                loginsession.setAttribute("redirect", "true");
                response.sendRedirect("BabysitterHomepage.jsp");
            } else {
                request.setAttribute("errorMessage", "Invalid username or password. Please try again.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("BabysitterSignIn.jsp");
                dispatcher.forward(request, response);
            }

        } catch (SQLException e) {
            request.setAttribute("errorMessage", "An error occurred. Maybe not connected to the database.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("BabysitterSignIn.jsp");
            dispatcher.forward(request, response);
        }
    }
}

}

