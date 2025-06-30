/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.qacha.dao;

import com.qacha.model.Announcement;
import java.sql.*;
import java.util.*;

public class AnnouncementDAO {


public static List<Announcement> getAllAnnouncements() {
    List<Announcement> list = new ArrayList<>();
    try (Connection conn = DBConnection.getConnection()) {
        String sql = "SELECT a.*, at.target_type, at.target_value " +
                     "FROM announcements a " +
                     "LEFT JOIN announcement_targets at ON a.announcement_id = at.announcement_id " +
                     "WHERE a.expiry_date IS NULL OR a.expiry_date >= CURDATE() " +
                     "ORDER BY a.created_at DESC";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Announcement a = new Announcement();
            a.setAnnouncementId(rs.getInt("announcement_id"));
            a.setTitle(rs.getString("title"));
            a.setContent(rs.getString("content"));
            a.setCreatedBy(rs.getInt("created_by"));
            a.setCreatedAt(rs.getTimestamp("created_at"));
            a.setExpiryDate(rs.getDate("expiry_date"));
            a.setPriority(rs.getString("priority"));
            a.setTargetType(rs.getString("target_type"));
            int val = rs.getInt("target_value");
            a.setTargetValue(rs.wasNull() ? null : val);
            list.add(a);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

public static void addAnnouncement(Announcement a) {
    try (Connection conn = DBConnection.getConnection()) {
        conn.setAutoCommit(false);

        String insertAnnouncement = "INSERT INTO announcements (title, content, created_by, expiry_date, priority) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(insertAnnouncement, Statement.RETURN_GENERATED_KEYS);
        ps.setString(1, a.getTitle());
        ps.setString(2, a.getContent());
        ps.setInt(3, a.getCreatedBy());
        ps.setDate(4, a.getExpiryDate());
        ps.setString(5, a.getPriority());
        ps.executeUpdate();

        ResultSet rs = ps.getGeneratedKeys();
        if (rs.next()) {
            int announcementId = rs.getInt(1);

            if (a.getTargetType() != null) {
                String insertTarget = "INSERT INTO announcement_targets (announcement_id, target_type, target_value) VALUES (?, ?, ?)";
                PreparedStatement ps2 = conn.prepareStatement(insertTarget);
                ps2.setInt(1, announcementId);
                ps2.setString(2, a.getTargetType());
                if (a.getTargetValue() != null) {
                    ps2.setInt(3, a.getTargetValue());
                } else {
                    ps2.setNull(3, Types.INTEGER);
                }
                ps2.executeUpdate();
            }
        }

        conn.commit();
    } catch (Exception e) {
        e.printStackTrace();
    }
}

public static void updateAnnouncement(Announcement a) {
    try (Connection conn = DBConnection.getConnection()) {
        conn.setAutoCommit(false);

        String sql = "UPDATE announcements SET title=?, content=?, expiry_date=?, priority=? WHERE announcement_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, a.getTitle());
        ps.setString(2, a.getContent());
        ps.setDate(3, a.getExpiryDate());
        ps.setString(4, a.getPriority());
        ps.setInt(5, a.getAnnouncementId());
        ps.executeUpdate();

        String updateTarget = "REPLACE INTO announcement_targets (announcement_id, target_type, target_value) VALUES (?, ?, ?)";
        PreparedStatement ps2 = conn.prepareStatement(updateTarget);
        ps2.setInt(1, a.getAnnouncementId());
        ps2.setString(2, a.getTargetType());
        if (a.getTargetValue() != null) {
            ps2.setInt(3, a.getTargetValue());
        } else {
            ps2.setNull(3, Types.INTEGER);
        }
        ps2.executeUpdate();

        conn.commit();
    } catch (Exception e) {
        e.printStackTrace();
    }
}

public static void deleteAnnouncement(int id) {
    try (Connection conn = DBConnection.getConnection()) {
        String deleteTarget = "DELETE FROM announcement_targets WHERE announcement_id=?";
        PreparedStatement ps1 = conn.prepareStatement(deleteTarget);
        ps1.setInt(1, id);
        ps1.executeUpdate();

        String deleteAnn = "DELETE FROM announcements WHERE announcement_id=?";
        PreparedStatement ps2 = conn.prepareStatement(deleteAnn);
        ps2.setInt(1, id);
        ps2.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
}