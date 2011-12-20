/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.pokemon.servlet;

import com.pokemon.database.Database;
import com.pokemon.others.ChatController;
import com.pokemon.structure.User;
import java.io.IOException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Sidney
 */
public class SetRightsServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        Object object = session.getAttribute("user");
        if (object == null)
            return;
        User user = (User)object;
        if (user.getType() != User.GM && user.getType() != User.ADMIN)
            return;
        String userStr = request.getParameter("uid");
        if (userStr == null ||  "".equals(userStr))
            return;
        String rightsStr = request.getParameter("rights");
        if (rightsStr == null || "".equals(rightsStr))
            return;
        int uid = Integer.parseInt(userStr);
        int rights = Integer.parseInt(rightsStr);
        Database db = Database.getNewDatabase();
        db.setUserRights(uid, rights);
        Database.databaseAfterUse(db);

        Boolean canChat = (rights & User.CHAT_RIGHTS) == User.CHAT_RIGHTS;
        ServletContext application = session.getServletContext();
        Object obj = application.getAttribute("chatcontroller");
        if (obj == null) {
            obj = new ChatController();
            application.setAttribute("chatcontroller", obj);
        }
        ((ChatController)obj).setPermit(uid, canChat);
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
