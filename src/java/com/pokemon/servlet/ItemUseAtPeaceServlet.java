/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.pokemon.servlet;

import com.pokemon.database.Database;
import com.pokemon.structure.Item;
import com.pokemon.structure.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Sidney
 */
public class ItemUseAtPeaceServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            Object obj = request.getSession().getAttribute("user");
            if (obj == null) {
                out.write("用户未处于登陆状态");
                return;
            }

            String iidStr = request.getParameter("iid");
            if (iidStr == null || iidStr == "") {
                out.write("未选定物品");
                out.close();
                return;
            }
            Integer iid = Integer.parseInt(iidStr);
            User user = (User) obj;
            Database db = Database.getNewDatabase();
            int itemCount = db.getItemCount(user.getUid(), iid.intValue());
            if (itemCount == 0) {
                out.write("无此物品");
                Database.databaseAfterUse(db);
                out.close();
                return;
            }
            // TODO 各种逻辑
            Item item = db.getItem(iid.intValue());
            String effectStr = "";
            --itemCount;
            db.setItemCount(user.getUid(), iid.intValue(), itemCount);
            Database.databaseAfterUse(db);
            out.write("使用了" + item.getName() + "产生了" + effectStr + "的效果");
        } finally { 
            out.close();
        }
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
