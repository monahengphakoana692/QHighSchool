package com.qacha.controller;

import com.qacha.dao.AnnouncementDAO;
import com.qacha.model.Announcement;
import com.qacha.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/announcement")
public class AnnouncementServlet extends HttpServlet {
@Override
protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
String action = req.getParameter("action");
HttpSession session = req.getSession();
User user = (User) session.getAttribute("user");


    if (user == null || !"principal".equals(user.getRole())) {
        res.sendRedirect("login.jsp");
        return;
    }

    if ("add".equals(action)) {
        Announcement a = new Announcement();
        a.setTitle(req.getParameter("title"));
        a.setContent(req.getParameter("content"));
        a.setCreatedBy(user.getUserId());
        String expiry = req.getParameter("expiryDate");
        if (expiry != null && !expiry.isEmpty()) {
            a.setExpiryDate(Date.valueOf(expiry));
        }
        a.setPriority(req.getParameter("priority"));
        AnnouncementDAO.addAnnouncement(a);
    } else if ("edit".equals(action)) {
        Announcement a = new Announcement();
        a.setAnnouncementId(Integer.parseInt(req.getParameter("announcementId")));
        a.setTitle(req.getParameter("title"));
        a.setContent(req.getParameter("content"));
        a.setPriority(req.getParameter("priority"));
        String expiry = req.getParameter("expiryDate");
        if (expiry != null && !expiry.isEmpty()) {
            a.setExpiryDate(Date.valueOf(expiry));
        }
        AnnouncementDAO.updateAnnouncement(a);
    } else if ("delete".equals(action)) {
        int id = Integer.parseInt(req.getParameter("announcementId"));
        AnnouncementDAO.deleteAnnouncement(id);
    }

    res.sendRedirect("announcements.jsp");
}
}